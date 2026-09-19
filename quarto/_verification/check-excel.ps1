# Internal verification only; creates an unsaved workbook in a new hidden instance.
$ErrorActionPreference = 'Stop'
$taskExcel = $null
$taskWorkbook = $null
$taskSheet = $null
try {
    $taskExcel = New-Object -ComObject Excel.Application
    $taskExcel.Visible = $false
    $taskExcel.DisplayAlerts = $false
    $taskWorkbook = $taskExcel.Workbooks.Add()
    $taskSheet = $taskWorkbook.Worksheets.Item(1)
    $taskSheet.Range('D1').Formula = '=SUM(A1:C1)'
    $taskSheet.Range('A2').Value2 = 3
    $taskSheet.Range('C2').Value2 = 4
    $taskSheet.Range('D2').Formula = '=SUM(A2:C2)'
    $taskExcel.Calculate()
    $taskEmptySum = $taskSheet.Range('D1').Value2
    $taskPartialSum = $taskSheet.Range('D2').Value2
    if ($taskEmptySum -ne 0 -or $taskPartialSum -ne 7) {
        throw 'Unexpected result in the missing-data example.'
    }
    [pscustomobject]@{
        Version = $taskExcel.Version
        EmptySum = $taskEmptySum
        PartialSum = $taskPartialSum
        FormulaLocal = $taskSheet.Range('D1').FormulaLocal
    } | ConvertTo-Json
} finally {
    if ($null -ne $taskWorkbook) { $taskWorkbook.Close($false) }
    if ($null -ne $taskExcel) { $taskExcel.Quit() }
    foreach ($taskObject in @($taskSheet, $taskWorkbook, $taskExcel)) {
        if ($null -ne $taskObject) {
            [void][System.Runtime.InteropServices.Marshal]::FinalReleaseComObject($taskObject)
        }
    }
}
