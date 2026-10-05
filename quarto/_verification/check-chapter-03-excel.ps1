param([switch]$Finalize)
# Create a separate hidden Excel instance; do not attach to an existing user session.
$ErrorActionPreference = 'Stop'
$taskRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
$taskExcel = $null; $taskBook = $null
function Assert-Cell($sheet,$address,$expected) {
    $actual = $sheet.Range($address).Value2
    if ($null -eq $actual -or $actual -is [string] -or [math]::Abs([double]$actual-$expected) -gt 1e-9) { throw "Wrong result in $($sheet.Name)!${address}: $actual; expected $expected" }
}
try {
    $taskExcel = New-Object -ComObject Excel.Application
    $taskExcel.Visible=$false; $taskExcel.DisplayAlerts=$false
    $taskBook=$taskExcel.Workbooks.Open((Join-Path $taskRoot 'data/kapitola_03.xlsx'),0,$false)
    $p=$taskBook.Worksheets.Item('Priklad'); $s=$taskBook.Worksheets.Item('Souhrn'); $r=$taskBook.Worksheets.Item('Rozsireni'); $d=$taskBook.Worksheets.Item('Data')
    # Let native Excel normalize modern function names exported without its compatibility prefix.
    foreach($sh in @($p,$s,$r)){foreach($cell in $sh.UsedRange.Cells){if($cell.HasFormula){$cell.Formula=$cell.Formula}}}
    # Assign the actual Czech formulas given to students, including copied helper columns.
    $local=@{
        J2='=POČET(A2:A6)'; J3='=PRŮMĚR(A2:A6)'; J4='=MEDIAN(A2:A6)'; J5='=MODE.SNGL(A2:A6)'; J6='=MIN(A2:A6)'; J7='=MAX(A2:A6)';
        J8='=PERCENTIL.INC(A2:A6;0,25)'; J9='=PERCENTIL.INC(A2:A6;0,75)'; J10='=J7-J6'; J11='=J9-J8'; J12='=PRŮMĚR(C2:C6)';
        J13='=SUMA(D2:D6)'; J14='=J13/J2'; J15='=VAR.S(A2:A6)'; J16='=SMODCH.VÝBĚR.S(A2:A6)'; J17='=MEDIAN(E2:E6)';
        B2='=A2-$J$3'; C2='=ABS(B2)'; D2='=B2^2'; E2='=ABS(A2-$J$4)'; F2='=B2^3'; G2='=B2^4'
    }
    foreach($a in $local.Keys) { $p.Range($a).FormulaLocal=$local[$a] }
    [void]$p.Range('B2:G6').FillDown()
    $r.Range('C2').FormulaLocal='=B2/SUMA($B$2:$B$5)'
    $r.Range('D2').FormulaLocal='=KDYŽ(C2=0;0;-C2*LOGZ(C2;2))'
    [void]$r.Range('C2:D5').FillDown()
    $r.Range('D7').FormulaLocal='=SUMA(D2:D5)'
    $r.Range('J2').FormulaLocal='=PRŮMĚR(Priklad!F2:F6)/(ODMOCNINA(Priklad!J14)^3)'
    $r.Range('J3').FormulaLocal='=SKEW.P(Priklad!A2:A6)'
    $r.Range('J4').FormulaLocal='=SKEW(Priklad!A2:A6)'
    $r.Range('J5').FormulaLocal='=PRŮMĚR(Priklad!G2:G6)/(Priklad!J14^2)-3'
    $r.Range('J6').FormulaLocal='=KURT(Priklad!A2:A6)'
    $taskExcel.CalculateFullRebuild()
    $baseInputs=@(4,5,5,6,10)
    for($i=0;$i -lt 5;$i++){Assert-Cell $p ('A'+($i+2)) $baseInputs[$i]}
    $expected=@(5,6,5,5,4,10,5,6,6,1,1.6,22,4.4,5.5,[math]::Sqrt(5.5),1)
    for($i=0;$i -lt $expected.Count;$i++){Assert-Cell $p ('J'+($i+2)) $expected[$i]}
    foreach($entry in @(@('B2',33),@('C2',36),@('B3',(233.1/33)),@('C3',(253/36)),@('B4',7.1),@('C4',7),@('B7',6.2),@('C7',5.75),@('B8',8),@('C8',9),@('B9',1.8),@('C9',3.25),@('B10',1.66051136363636),@('C10',6.71349206349206),@('B11',1.28860830574538),@('C11',2.59104072903065))) {Assert-Cell $s $entry[0] $entry[1]}
    Assert-Cell $r 'D7' 1.5; Assert-Cell $r 'D5' 0
    foreach($entry in @(@('J2',1.17015863225595),@('J3',1.17015863225595),@('J4',1.74436949745499),@('J5',-0.169421487603306),@('J6',3.32231404958677))) {Assert-Cell $r $entry[0] $entry[1]}
    # Alternate formulas also printed in the chapter, evaluated in a disposable cell.
    foreach($entry in @(@('=VAR.P(A2:A6)',4.4),@('=ODMOCNINA(J15)',[math]::Sqrt(5.5)),@('=J13/(J2-1)',5.5),@('=COUNTIFS(A2:A6;"<=5")/POČET(A2:A6)',0.6),@('=PERCENTIL.INC(A2:A6;0,9)',8.4),@('=LOGZ(0,5;2)',-1))) {
        $p.Range('L1').FormulaLocal=$entry[0]; $taskExcel.CalculateFullRebuild(); Assert-Cell $p 'L1' $entry[1]
    }
    [void]$p.Range('L1').Clear()
    # Change inputs, test dependent sheets, then restore.
    $p.Range('A6').Value2=30; $taskExcel.CalculateFullRebuild()
    Assert-Cell $p 'J3' 10; Assert-Cell $p 'J4' 5; Assert-Cell $p 'J15' 125.5; Assert-Cell $p 'J17' 1
    Assert-Cell $r 'J3' (1494/[math]::Pow(100.4,1.5))
    $p.Range('A6').Value2=10
    $r.Range('B5').Value2=8; $taskExcel.CalculateFullRebuild(); Assert-Cell $r 'D7' 1.75
    $r.Range('B5').Value2=0
    $d.Range('B2').Value2=7; $taskExcel.CalculateFullRebuild(); Assert-Cell $s 'B3' (234.1/33); Assert-Cell $s 'B2' 33
    $d.Range('B2').Value2=6
    # Original data and missingness must survive creation and all checks.
    $csv=Import-Csv -LiteralPath (Join-Path $taskRoot 'data/kapitola_02.csv') -Encoding UTF8
    $cols=@('id','spanek_h','slova','cast_dne','odpocatost')
    for($i=0;$i -lt 36;$i++){for($j=0;$j -lt 5;$j++){
        $actual=$d.Cells.Item($i+2,$j+1).Value2; $value=$csv[$i].($cols[$j])
        if($value -eq '') {if($null -ne $actual){throw 'Blank was replaced'}}
        elseif($j -in @(1,2,4)){if([math]::Abs([double]$actual-[double]::Parse($value,[cultureinfo]::InvariantCulture)) -gt 1e-12){throw 'Numeric input changed'}}
        elseif($actual -ne $value){throw 'Text input changed'}
    }}
    $taskExcel.CalculateFullRebuild()
    foreach($sh in @($p,$s,$r,$d)){foreach($cell in $sh.UsedRange.Cells){if($cell.Text -match '^#'){throw "Excel error: $($sh.Name) $($cell.Address()) $($cell.Text)"}}}
    if($Finalize){$taskBook.Save()}
    [pscustomobject]@{ExcelVersion=$taskExcel.Version;LocalEntropyFormula=$r.Range('D2').FormulaLocal;InputCellsChecked=185;NumericAndMutationChecks='passed';Saved=[bool]$Finalize}|ConvertTo-Json
} finally {
    if($null -ne $taskBook){$taskBook.Close($false)}
    if($null -ne $taskExcel){$taskExcel.Quit()}
    foreach($o in @($p,$s,$r,$d,$taskBook,$taskExcel)){if($null -ne $o -and [System.Runtime.InteropServices.Marshal]::IsComObject($o)){[void][System.Runtime.InteropServices.Marshal]::FinalReleaseComObject($o)}}
}
