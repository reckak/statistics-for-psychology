param([switch]$Finalize)
# Own hidden Excel instance; never attaches to a user's active workbook.
$ErrorActionPreference = 'Stop'
$taskExcel = $null; $taskBook = $null
$taskRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
function Assert-Values($sheet, $address, $expected) {
    $actual = @($sheet.Range($address).Value2)
    if ($actual.Count -ne $expected.Count) { throw "Size mismatch: $address" }
    for ($i = 0; $i -lt $actual.Count; $i++) {
        if ([math]::Abs([double]$actual[$i] - $expected[$i]) -gt 1e-12) { throw "Wrong value in $address at index $i" }
    }
}
try {
    $taskExcel = New-Object -ComObject Excel.Application
    $taskExcel.Visible = $false; $taskExcel.DisplayAlerts = $false
    $taskBook = $taskExcel.Workbooks.Open((Join-Path $taskRoot 'data/kapitola_02.xlsx'), 0, $false)
    $taskData = $taskBook.Worksheets.Item('Data')
    $taskCounts = $taskBook.Worksheets.Item('Cetnosti')
    $taskHist = $taskBook.Worksheets.Item('Histogram')
    $taskExcel.CalculateFullRebuild()
    Assert-Values $taskCounts 'C2' @(36)
    Assert-Values $taskCounts 'C5:C8' @(4,10,14,8)
    Assert-Values $taskCounts 'F5:F8' @(4,14,28,36)
    Assert-Values $taskCounts 'D5:D8' @((4/36),(10/36),(14/36),(8/36))
    Assert-Values $taskCounts 'G5:G8' @((4/36),(14/36),(28/36),1)
    Assert-Values $taskCounts 'C10:E10' @(36,1,1)
    Assert-Values $taskHist 'C2' @(33)
    Assert-Values $taskHist 'D5:D10' @(2,4,7,11,6,3)
    Assert-Values $taskHist 'E5:E10' @((2/33),(4/33),(7/33),(11/33),(6/33),(3/33))
    Assert-Values $taskHist 'D12:F12' @(33,1,1)
    # Check the exact Czech formulas printed in the chapter.
    $taskCounts.Range('C2').FormulaLocal = '=POČET(Data!E2:E37)'
    $taskCounts.Range('C5').FormulaLocal = '=COUNTIFS(Data!$E$2:$E$37;A5)'
    $taskCounts.Range('F6').FormulaLocal = '=SUMA($C$5:C6)'
    $taskHist.Range('D5').FormulaLocal = '=COUNTIFS(Data!$B$2:$B$37;">="&A5;Data!$B$2:$B$37;"<"&B5)'
    $taskExcel.CalculateFullRebuild()
    Assert-Values $taskCounts 'C2' @(36)
    Assert-Values $taskCounts 'C5' @(4)
    Assert-Values $taskCounts 'F6' @(14)
    Assert-Values $taskHist 'D5' @(2)
    $taskData.Range('E2').Value2 = 3
    $taskExcel.CalculateFullRebuild()
    Assert-Values $taskCounts 'C5:C8' @(4,9,15,8)
    Assert-Values $taskCounts 'F5:F8' @(4,13,28,36)
    $taskCountChart = $taskCounts.ChartObjects(1).Chart
    $taskHistChart = $taskHist.ChartObjects(1).Chart
    if ((@($taskCountChart.SeriesCollection(1).Values) -join ',') -ne '4,9,15,8') { throw 'Count chart did not update' }
    $taskData.Range('E2').Value2 = 2
    $taskData.Range('B2').Value2 = 7
    $taskExcel.CalculateFullRebuild()
    Assert-Values $taskHist 'D5:D10' @(2,4,6,12,6,3)
    if ((@($taskHistChart.SeriesCollection(1).Values) -join ',') -ne '2,4,6,12,6,3') { throw 'Histogram did not update' }
    $taskData.Range('B2').Value2 = 6
    $taskExcel.CalculateFullRebuild()
    # Independently compare all 180 source input cells, including blanks.
    $taskCsv = Import-Csv -LiteralPath (Join-Path $taskRoot 'data/kapitola_02.csv') -Encoding UTF8
    $taskColumns = @('id','spanek_h','slova','cast_dne','odpocatost')
    for ($row=0; $row -lt 36; $row++) {
        for ($col=0; $col -lt 5; $col++) {
            $value = $taskData.Cells.Item($row+2,$col+1).Value2
            $expected = $taskCsv[$row].($taskColumns[$col])
            if ($expected -eq '') { if ($null -ne $value) { throw 'Blank input changed' } }
            elseif ($col -in @(1,2,4)) {
                if ([double]$value -ne [double]::Parse($expected,[cultureinfo]::InvariantCulture)) { throw 'Numeric input changed' }
            } elseif ($value -ne $expected) { throw 'Text input changed' }
        }
    }
    if ($Finalize) {
        # These two chart properties are finalized in native Excel.
        $taskHistChart.ChartGroups(1).GapWidth = 0
        $taskHistChart.Axes(2).MinimumScale = 0
        $taskCountChart.Axes(2).MinimumScale = 0
        $taskBook.Save()
    }
    if ($taskHistChart.ChartGroups(1).GapWidth -ne 0) { throw 'Histogram bars must touch' }
    $taskOut = Join-Path $taskRoot 'tmp/chapter-02-build'
    [void](New-Item -ItemType Directory -Force -Path $taskOut)
    foreach ($item in @(@($taskCountChart,'excel-bar.png'),@($taskHistChart,'excel-histogram.png'))) {
        if (-not $item[0].Export((Join-Path $taskOut $item[1]),'PNG')) { throw 'Chart export failed' }
    }
    [pscustomobject]@{
        ExcelVersion=$taskExcel.Version
        CountFormula=$taskCounts.Range('C2').FormulaLocal
        FrequencyFormula=$taskCounts.Range('C5').FormulaLocal
        CumulativeFormula=$taskCounts.Range('F6').FormulaLocal
        IntervalFormula=$taskHist.Range('D5').FormulaLocal
        Counts='4,10,14,8'; Intervals='2,4,7,11,6,3'
        InputCellsChecked=180; EditsAndChartUpdates='passed'
        RatioDisplay=$taskCounts.Range('D5').Text
        PercentDisplay=$taskCounts.Range('E5').Text
        HistogramGap=$taskHistChart.ChartGroups(1).GapWidth
        Saved=[bool]$Finalize
    } | ConvertTo-Json
} finally {
    if ($null -ne $taskBook) { $taskBook.Close($false) }
    if ($null -ne $taskExcel) { $taskExcel.Quit() }
    foreach ($obj in @($taskHistChart,$taskCountChart,$taskData,$taskCounts,$taskHist,$taskBook,$taskExcel)) {
        if ($null -ne $obj -and [System.Runtime.InteropServices.Marshal]::IsComObject($obj)) {
            [void][System.Runtime.InteropServices.Marshal]::FinalReleaseComObject($obj)
        }
    }
}
