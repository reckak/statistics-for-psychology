param([switch]$Finalize)
# Hidden, separate Excel instance. No interaction with the user's open workbooks.
$ErrorActionPreference='Stop'
$taskRoot=(Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
$taskExcel=$null;$taskBook=$null
try {
  $taskExcel=New-Object -ComObject Excel.Application
  $taskExcel.Visible=$false;$taskExcel.DisplayAlerts=$false
  foreach($n in 1,2,3,4,5){
    $taskBook=$taskExcel.Workbooks.Open((Join-Path $taskRoot ('data/kapitola_{0:00}.xlsx' -f $n)),0,$false)
    if($taskBook.Worksheets.Item(1).Name -ne 'Prehled'){throw 'Overview is not first'}
    $taskExcel.CalculateFullRebuild()
    $formulaCount=0
    foreach($sh in $taskBook.Worksheets){
      foreach($cell in $sh.UsedRange.Cells){
        if($cell.HasFormula){$formulaCount++;if($cell.Text -match '^#'){throw "Excel error: $n $($sh.Name) $($cell.Address()) $($cell.Text)"}}
      }
    }
    if($Finalize){
      $taskBook.Worksheets.Item('Prehled').Activate()
      $taskBook.Worksheets.Item('Prehled').Range('A1').Select()
      $taskBook.Save()
    }
    [pscustomobject]@{Chapter=$n;Sheets=$taskBook.Worksheets.Count;FormulasChecked=$formulaCount;ExcelVersion=$taskExcel.Version;Saved=[bool]$Finalize}|ConvertTo-Json -Compress
    $taskBook.Close($false);[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($taskBook);$taskBook=$null
  }
} finally {
  if($null -ne $taskBook){$taskBook.Close($false)}
  if($null -ne $taskExcel){$taskExcel.Quit();[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($taskExcel)}
}
