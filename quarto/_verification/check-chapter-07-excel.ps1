# Chapter 7 workbook in a separate hidden instance of desktop Excel. Nothing is saved.
# ASCII only: Czech formulas and expected values are read from check-chapter-07-excel.json.
$ErrorActionPreference='Stop'
$taskRoot=(Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
$spec=Get-Content -LiteralPath (Join-Path $PSScriptRoot 'check-chapter-07-excel.json') -Raw -Encoding UTF8 | ConvertFrom-Json
$taskExcel=$null;$taskBook=$null
function Get-Tolerance($item,$default=1e-9){if($null -ne $item.tolerance){[double]$item.tolerance}else{$default}}
function Assert-Cell($sheet,$address,$expected,$tolerance=1e-9){
  $actual=$sheet.Range($address).Value2
  if($null -eq $actual -or $actual -is [string] -or [math]::Abs([double]$actual-[double]$expected) -gt $tolerance){throw "Wrong value $($sheet.Name)!${address}: $actual; expected $expected"}
}
function Assert-Stored{
  foreach($c in $spec.cells){Assert-Cell $taskBook.Worksheets.Item([string]$c.sheet) ([string]$c.cell) $c.expected (Get-Tolerance $c)}
  foreach($t in $spec.texts){
    $actual=$taskBook.Worksheets.Item([string]$t.sheet).Range([string]$t.cell).Value2
    if($actual -cne [string]$t.expected){throw "Wrong text $($t.sheet)!$($t.cell): $actual"}
  }
}
try {
  $taskExcel=New-Object -ComObject Excel.Application
  $taskExcel.Visible=$false;$taskExcel.DisplayAlerts=$false
  $taskBook=$taskExcel.Workbooks.Open((Join-Path $taskRoot 'data/kapitola_07.xlsx'),0,$true)
  if($taskBook.Worksheets.Item(1).Name -ne 'Prehled'){throw 'Overview is not first'}
  $taskExcel.CalculateFullRebuild()
  # 1. Every stored result of the calculation sheets, including the test decisions.
  Assert-Stored
  # 2. Czech formulas quoted in the chapter and its solutions, entered as a student would type them.
  $scratch=$taskBook.Worksheets.Item('Interval_z').Range('H30')
  foreach($f in $spec.formulas){
    $scratch.FormulaLocal=[string]$f.formula;$taskExcel.Calculate()
    if($taskExcel.WorksheetFunction.IsError($scratch)){throw "Formula returned an error: $($f.formula)"}
    if([math]::Abs([double]$scratch.Value2-[double]$f.expected) -gt (Get-Tolerance $f)){throw "Formula $($f.formula): $($scratch.Value2); expected $($f.expected)"}
  }
  # 3. Inadmissible arguments must give an Excel error, not a number.
  foreach($f in $spec.errors){
    $scratch.FormulaLocal=[string]$f;$taskExcel.Calculate()
    if(-not $taskExcel.WorksheetFunction.IsError($scratch)){throw "Expected an Excel error: $f"}
  }
  [void]$scratch.Clear()
  # 4. Changed yellow inputs flow through the dependent formulas; originals are restored.
  $changed=0;$labels=0
  foreach($ch in $spec.changes){
    $sh=$taskBook.Worksheets.Item([string]$ch.sheet);$old=@{}
    foreach($p in $ch.set.PSObject.Properties){$old[$p.Name]=$sh.Range($p.Name).Value2;$sh.Range($p.Name).Value2=[double]$p.Value}
    $taskExcel.CalculateFullRebuild()
    foreach($p in $ch.expect.PSObject.Properties){Assert-Cell $sh $p.Name $p.Value (Get-Tolerance $ch);$changed++}
    if($null -ne $ch.labels){foreach($p in $ch.labels.PSObject.Properties){
      if([string]$sh.Range($p.Name).Value2 -cne [string]$p.Value){throw "Stale label $($sh.Name)!$($p.Name): $($sh.Range($p.Name).Value2)"}
      $labels++
    }}
    foreach($a in $old.Keys){$sh.Range($a).Value2=[double]$old[$a]}
  }
  $taskExcel.CalculateFullRebuild()
  Assert-Stored
  # 5. The formulas really are the Czech ones shown to students.
  foreach($l in $spec.locals){
    $local=$taskBook.Worksheets.Item([string]$l.sheet).Range([string]$l.cell).FormulaLocal
    if($local -cne [string]$l.formula){throw "Unexpected local formula $($l.sheet)!$($l.cell): $local"}
  }
  # 6. The simulated sheet contains values only.
  foreach($name in @('Sim_intervaly')){
    $used=$taskBook.Worksheets.Item($name).UsedRange
    $hasFormula=$used.HasFormula
    if($hasFormula -eq $true -or $null -eq $hasFormula -or $hasFormula -is [DBNull]){throw "Simulated sheet contains formulas: $name"}
  }
  [pscustomobject]@{Cells=@($spec.cells).Count;Formulas=@($spec.formulas).Count;Errors=@($spec.errors).Count;ChangedResults=$changed;ChangedLabels=$labels;LocalFormulas=@($spec.locals).Count;ExcelVersion=$taskExcel.Version;Saved=$false}|ConvertTo-Json -Compress
} finally {
  if($null -ne $taskBook){$taskBook.Close($false);[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($taskBook)}
  if($null -ne $taskExcel){$taskExcel.Quit();[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($taskExcel)}
}
