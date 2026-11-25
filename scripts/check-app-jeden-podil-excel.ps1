# Checks the Czech Excel formulas shown by the app page quarto/app_jeden_podil.qmd in desktop Excel.
# Run from the project root in Windows PowerShell: .\scripts\check-app-jeden-podil-excel.ps1
# Starts its own hidden Excel instance, writes the cell layout of the page (inputs B2:B5, formulas B7:B18)
# for four cases covering all three alternatives, both interval kinds and pi0 as a fraction, and compares
# the results with the module assets/stat/podil.js (expected values printed by that module; the module
# itself is checked against R by scripts/check-stat-lib.mjs). Nothing is saved.
$ErrorActionPreference = 'Stop'
$cases = @(
  @{k=10; n=20; pi0='0,25'; a='0,05'; score='=1-NORM.S.DIST(B9;PRAVDA)'; exact='=1-BINOM.DIST(B2-1;B3;B4;PRAVDA)'; conf='=1-2*B5'; zq='=NORM.S.INV(1-(1-B13)/2)';
    want=@(0.5, 0.096824583655185426, 2.5819888974716112, 0.0049116372537596044, 0.013864416943761122, 0.9, 1.6448536269514722, 0.5, 0.17259623211484407, 0.32740376788515591, 0.67259623211484409)},
  @{k=7; n=8; pi0='0,5'; a='0,05'; score='=NORM.S.DIST(B9;PRAVDA)'; exact='=BINOM.DIST(B2;B3;B4;PRAVDA)'; conf='=1-B5'; zq='=NORM.S.INV(B13)';
    want=@(0.875, 0.17677669529663689, 2.1213203435596424, 0.98305257323765538, 0.996093750000001, 0.95, 1.6448536269514722, 0.78022865096608884, 0.19137202529610103, 0.58885662566998787, 0.97160067626218982)},
  @{k=106; n=329; pi0='0,25'; a='0,05'; score='=2*(1-NORM.S.DIST(ABS(B9);PRAVDA))'; exact=''; conf='=1-B5'; zq='=NORM.S.INV(1-(1-B13)/2)';
    want=@(0.32218844984802431, 0.023872763027971138, 3.0238833168763435, 0.0024955266743224886, -1, 0.95, 1.959963984540054, 0.32424064535928293, 0.050245987401076025, 0.27399465795820688, 0.37448663276035898)},
  @{k=3; n=10; pi0='=1/3'; a='0,1'; score='=1-NORM.S.DIST(B9;PRAVDA)'; exact='=1-BINOM.DIST(B2-1;B3;B4;PRAVDA)'; conf='=1-B5'; zq='=NORM.S.INV(B13)';
    want=@(0.3, 0.14907119849998599, -0.22360679774997891, 0.58846836312093931, 0.70085860895188912, 0.9, 1.2815515655446006, 0.32821373641810819, 0.1744145583421409, 0.1537991780759673, 0.50262829476024906)}
)
$cells = @('B7','B8','B9','B10','B11','B13','B14','B15','B16','B17','B18')
$xl = New-Object -ComObject Excel.Application
$xl.Visible = $false; $xl.DisplayAlerts = $false
$failures = 0
try {
  $wb = $xl.Workbooks.Add(); $ws = $wb.Worksheets.Item(1)
  foreach ($c in $cases) {
    $ws.Range('B2').Value2 = $c.k; $ws.Range('B3').Value2 = $c.n
    $ws.Range('B4').FormulaLocal = $c.pi0; $ws.Range('B5').FormulaLocal = $c.a
    $ws.Range('B7').FormulaLocal = '=B2/B3'
    $ws.Range('B8').FormulaLocal = '=ODMOCNINA(B4*(1-B4)/B3)'
    $ws.Range('B9').FormulaLocal = '=(B7-B4)/B8'
    $ws.Range('B10').FormulaLocal = $c.score
    if ($c.exact) { $ws.Range('B11').FormulaLocal = $c.exact } else { $ws.Range('B11').Value2 = -1 }
    $ws.Range('B13').FormulaLocal = $c.conf
    $ws.Range('B14').FormulaLocal = $c.zq
    $ws.Range('B15').FormulaLocal = '=(B7+B14^2/(2*B3))/(1+B14^2/B3)'
    $ws.Range('B16').FormulaLocal = '=B14/(1+B14^2/B3)*ODMOCNINA(B7*(1-B7)/B3+B14^2/(4*B3^2))'
    $ws.Range('B17').FormulaLocal = '=B15-B16'
    $ws.Range('B18').FormulaLocal = '=B15+B16'
    $xl.Calculate()
    for ($i = 0; $i -lt $cells.Count; $i++) {
      $got = [double]$ws.Range($cells[$i]).Value2; $want = [double]$c.want[$i]
      if ([Math]::Abs($got - $want) -gt 1e-9 * [Math]::Max(1, [Math]::Abs($want))) {
        $failures++; Write-Output ("FAIL {0} z {1}, {2}: {3} vs {4}" -f $c.k, $c.n, $cells[$i], $got, $want)
      }
    }
  }
  $wb.Close($false)
} finally {
  $xl.Quit(); [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
}
Write-Output ("{0} cases, {1} failures" -f $cases.Count, $failures)
if ($failures) { exit 1 }
