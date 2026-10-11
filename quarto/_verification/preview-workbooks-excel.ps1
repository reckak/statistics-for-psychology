param([string]$OutputDirectory='tmp/workbook-previews',[int[]]$Chapter=@(1,2,3,4,5),[string[]]$Sheet=@())
# Read-only native Excel previews: every tab, first 15 rows of input datasets,
# entire worked examples/overview. Print settings are never saved to the XLSX.
$ErrorActionPreference='Stop'
$taskRoot=(Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
$out=Join-Path $taskRoot $OutputDirectory
[void](New-Item -ItemType Directory -Force -Path $out)
$taskExcel=$null;$taskBook=$null;$catalog=@()
try {
  $taskExcel=New-Object -ComObject Excel.Application
  $taskExcel.Visible=$false;$taskExcel.DisplayAlerts=$false
  foreach($n in $Chapter){
    $folder=if($n -eq 4){'chapter-04'}else{'chapter-{0:00}-build' -f $n}
    $inputs=Get-Content -LiteralPath (Join-Path $taskRoot "tmp/$folder/inputs.json") -Encoding UTF8 -Raw|ConvertFrom-Json
    $inputNames=@($inputs|ForEach-Object {$_.name})
    $taskBook=$taskExcel.Workbooks.Open((Join-Path $taskRoot ('data/kapitola_{0:00}.xlsx' -f $n)),0,$true)
    foreach($sh in $taskBook.Worksheets){
      if($Sheet.Count -and $sh.Name -notin $Sheet){continue}
      $last=$sh.Cells.Find('*',$sh.Cells.Item(1,1),-4123,2,1,2,$false)
      $lastRow=$last.Row
      $last=$sh.Cells.Find('*',$sh.Cells.Item(1,1),-4123,2,2,2,$false)
      $lastCol=$last.Column
      if($sh.Name -in $inputNames){$lastRow=[math]::Max(7,[math]::Min(15,$lastRow))}
      # Include merged notes and text spilling into empty columns.
      foreach($cell in $sh.UsedRange.Cells){if($cell.MergeCells){$lastCol=[math]::Max($lastCol,$cell.MergeArea.Column+$cell.MergeArea.Columns.Count-1)}}
      if($n -eq 2 -and $sh.Name -eq 'Data'){$lastCol=15}
      foreach($co in $sh.ChartObjects()){$lastRow=[math]::Max($lastRow,$co.BottomRightCell.Row);$lastCol=[math]::Max($lastCol,$co.BottomRightCell.Column)}
      $sh.PageSetup.PrintArea=$sh.Range($sh.Cells.Item(1,1),$sh.Cells.Item($lastRow,$lastCol)).Address()
      $sh.PageSetup.Orientation=2;$sh.PageSetup.PaperSize=8
      $sh.PageSetup.Zoom=$false;$sh.PageSetup.FitToPagesWide=1;$sh.PageSetup.FitToPagesTall=1
      $sh.PageSetup.LeftMargin=14;$sh.PageSetup.RightMargin=14;$sh.PageSetup.TopMargin=14;$sh.PageSetup.BottomMargin=14
      $sh.PageSetup.PrintGridlines=$true;$sh.PageSetup.PrintHeadings=$true
      $name='{0:00}-{1}.pdf' -f $n,$sh.Name
      $sh.ExportAsFixedFormat(0,(Join-Path $out $name))
      $catalog+=@{chapter=$n;sheet=$sh.Name;file=$name;range=$sh.PageSetup.PrintArea}
    }
    $taskBook.Close($false);[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($taskBook);$taskBook=$null
    Write-Output "Chapter $n previews complete"
  }
  $indexPath=Join-Path $out 'index.json'
  if(Test-Path -LiteralPath $indexPath){
    $keys=@($catalog|ForEach-Object {'{0}:{1}' -f $_.chapter,$_.sheet})
    $previous=Get-Content -LiteralPath $indexPath -Encoding UTF8 -Raw|ConvertFrom-Json
    $catalog=@($previous|Where-Object {('{0}:{1}' -f $_.chapter,$_.sheet) -notin $keys})+@($catalog)
  }
  $catalog|Sort-Object chapter,sheet|ConvertTo-Json|Set-Content -LiteralPath $indexPath -Encoding UTF8
} finally {
  if($null -ne $taskBook){$taskBook.Close($false)}
  if($null -ne $taskExcel){$taskExcel.Quit();[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($taskExcel)}
}
