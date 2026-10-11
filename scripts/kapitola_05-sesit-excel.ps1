# Builds data/kapitola_05.xlsx from tmp/chapter-05-build/build.json in a separate hidden
# instance of desktop Excel. ASCII only: every Czech label and formula comes from the JSON
# written by the chapter 5 workbook generator (.mjs), so Windows PowerShell 5.1 needs no BOM here.
$ErrorActionPreference='Stop'
$taskRoot=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$spec=Get-Content -LiteralPath (Join-Path $taskRoot 'tmp/chapter-05-build/build.json') -Raw -Encoding UTF8 | ConvertFrom-Json
$target=Join-Path $taskRoot ('data/kapitola_{0:00}.xlsx' -f $spec.chapter)
function Rgb($hex){$h=$hex.TrimStart('#');[Convert]::ToInt32($h.Substring(4,2)+$h.Substring(2,2)+$h.Substring(0,2),16)}
function Col($n){[string][char](64+$n)}
$ink=Rgb '#223744';$head=Rgb '#234F62';$white=Rgb '#FFFFFF';$inputFill=Rgb '#FFF1CB';$calcFill=Rgb '#EAF4F8';$muted=Rgb '#526775'
$taskExcel=$null;$taskBook=$null
try {
  $taskExcel=New-Object -ComObject Excel.Application
  $taskExcel.Visible=$false;$taskExcel.DisplayAlerts=$false
  $taskBook=$taskExcel.Workbooks.Add()
  # Through PowerShell automation NumberFormat is read with the local separators, so the
  # invariant codes of the declarations are translated explicitly (decimal, thousands, General).
  $decimal=[string]$taskExcel.International(3);$thousands=[string]$taskExcel.International(4);$general=[string]$taskExcel.International(26)
  function Local-Format($code){if($code -eq 'General'){$general}else{$code.Replace(',',[string][char]1).Replace('.',$decimal).Replace([string][char]1,$thousands)}}
  while($taskBook.Worksheets.Count -gt 1){$taskBook.Worksheets.Item($taskBook.Worksheets.Count).Delete()}
  $overview=$taskBook.Worksheets.Item(1);$overview.Name='Prehled'
  function Add-Sheet($name){$sh=$taskBook.Worksheets.Add([Type]::Missing,$taskBook.Worksheets.Item($taskBook.Worksheets.Count));$sh.Name=$name;$sh}
  function Style-Head($r){$r.Interior.Color=$head;$r.Font.Color=$white;$r.Font.Bold=$true;$r.WrapText=$true}
  # Calculation sheets: yellow inputs, blue Czech formulas entered through FormulaLocal.
  foreach($s in $spec.sheets){
    $sh=Add-Sheet $s.name
    $sh.Cells.Font.Name='Arial';$sh.Cells.Font.Size=11;$sh.Cells.Font.Color=$ink;$sh.Cells.VerticalAlignment=-4108
    foreach($w in $s.widths.PSObject.Properties){$sh.Columns.Item($w.Name).ColumnWidth=[double]$w.Value}
    foreach($c in $s.cells){
      $r=$sh.Range($c[0]);$kind=$c[1];$value=$c[2]
      # Separate statements for text and numbers: one COM call site must not see both types.
      if($value -is [string]){if($value.StartsWith('=')){$r.FormulaLocal=$value}else{$r.Value2=[string]$value}}else{$r.Value2=[double]$value}
      switch($kind){
        'head'{Style-Head $r;$r.RowHeight=34}
        'input'{$r.Interior.Color=$inputFill;$r.NumberFormatLocal=(Local-Format $c[3])}
        'calc'{$r.Interior.Color=$calcFill;$r.NumberFormatLocal=(Local-Format $c[3])}
        'note'{$r.Font.Color=$muted}
      }
    }
    $sh.Activate();$taskExcel.ActiveWindow.DisplayGridlines=$true
  }
  # Student input sheets: one table per sheet, with its use and origin beside it.
  $catalog=@()
  foreach($s in $spec.inputs){
    $sh=Add-Sheet $s.name
    $cols=@($s.headers).Count;$rows=@($s.rows).Count;$last=$rows+1;$end=Col $cols
    $all=$sh.Range("A1:$end$last")
    $all.Font.Name='Arial';$all.Font.Size=11;$all.Font.Color=$ink;$all.VerticalAlignment=-4108;$all.RowHeight=25
    for($j=0;$j -lt $cols;$j++){
      $sh.Cells.Item(1,$j+1).Value2=[string]@($s.headers)[$j]
      $width=22
      for($i=0;$i -lt $rows;$i++){
        $v=@(@($s.rows)[$i])[$j]
        if($v -is [string]){$sh.Cells.Item($i+2,$j+1).Value2=[string]$v}elseif($null -ne $v){$sh.Cells.Item($i+2,$j+1).Value2=[double]$v}
        if($v -is [string] -and $v.Length+2 -gt $width){$width=[math]::Min(48,$v.Length+2)}
      }
      $sh.Columns.Item($j+1).ColumnWidth=$width
    }
    Style-Head $sh.Range("A1:${end}1");$sh.Range("A1:${end}1").RowHeight=46
    $data=$sh.Range("A2:$end$last");$data.Interior.Color=$inputFill;$data.WrapText=$true;$data.NumberFormatLocal=$general
    $nc=Col ($cols+2)
    $note=$sh.Range("${nc}1:${nc}7");$note.Font.Name='Arial';$note.Font.Size=11;$note.Font.Color=$muted;$note.WrapText=$true;$note.VerticalAlignment=-4160
    $sh.Columns.Item($cols+2).ColumnWidth=60
    $sh.Range("${nc}1").Value2=[string]$spec.noteTitle
    [void]$sh.Range("${nc}2:${nc}3").Merge();$sh.Range("${nc}2").Value2=[string]$s.use
    [void]$sh.Range("${nc}4:${nc}7").Merge();$sh.Range("${nc}4").Value2=[string]$s.note
    $sh.Activate();$taskExcel.ActiveWindow.FreezePanes=$false;[void]$sh.Range('A2').Select();$taskExcel.ActiveWindow.FreezePanes=$true
    $catalog+=,@($s.name,"A2:$end$last",[string]$s.use)
  }
  foreach($e in $spec.existing){$catalog+=,@([string]$e[0],[string]$e[1],[string]$e[2])}
  # Overview: the same wording and layout as the other chapter workbooks.
  $n=$catalog.Count
  $o=$overview.Range("A1:C$($n+10)");$o.Font.Name='Arial';$o.Font.Size=11;$o.Font.Color=$ink;$o.VerticalAlignment=-4108;$o.RowHeight=30
  $t=$spec.overview
  [void]$overview.Range('A1:C1').Merge();$overview.Range('A1').Value2=[string]$t[0];$overview.Range('A1').Font.Bold=$true;$overview.Range('A1').Font.Size=16
  for($k=1;$k -le 4;$k++){[void]$overview.Range("A$($k+2):C$($k+2)").Merge();$overview.Range("A$($k+2)").Value2=[string]$t[$k]}
  $overview.Range('A7').Value2=[string]$t[5];$overview.Range('B7').Value2=[string]$t[6];$overview.Range('C7').Value2=[string]$t[7]
  Style-Head $overview.Range('A7:C7')
  for($i=0;$i -lt $n;$i++){for($j=0;$j -lt 3;$j++){$overview.Cells.Item($i+8,$j+1).Value2=[string]$catalog[$i][$j]}}
  $overview.Columns.Item(1).ColumnWidth=25;$overview.Columns.Item(2).ColumnWidth=25;$overview.Columns.Item(3).ColumnWidth=78
  $overview.Activate();$taskExcel.ActiveWindow.DisplayGridlines=$false
  $taskExcel.ActiveWindow.FreezePanes=$false;[void]$overview.Range('A8').Select();$taskExcel.ActiveWindow.FreezePanes=$true;[void]$overview.Range('A1').Select()
  $taskExcel.CalculateFullRebuild()
  $formulas=0
  foreach($sh in $taskBook.Worksheets){foreach($cell in $sh.UsedRange.Cells){if($cell.HasFormula){$formulas++;if($cell.Text -match '^#'){throw "Excel error: $($sh.Name) $($cell.Address()) $($cell.Text)"}}}}
  $taskBook.RemovePersonalInformation=$true
  if(Test-Path -LiteralPath $target){Remove-Item -LiteralPath $target -Confirm:$false}
  $taskBook.SaveAs($target,51)
  [pscustomobject]@{Workbook=$target;Sheets=$taskBook.Worksheets.Count;Formulas=$formulas;ExcelVersion=$taskExcel.Version}|ConvertTo-Json -Compress
} finally {
  if($null -ne $taskBook){$taskBook.Close($false);[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($taskBook)}
  if($null -ne $taskExcel){$taskExcel.Quit();[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($taskExcel)}
}
