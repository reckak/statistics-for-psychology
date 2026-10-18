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
  # 7. Exact endpoint comparisons and both neighboring decisions, without rounding
  # or numerical tolerance in the workbook's decision rule. Set the bound from
  # Excel's own unrounded limit so quantile implementation error is irrelevant.
  $sh=$taskBook.Worksheets.Item('Ekvivalence')
  $yes=[string]$spec.texts[1].expected
  $no=[string]($spec.changes|Where-Object {$_.sheet -eq 'Ekvivalence' -and $_.set.B4 -eq 46}|Select-Object -First 1).labels.B20
  $boundaryChecks=0
  foreach($side in @(-1,1)){
    $sh.Range('B4').Value2=50+1.5*$side
    $taskExcel.CalculateFullRebuild()
    $limit=if($side -eq -1){'B18'}else{'B19'}
    $bound=if($side -eq -1){'B11'}else{'B12'}
    $delta=[math]::Abs(50-[double]$sh.Range($limit).Value2)
    foreach($shift in @(-0.000001,0,0.000001)){
      $sh.Range('B3').Value2=$delta+$shift
      $taskExcel.CalculateFullRebuild()
      $expected=if($shift -lt 0){$no}else{$yes}
      if([string]$sh.Range('B20').Value2 -cne $expected){throw "Wrong TOST boundary decision: side=$side shift=$shift"}
      if($shift -eq 0){
        if($sh.Range($limit).Value2 -ne $sh.Range($bound).Value2){throw 'Boundary case is not exact'}
        Assert-Cell $sh 'B26' .05 1e-10
      }
      $boundaryChecks++
    }
  }
  $sh.Range('B3').Value2=3.0;$sh.Range('B4').Value2=48.5
  # Equality p = alpha in the difference-test decision, then both neighbors.
  $taskExcel.CalculateFullRebuild();$p=[double]$sh.Range('B16').Value2
  foreach($shift in @(-0.000001,0,0.000001)){
    $sh.Range('B7').Value2=$p+$shift;$taskExcel.CalculateFullRebuild()
    $expected=if($shift -lt 0){[string]($spec.changes|Where-Object {$_.sheet -eq 'Ekvivalence' -and $_.set.B4 -eq 46}|Select-Object -First 1).labels.B17}else{[string]$spec.texts[0].expected}
    if([string]$sh.Range('B17').Value2 -cne $expected){throw "Wrong difference-test boundary: shift=$shift"}
    $boundaryChecks++
  }
  $sh.Range('B7').Value2=.05;$taskExcel.CalculateFullRebuild();Assert-Stored
  $wrap=$taskBook.Worksheets.Item('Interval_z').Range('A3')
  if(-not $wrap.WrapText -or $wrap.RowHeight -lt 30){throw 'Model assumption label is not wrapped'}
  [pscustomobject]@{Cells=@($spec.cells).Count;Formulas=@($spec.formulas).Count;Errors=@($spec.errors).Count;ChangedResults=$changed;ChangedLabels=$labels;BoundaryDecisions=$boundaryChecks;LocalFormulas=@($spec.locals).Count;ExcelVersion=$taskExcel.Version;Saved=$false}|ConvertTo-Json -Compress
} finally {
  if($null -ne $taskBook){$taskBook.Close($false);[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($taskBook)}
  if($null -ne $taskExcel){$taskExcel.Quit();[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($taskExcel)}
}
