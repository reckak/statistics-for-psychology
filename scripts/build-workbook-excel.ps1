param([Parameter(Mandatory=$true)][string]$Manifest)
# ASCII source; all Czech text arrives as UTF-8 JSON. Uses a private Excel instance.
$ErrorActionPreference='Stop'
$taskRoot=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$spec=Get-Content -LiteralPath $Manifest -Raw -Encoding UTF8 | ConvertFrom-Json
if($spec.chapter -notin 1,2,3,4,5,6,7){throw 'Unsupported chapter'}
$target=Join-Path $taskRoot ('data/kapitola_{0:00}.xlsx' -f $spec.chapter)
$staged=Join-Path (Split-Path -Parent $Manifest) 'workbook.xlsx'
$taskExcel=$null;$taskBook=$null
function Rgb($hex){$h=$hex.TrimStart('#');[Convert]::ToInt32($h.Substring(4,2)+$h.Substring(2,2)+$h.Substring(0,2),16)}
function Set-Format($r,$format){
  foreach($p in $format.PSObject.Properties){
    switch($p.Name){
      'fill' {$r.Interior.Color=Rgb $p.Value}
      'rowHeight' {$r.RowHeight=[double]$p.Value}
      'columnWidth' {$r.ColumnWidth=[double]$p.Value}
      'wrapText' {$r.WrapText=[bool]$p.Value}
      'verticalAlignment' {$r.VerticalAlignment=@{center=-4108;top=-4160;bottom=-4107}[$p.Value]}
      'horizontalAlignment' {$r.HorizontalAlignment=@{center=-4108;left=-4131;right=-4152}[$p.Value]}
      'font' {
        foreach($f in $p.Value.PSObject.Properties){switch($f.Name){
          'name' {$r.Font.Name=[string]$f.Value}
          'size' {$r.Font.Size=[double]$f.Value}
          'bold' {$r.Font.Bold=[bool]$f.Value}
          'italic' {$r.Font.Italic=[bool]$f.Value}
          'color' {$r.Font.Color=Rgb $f.Value}
          default {throw "Unsupported font property: $($f.Name)"}
        }}
      }
      default {throw "Unsupported format property: $($p.Name)"}
    }
  }
}
try {
  $taskExcel=New-Object -ComObject Excel.Application
  $taskExcel.Visible=$false;$taskExcel.DisplayAlerts=$false
  $taskBook=$taskExcel.Workbooks.Add()
  while($taskBook.Worksheets.Count -gt 1){$taskBook.Worksheets.Item($taskBook.Worksheets.Count).Delete()}
  # Create all tabs before assigning cross-sheet formulas.
  for($i=0;$i -lt $spec.sheets.Count;$i++){
    if($i -eq 0){$sh=$taskBook.Worksheets.Item(1)}else{$sh=$taskBook.Worksheets.Add([Type]::Missing,$taskBook.Worksheets.Item($taskBook.Worksheets.Count))}
    $sh.Name=[string]$spec.sheets[$i].name
  }
  $taskExcel.Calculation=-4135
  $decimal=[string]$taskExcel.International(3);$thousands=[string]$taskExcel.International(4);$general=[string]$taskExcel.International(26)
  foreach($op in $spec.operations){
    $sh=$taskBook.Worksheets.Item([string]$op.sheet);$r=$sh.Range([string]$op.address)
    switch($op.kind){
      {$_ -eq 'values' -and $op.value.Count -ge 1000} {
        # Large simulated blocks are numeric only and are written in one assignment.
        $rows=$op.value.Count;$cols=@($op.value[0]).Count
        $block=New-Object 'object[,]' $rows,$cols
        for($i=0;$i -lt $rows;$i++){
          $row=@($op.value[$i])
          for($j=0;$j -lt $cols;$j++){
            $v=$row[$j]
            if($null -eq $v -or $v -is [string] -or $v -is [bool]){throw 'Large value blocks must be numeric'}
            $block[$i,$j]=[double]$v
          }
        }
        $r.Value2=$block
        break
      }
      {$_ -in 'values','formulas','formulasLocal'} {
        for($i=0;$i -lt $op.value.Count;$i++){
          $row=@($op.value[$i])
          for($j=0;$j -lt $row.Count;$j++){
            $cell=$r.Cells.Item($i+1,$j+1);$v=$row[$j]
            if($op.kind -eq 'formulas'){$cell.Formula=[string]$v}
            elseif($op.kind -eq 'formulasLocal'){$cell.FormulaLocal=[string]$v}
            elseif($null -eq $v){[void]$cell.ClearContents()}
            elseif($v -is [string]){
              # Value2 alone coerces numeric-looking strings (e.g. stem-and-leaf labels).
              $previousFormat=$cell.NumberFormatLocal
              $cell.NumberFormatLocal='@';$cell.Value2=[string]$v;$cell.NumberFormatLocal=$previousFormat
            }
            elseif($v -is [bool]){$cell.Value2=[bool]$v}
            else{$cell.Value2=[double]$v}
          }
        }
      }
      'format' {Set-Format $r $op.value}
      'merge' {[void]$r.Merge()}
      'fillDown' {[void]$r.FillDown()}
      'numberFormat' {
        $code=[string]$op.value
        if($code -eq 'General'){$r.NumberFormatLocal=$general}
        else{$r.NumberFormatLocal=$code.Replace(',',[string][char]1).Replace('.',$decimal).Replace([string][char]1,$thousands)}
      }
      'validation' {
        $rule=$op.value
        $validationType=@{whole=1;decimal=2}[$rule.type]
        if($null -eq $validationType){throw 'Unsupported validation type'}
        $operator=@{between=1;greaterThanOrEqual=7}[$rule.operator]
        if($null -eq $operator){throw 'Unsupported validation operator'}
        $r.Validation.Delete()
        if($operator -eq 1){$r.Validation.Add($validationType,1,$operator,[string]$rule.formula1,[string]$rule.formula2)}
        else{$r.Validation.Add($validationType,1,$operator,[string]$rule.formula1)}
        $r.Validation.IgnoreBlank=$false;$r.Validation.ShowError=($rule.showError -eq $true)
      }
      default {throw "Unsupported operation: $($op.kind)"}
    }
  }
  foreach($cs in $spec.charts){
    $sh=$taskBook.Worksheets.Item([string]$cs.sheet)
    $a=$sh.Range([string]$cs.start);$b=$sh.Range([string]$cs.end)
    $co=$sh.ChartObjects().Add($a.Left,$a.Top,$b.Left+$b.Width-$a.Left,$b.Top+$b.Height-$a.Top)
    $chart=$co.Chart;$chart.ChartType=if($cs.type -eq 'scatter'){-4169}else{51}
    while($chart.SeriesCollection().Count -gt 0){$chart.SeriesCollection(1).Delete()}
    foreach($ss in $cs.series){
      $series=$chart.SeriesCollection().NewSeries()
      $series.Name=[string]$ss.name
      $series.XValues=$sh.Range([string]$ss.x);$series.Values=$sh.Range([string]$ss.y)
      if($cs.type -eq 'scatter'){
        $series.AxisGroup=1
        if($ss.line){
          $series.ChartType=75;$series.MarkerStyle=-4142;$series.Format.Line.Visible=-1
          $series.Format.Line.ForeColor.RGB=Rgb $ss.color;$series.Format.Line.DashStyle=4;$series.Format.Line.Weight=1.75
        }else{
          $series.ChartType=-4169;$series.MarkerStyle=8;$series.MarkerSize=6;$series.Format.Line.Visible=0
          $series.MarkerForegroundColor=Rgb $ss.color;$series.MarkerBackgroundColor=Rgb $ss.color
        }
      }else{$series.Format.Fill.ForeColor.RGB=Rgb $ss.color}
    }
    $chart.HasTitle=$true;$chart.ChartTitle.Text=[string]$cs.title
    $chart.ChartArea.Font.Name='Arial';$chart.ChartArea.Font.Size=11;$chart.ChartTitle.Font.Size=15
    $chart.HasLegend=[bool]$cs.legend;if($cs.legend){$chart.Legend.Position=-4107}
    foreach($axis in 1,2){$chart.Axes($axis).HasTitle=$true;$chart.Axes($axis).TickLabelPosition=-4134}
    $chart.Axes(1).AxisTitle.Text=[string]$cs.xTitle;$chart.Axes(2).AxisTitle.Text=[string]$cs.yTitle
    $chart.Axes(2).TickLabels.NumberFormat='0'
    if($cs.type -eq 'scatter'){
      $chart.Axes(1).TickLabels.NumberFormatLocal=('0'+$decimal+'0')
      # Default z axis for Q-Q plots; a spec may set other limits (e.g. 0-1 for P-P plots).
      $xMin=if($null -ne $cs.xMin){[double]$cs.xMin}else{-2};$xMax=if($null -ne $cs.xMax){[double]$cs.xMax}else{2};$xMajor=if($null -ne $cs.xMajor){[double]$cs.xMajor}else{1}
      $chart.Axes(1).MinimumScale=[double]$xMin;$chart.Axes(1).MaximumScale=[double]$xMax;$chart.Axes(1).MajorUnit=[double]$xMajor
      $chart.Axes(1).CrossesAt=[double]$xMin;$chart.Axes(2).Crosses=-4105
      if($null -ne $cs.yMin){
        $chart.Axes(2).MinimumScale=[double]$cs.yMin;$chart.Axes(2).MaximumScale=[double]$cs.yMax;$chart.Axes(2).MajorUnit=[double]$cs.yMajor
        $chart.Axes(2).TickLabels.NumberFormatLocal=('0'+$decimal+'0')
      }
      $chart.Axes(1).HasMajorGridlines=$false;$chart.Axes(2).HasMajorGridlines=$false
    }else{
      $chart.Axes(2).MinimumScale=0
      if($cs.histogram){$chart.ChartGroups(1).GapWidth=0}
    }
  }
  foreach($ss in $spec.sheets){
    $sh=$taskBook.Worksheets.Item([string]$ss.name);$sh.Activate()
    $taskExcel.ActiveWindow.DisplayGridlines=($ss.showGridLines -ne $false)
    $taskExcel.ActiveWindow.FreezePanes=$false
    if($ss.freezeRows){$taskExcel.ActiveWindow.SplitRow=[int]$ss.freezeRows;$taskExcel.ActiveWindow.SplitColumn=0;$taskExcel.ActiveWindow.FreezePanes=$true}
    [void]$sh.Range('A1').Select()
    if($null -ne $ss.editableRanges){
      $sh.Cells.Locked=$true
      foreach($address in $ss.editableRanges){$sh.Range([string]$address).Locked=$false}
      # Protect formulas and fixed values against accidental edits; no password.
      $sh.Protect()
    }
  }
  $taskExcel.Calculation=-4105;$taskExcel.CalculateFullRebuild()
  $formulas=0
  foreach($sh in $taskBook.Worksheets){foreach($cell in $sh.UsedRange.Cells){
    if($cell.HasFormula){$formulas++;if($taskExcel.WorksheetFunction.IsError($cell)){throw "Excel error: $($sh.Name)!$($cell.Address()) $($cell.Text)"}}
  }}
  $taskBook.Worksheets.Item('Prehled').Activate()
  $taskBook.RemovePersonalInformation=$true
  # Complete in tmp first: failures must not destroy the last published workbook.
  $taskBook.SaveAs($staged,51)
  $taskBook.Close($false);[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($taskBook);$taskBook=$null
  Copy-Item -LiteralPath $staged -Destination $target -Force
  [pscustomobject]@{Workbook=$target;Sheets=$spec.sheets.Count;Formulas=$formulas;ExcelVersion=$taskExcel.Version}|ConvertTo-Json -Compress
} finally {
  if($null -ne $taskBook){$taskBook.Close($false)}
  if($null -ne $taskExcel){$taskExcel.Quit();[void][Runtime.InteropServices.Marshal]::FinalReleaseComObject($taskExcel)}
  [GC]::Collect();[GC]::WaitForPendingFinalizers()
}
