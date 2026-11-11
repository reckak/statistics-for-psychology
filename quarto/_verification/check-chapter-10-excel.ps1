# Chapter 10 workbook in a separate hidden instance of desktop Excel. Nothing is saved.
# ASCII only: Czech formulas and expected values are read from check-chapter-10-excel.json
# (generated in base R by check-chapter-10-excel-expected.R with the same fixed resampling indices).
$ErrorActionPreference='Stop'
$taskRoot=(Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
$spec=Get-Content -LiteralPath (Join-Path $PSScriptRoot 'check-chapter-10-excel.json') -Raw -Encoding UTF8 | ConvertFrom-Json
$taskExcel=$null;$taskBook=$null;$checks=0
function Assert-Cell($c){
  $sh=$taskBook.Worksheets.Item([string]$c.sheet);$actual=$sh.Range([string]$c.cell).Value2;$e=[double]$c.value
  if($null -eq $actual -or $actual -is [string] -or [math]::Abs([double]$actual-$e) -gt [double]$c.tol*[math]::Max(1,[math]::Abs($e))){
    throw "Wrong value $($c.sheet)!$($c.cell): $actual; expected $e"}
  $script:checks++
}
# The leading comma keeps a multi-cell Range from being unrolled into single cells.
function Get-Range($ref){$p=([string]$ref).Split('!');return ,$taskBook.Worksheets.Item($p[0]).Range($p[1])}
try {
  $taskExcel=New-Object -ComObject Excel.Application
  $taskExcel.Visible=$false;$taskExcel.DisplayAlerts=$false
  $taskBook=$taskExcel.Workbooks.Open((Join-Path $taskRoot 'data/kapitola_10.xlsx'),0,$true)
  if($taskBook.Worksheets.Item(1).Name -ne 'Prehled'){throw 'Overview is not first'}
  $taskExcel.Calculation=-4105;$taskExcel.CalculateFullRebuild()
  # 1. Stored results of all calculation sheets against base R.
  foreach($c in $spec.stored){Assert-Cell $c}
  # 2. Kendall sums over all pairs must be dynamic-array formulas; a legacy entry silently computes a wrong sum.
  foreach($ref in 'Permutace!B3','Permutace!C13','Bootstrap!C13','Perm_presna!T11','BCa!B2'){
    $cell=Get-Range $ref
    if(-not $cell.HasFormula -or $cell.HasArray -or ([string]$cell.Formula2) -match '@'){throw "Not a dynamic-array formula: $ref"}
  }
  $probe=$taskBook.Worksheets.Item('Permutace').Range('Z1')
  $probe.FormulaLocal=[string]$taskBook.Worksheets.Item('Permutace').Range('B3').Formula2Local;$taskExcel.Calculate()
  $legacy=$probe.Value2;$probe.ClearContents()
  if([math]::Abs([double]$legacy-(-146)) -lt 1e-9){throw 'Legacy entry unexpectedly gives the dynamic-array result; review the version note'}
  # 3. Czech formulas quoted in the chapter and its solutions, entered as a student would type them.
  foreach($f in $spec.formulas){
    $scratch=$taskBook.Worksheets.Item([string]$f.sheet).Range('ZZ1000')
    $scratch.Formula2Local=[string]$f.formula;$taskExcel.Calculate()
    if($taskExcel.WorksheetFunction.IsError($scratch)){throw "Formula returned an error: $($f.formula)"}
    if([math]::Abs([double]$scratch.Value2-[double]$f.value) -gt [double]$f.tol){throw "Formula $($f.formula): $($scratch.Value2); expected $($f.value)"}
    $scratch.ClearContents();$checks++
  }
  # 4. Exercise scenarios: change inputs, check results, restore the original inputs.
  foreach($s in $spec.scenarios){
    $saved=New-Object System.Collections.ArrayList
    foreach($i in $s.inputs){
      $rows=@($i.values).Count;$cols=@($i.values[0]).Count
      $r=(Get-Range "$($i.sheet)!$($i.cell)").Resize($rows,$cols)
      [void]$saved.Add(@{Range=$r;Value=$r.Value2})
      $block=New-Object 'object[,]' $rows,$cols
      for($a=0;$a -lt $rows;$a++){for($b=0;$b -lt $cols;$b++){$block[$a,$b]=[double]@($i.values[$a])[$b]}}
      $r.Value2=$block
    }
    foreach($ref in $s.clear){$r=Get-Range $ref;[void]$saved.Add(@{Range=$r;Value=$r.Value2});[void]$r.ClearContents()}
    $taskExcel.Calculate()
    foreach($c in $s.checks){Assert-Cell $c}
    for($k=$saved.Count-1;$k -ge 0;$k--){$saved[$k].Range.Value2=$saved[$k].Value}
    $taskExcel.Calculate()
    Write-Host "Scenario passed: $($s.name)"
  }
  # 5. Original results return after all scenarios.
  foreach($c in $spec.stored){Assert-Cell $c}
  [pscustomobject]@{Workbook='kapitola_10.xlsx';Checks=$checks;Scenarios=@($spec.scenarios).Count;ExcelVersion=$taskExcel.Version;Saved=$false}|ConvertTo-Json -Compress
} finally {
  if($null -ne $taskBook){$taskBook.Close($false)}
  if($null -ne $taskExcel){$taskExcel.Quit();[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($taskExcel)}
}
