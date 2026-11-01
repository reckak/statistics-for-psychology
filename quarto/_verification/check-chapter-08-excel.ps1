# Chapter 8 workbook in a separate hidden instance of desktop Excel. Nothing is saved.
# ASCII only: Czech formulas and expected values are read from check-chapter-08-excel.json.
$ErrorActionPreference='Stop'
$taskRoot=(Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
$spec=Get-Content -LiteralPath (Join-Path $PSScriptRoot 'check-chapter-08-excel.json') -Raw -Encoding UTF8 | ConvertFrom-Json
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
  $taskBook=$taskExcel.Workbooks.Open((Join-Path $taskRoot 'data/kapitola_08.xlsx'),0,$true)
  if($taskBook.Worksheets.Item(1).Name -ne 'Prehled'){throw 'Overview is not first'}
  $taskExcel.CalculateFullRebuild()
  # 1. Every stored result of the calculation sheets, including both test decisions.
  Assert-Stored
  # 2. The incomplete pair stays empty in its own row; the input cell is really empty.
  foreach($b in $spec.blanks){
    $v=$taskBook.Worksheets.Item([string]$b.sheet).Range([string]$b.cell).Value2
    if($null -ne $v -and [string]$v -ne ''){throw "Expected an empty cell $($b.sheet)!$($b.cell): $v"}
  }
  # 3. Czech formulas quoted in the chapter and its solutions, entered as a student would type them.
  $scratch=$taskBook.Worksheets.Item('Klasicky_test').Range('H40')
  foreach($f in $spec.formulas){
    $scratch.FormulaLocal=[string]$f.formula;$taskExcel.Calculate()
    if($taskExcel.WorksheetFunction.IsError($scratch)){throw "Formula returned an error: $($f.formula)"}
    if([math]::Abs([double]$scratch.Value2-[double]$f.expected) -gt (Get-Tolerance $f)){throw "Formula $($f.formula): $($scratch.Value2); expected $($f.expected)"}
  }
  # 4. Inadmissible arguments must give an Excel error, not a number.
  foreach($f in $spec.errors){
    $scratch.FormulaLocal=[string]$f;$taskExcel.Calculate()
    if(-not $taskExcel.WorksheetFunction.IsError($scratch)){throw "Expected an Excel error: $f"}
  }
  [void]$scratch.Clear()
  # 5. Changed yellow inputs flow through the dependent formulas; originals are restored.
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
  # 6. The formulas really are the Czech ones shown to students.
  foreach($l in $spec.locals){
    $local=$taskBook.Worksheets.Item([string]$l.sheet).Range([string]$l.cell).FormulaLocal
    if($local -cne [string]$l.formula){throw "Unexpected local formula $($l.sheet)!$($l.cell): $local"}
  }
  # 7. Welch interval uses the exact quantile: B15 differs from the truncated T.INV.2T in B20.
  $w=$taskBook.Worksheets.Item('Welch')
  if([math]::Abs([double]$w.Range('B15').Value2-[double]$w.Range('B20').Value2) -lt 1e-3){throw 'Welch quantile looks truncated'}
  # 8. Exact equivalence boundary: touching the bound counts as equivalence, a hair inside the band does not.
  $sh=$taskBook.Worksheets.Item('Ekvivalence_skupin');$boundaryChecks=0
  $limit=[math]::Abs([double]$sh.Range('B19').Value2)
  foreach($shift in @(-0.000001,0,0.000001)){
    $sh.Range('B2').Value2=$limit+$shift;$taskExcel.CalculateFullRebuild()
    $expected=[string]($spec.changes|Where-Object {$_.sheet -eq 'Ekvivalence_skupin' -and $_.set.B5 -eq 30}|Select-Object -First 1).labels.B21
    if($shift -ge 0){$expected=[string]$spec.texts[1].expected}
    if([string]$sh.Range('B21').Value2 -cne $expected){throw "Wrong TOST boundary decision: shift=$shift"}
    $boundaryChecks++
  }
  $sh.Range('B2').Value2=3.0;$taskExcel.CalculateFullRebuild();Assert-Stored
  [pscustomobject]@{Cells=@($spec.cells).Count;Formulas=@($spec.formulas).Count;Errors=@($spec.errors).Count;ChangedResults=$changed;ChangedLabels=$labels;BoundaryDecisions=$boundaryChecks;LocalFormulas=@($spec.locals).Count;ExcelVersion=$taskExcel.Version;Saved=$false}|ConvertTo-Json -Compress
} finally {
  if($null -ne $taskBook){$taskBook.Close($false);[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($taskBook)}
  if($null -ne $taskExcel){$taskExcel.Quit();[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($taskExcel)}
}
