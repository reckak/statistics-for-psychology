param([switch]$Finalize)
# Separate hidden instance; no changes to an existing Excel session.
$ErrorActionPreference='Stop'
$taskRoot=(Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
$taskExcel=$null; $taskBook=$null
function Assert-Cell($sheet,$address,$expected,$tolerance=1e-9){
  $actual=$sheet.Range($address).Value2
  if($null -eq $actual -or $actual -is [string] -or [math]::Abs([double]$actual-$expected) -gt $tolerance){throw "Wrong value $($sheet.Name)!${address}: $actual; expected $expected"}
}
try {
  $taskExcel=New-Object -ComObject Excel.Application
  $taskExcel.Visible=$false; $taskExcel.DisplayAlerts=$false
  $taskBook=$taskExcel.Workbooks.Open((Join-Path $taskRoot 'data/kapitola_04.xlsx'),0,$false)
  $m=$taskBook.Worksheets.Item('Model'); $q=$taskBook.Worksheets.Item('QQ')
  foreach($sh in @($m,$q)){foreach($c in $sh.UsedRange.Cells){if($c.HasFormula){$c.Formula=$c.Formula}}}
  $local=@{B6='=(B4-B2)/B3';B7='=NORM.S.DIST(B6;PRAVDA)';B8='=1-B7';B9='=NORM.DIST(B4;B2;B3;PRAVDA)';B13='=NORM.S.DIST((B12-B2)/B3;PRAVDA)-NORM.S.DIST((B11-B2)/B3;PRAVDA)';B17='=NORM.S.INV(B16)';B18='=B2+B3*B17';B19='=NORM.INV(B16;B2;B3)';B23='=(1-B22)/2';B24='=NORM.INV(B23;B2;B3)';B25='=NORM.INV(1-B23;B2;B3)'}
  foreach($a in $local.Keys){$m.Range($a).FormulaLocal=$local[$a]}
  $q.Range('H2').FormulaLocal='=POČET(B2:B13)';$q.Range('H3').FormulaLocal='=PRŮMĚR(B2:B13)';$q.Range('H4').FormulaLocal='=SMODCH.VÝBĚR.S(B2:B13)'
  $q.Range('C2').FormulaLocal='=(A2-0,5)/$H$2';$q.Range('D2').FormulaLocal='=NORM.S.INV(C2)';$q.Range('E2').FormulaLocal='=$H$3+$H$4*D2'
  [void]$q.Range('C2:E13').FillDown();$taskExcel.CalculateFullRebuild()
  $expected=@{B6=1;B7=0.841344746068543;B8=0.158655253931457;B9=0.841344746068543;B13=0.135905121983278;B17=1.28155156554460;B18=62.8155156554460;B19=62.8155156554460;B23=.025;B24=30.4003601545995;B25=69.5996398454005}
  foreach($a in $expected.Keys){Assert-Cell $m $a $expected[$a]}
  Assert-Cell $q 'H2' 12;Assert-Cell $q 'H3' 50;Assert-Cell $q 'H4' ([math]::Sqrt(890/11))
  $source=Import-Csv -LiteralPath (Join-Path $taskRoot 'data/kapitola_04.csv')
  for($i=0;$i -lt 12;$i++){
    $r=$i+2;Assert-Cell $q "A$r" ($i+1);Assert-Cell $q "B$r" ([double]$source[$i].skor_body)
    Assert-Cell $q "C$r" (($i+.5)/12)
    $m.Range('F28').FormulaLocal="=NORM.S.DIST(QQ!D$r;PRAVDA)";$taskExcel.CalculateFullRebuild();Assert-Cell $m 'F28' (($i+.5)/12)
    Assert-Cell $q "E$r" (50+[math]::Sqrt(890/11)*$q.Range("D$r").Value2)
  }
  Assert-Cell $q 'D2' -1.73166439612225;Assert-Cell $q 'D13' 1.73166439612225
  # All direct formulas used in solved exercises, including rounded-score interval.
  $exercise=@(@('=NORM.S.DIST(-0,5;PRAVDA)',.308537538725987),@('=1-NORM.S.DIST(1,5;PRAVDA)',.0668072012688581),@('=NORM.S.DIST(1,5;PRAVDA)-NORM.S.DIST(-0,5;PRAVDA)',.624655260005155),@('=NORM.INV(0,2;50;10)',41.5837876642709),@('=NORM.INV(0,05;50;10)',33.5514637304853),@('=NORM.INV(0,95;50;10)',66.4485362695147),@('=NORM.S.DIST(0,05;PRAVDA)-NORM.S.DIST(-0,05;PRAVDA)',.0398776116767449))
  foreach($e in $exercise){$m.Range('F28').FormulaLocal=$e[0];$taskExcel.CalculateFullRebuild();Assert-Cell $m 'F28' $e[1]}
  # Densities must not accidentally be treated as cumulative proportions.
  $m.Range('F28').FormulaLocal='=NORM.S.DIST(0;NEPRAVDA)';$taskExcel.CalculateFullRebuild();Assert-Cell $m 'F28' (1/[math]::Sqrt(2*[math]::PI))
  foreach($e in @('=NORM.S.INV(0)','=NORM.S.INV(1)','=NORM.DIST(60;50;0;PRAVDA)')){
    $m.Range('F28').FormulaLocal=$e;$taskExcel.CalculateFullRebuild()
    if(-not $taskExcel.WorksheetFunction.IsError($m.Range('F28'))){throw "Boundary should be an Excel error: $e"}
  }
  [void]$m.Range('F28').Clear()
  # Valid input changes must flow through all dependent conversions.
  $m.Range('B4').Value2=40;$taskExcel.CalculateFullRebuild();Assert-Cell $m 'B7' .158655253931457;Assert-Cell $m 'B8' .841344746068543
  $m.Range('B4').Value2=60;$m.Range('B16').Value2=.5;$taskExcel.CalculateFullRebuild();Assert-Cell $m 'B17' 0;Assert-Cell $m 'B18' 50
  $m.Range('B16').Value2=.9
  $q.Range('B13').Value2=90;$taskExcel.CalculateFullRebuild();Assert-Cell $q 'H3' (625/12);Assert-Cell $q 'H4' ([math]::Sqrt((34765-625*625/12)/11))
  Assert-Cell $q 'D13' 1.73166439612225
  # Native scatter chart: observed markers, reference line. No secondary axes.
  if($q.ChartObjects().Count -ne 1){throw 'Missing editable Q-Q chart'}
  $chart=$q.ChartObjects(1).Chart
  if($chart.SeriesCollection().Count -ne 2){throw 'Wrong chart series count'}
  $observed=$chart.SeriesCollection(1);$reference=$chart.SeriesCollection(2)
  if($observed.Formula -notmatch '\$D\$2:\$D\$13' -or $observed.Formula -notmatch '\$B\$2:\$B\$13'){throw 'Wrong Q-Q data binding'}
  if($reference.Formula -notmatch '\$D\$2:\$D\$13' -or $reference.Formula -notmatch '\$E\$2:\$E\$13'){throw 'Wrong reference binding'}
  if([double]@($observed.Values)[11] -ne 90){throw 'Q-Q chart did not follow changed input'}
  $q.Range('B13').Value2=65;$taskExcel.CalculateFullRebuild()
  if($Finalize){
    $observed.Name='Pozorované skóry';$observed.ChartType=-4169;$observed.MarkerStyle=8;$observed.MarkerSize=6;$observed.Format.Line.Visible=0
    $observed.MarkerForegroundColor=7888164;$observed.MarkerBackgroundColor=7888164
    $reference.Name='Referenční přímka';$reference.ChartType=75;$reference.MarkerStyle=-4142;$reference.Format.Line.Visible=-1;$reference.Format.Line.ForeColor.RGB=2379445;$reference.Format.Line.DashStyle=4;$reference.Format.Line.Weight=1.75
    foreach($series in @($observed,$reference)){$series.AxisGroup=1}
    $chart.ChartArea.Font.Name='Arial';$chart.ChartArea.Font.Size=11
    $chart.Axes(1).MinimumScale=-2;$chart.Axes(1).MaximumScale=2;$chart.Axes(1).MajorUnit=1
    $chart.Axes(2).MinimumScaleIsAuto=$true;$chart.Axes(2).MaximumScaleIsAuto=$true;$chart.Axes(2).MajorUnitIsAuto=$true
    $chart.Axes(1).CrossesAt=-2;$chart.Axes(2).Crosses=-4105
    $chart.Axes(1).TickLabelPosition=-4134;$chart.Axes(2).TickLabelPosition=-4134
    $chart.Axes(1).HasMajorGridlines=$false;$chart.Axes(2).HasMajorGridlines=$false
    $chart.Axes(1).AxisTitle.Text='Teoretický normální kvantil (z)';$chart.Axes(2).AxisTitle.Text='Pozorovaný skór (body)'
    $chart.Legend.Position=-4107
    $m.PageSetup.PrintArea='$A$1:$D$25';$q.PageSetup.PrintArea='$A$1:$N$24'
    foreach($sh in @($m,$q)){$sh.PageSetup.Orientation=2;$sh.PageSetup.Zoom=$false;$sh.PageSetup.FitToPagesWide=1;$sh.PageSetup.FitToPagesTall=1}
    $taskBook.Save()
    $taskBook.ExportAsFixedFormat(0,(Join-Path $taskRoot 'tmp/chapter-04/excel-native.pdf'))
  }
  foreach($sh in @($m,$q)){foreach($cell in $sh.UsedRange.Cells){if($cell.Text -match '^#'){throw "Excel error $($sh.Name): $($cell.Text)"}}}
  [pscustomobject]@{ExcelVersion=$taskExcel.Version;CzechFormulas='passed';NumericalAndMutationChecks='passed';ChartBindings='passed';Saved=[bool]$Finalize}|ConvertTo-Json
} finally {
  if($null -ne $taskBook){$taskBook.Close($false)}
  if($null -ne $taskExcel){$taskExcel.Quit()}
  foreach($o in @($observed,$reference,$chart,$m,$q,$taskBook,$taskExcel)){if($null -ne $o -and [System.Runtime.InteropServices.Marshal]::IsComObject($o)){[void][System.Runtime.InteropServices.Marshal]::FinalReleaseComObject($o)}}
}
