# Feasibility prototype for chapter 10 (not the student workbook generator).
# Inputs come from kapitola_10-prototyp-prevzorkovani.R. Usage:
#   powershell -ExecutionPolicy Bypass -File scripts\kapitola_10-prototyp-prevzorkovani.ps1 -Dir <abs path to tmp\prototyp-10> -B 1999
# Starts its own hidden Excel instance; writes proto_B<B>.xlsx into -Dir.
param(
  [Parameter(Mandatory = $true)][string]$Dir,
  [int]$B = 9999
)
# Feasibility prototype: bootstrap and permutation for r_s and tau_b with worksheet formulas only.
$ErrorActionPreference = 'Stop'
$n = 30
$last = $B + 1
$xl = New-Object -ComObject Excel.Application
$xl.Visible = $false
$xl.DisplayAlerts = $false
$xl.ScreenUpdating = $false
$report = [ordered]@{ B = $B; ExcelVersion = $xl.Version; Build = $xl.Build }
try {
  $wb = $xl.Workbooks.Add()
  $xl.Calculation = -4135  # manual
  function Get-Sheet($name) {
    $ws = $wb.Worksheets.Add([Type]::Missing, $wb.Worksheets.Item($wb.Worksheets.Count))
    $ws.Name = $name
    return $ws
  }
  function Copy-Csv($path, $ws, $topLeft, $rows) {
    # .csv would be parsed with the Czech list separator; open a .txt copy as comma-delimited text
    $txt = [IO.Path]::ChangeExtension($path, '.txt')
    Copy-Item $path $txt -Force
    $m = [Type]::Missing
    # Filename, Origin(65001 UTF-8), StartRow, DataType(1 delimited), TextQualifier(1 dq), ConsecutiveDelimiter, Tab, Semicolon, Comma
    $xl.Workbooks.OpenText($txt, 65001, 1, 1, 1, $false, $false, $false, $true)
    $src = $xl.ActiveWorkbook
    $s = $src.Worksheets.Item(1)
    $vals = $s.Range($s.Cells.Item(1, 1), $s.Cells.Item($rows, $s.UsedRange.Columns.Count)).Value2
    $cols = $s.UsedRange.Columns.Count
    $tl = $ws.Range($topLeft)
    $ws.Range($tl, $tl.Offset($rows - 1, $cols - 1)).Value2 = $vals
    $src.Close($false)
  }
  $t0 = Get-Date
  $data = $wb.Worksheets.Item(1); $data.Name = 'Data'
  Copy-Csv (Join-Path $Dir 'data30.csv') $data 'A1' 31
  $data.Range('E1').Value2 = 'rank_stress'; $data.Range('F1').Value2 = 'rank_sleep'
  $data.Range('E2:E31').Formula = '=RANK.AVG(B2,$B$2:$B$31,1)'
  $data.Range('F2:F31').Formula = '=RANK.AVG(C2,$C$2:$C$31,1)'
  # observed
  $data.Range('H1').Value2 = 'r_s'
  $data.Range('H2').Formula = '=CORREL(E2:E31,F2:F31)'
  $data.Range('I1').Value2 = 'S'
  $data.Range('I2').Formula2 = '=SUMPRODUCT(SIGN(B2:B31-TRANSPOSE(B2:B31))*SIGN(C2:C31-TRANSPOSE(C2:C31)))/2'
  $data.Range('J1').Value2 = 'tx'
  $data.Range('J2').Formula2 = '=(SUMPRODUCT(--(B2:B31=TRANSPOSE(B2:B31)))-30)/2'
  $data.Range('K1').Value2 = 'ty'
  $data.Range('K2').Formula2 = '=(SUMPRODUCT(--(C2:C31=TRANSPOSE(C2:C31)))-30)/2'
  $data.Range('L1').Value2 = 'tau_b'
  $data.Range('L2').Formula = '=I2/SQRT((435-J2)*(435-K2))'
  # legacy-entry check of the same S formula (implicit intersection risk)
  $data.Range('M1').Value2 = 'S_legacy'
  $data.Range('M2').Formula = '=SUMPRODUCT(SIGN(B2:B31-TRANSPOSE(B2:B31))*SIGN(C2:C31-TRANSPOSE(C2:C31)))/2'

  # fixed rows for permutation (stress and its ranks as rows)
  $fix = Get-Sheet 'Fix'
  $fix.Range('A1:AD1').Formula = '=INDEX(Data!$B$2:$B$31,COLUMN(A1))'
  $fix.Range('A2:AD2').Formula = '=INDEX(Data!$E$2:$E$31,COLUMN(A2))'

  # bootstrap
  $bi = Get-Sheet 'BootIdx'
  Copy-Csv (Join-Path $Dir 'boot_idx.csv') $bi 'A2' $B
  $xb = Get-Sheet 'Xb'; $xb.Range("A2:AD$last").Formula = '=INDEX(Data!$B$2:$B$31,BootIdx!A2)'
  $yb = Get-Sheet 'Yb'; $yb.Range("A2:AD$last").Formula = '=INDEX(Data!$C$2:$C$31,BootIdx!A2)'
  $rxb = Get-Sheet 'RXb'; $rxb.Range("A2:AD$last").Formula = '=RANK.AVG(Xb!A2,Xb!$A2:$AD2,1)'
  $ryb = Get-Sheet 'RYb'; $ryb.Range("A2:AD$last").Formula = '=RANK.AVG(Yb!A2,Yb!$A2:$AD2,1)'
  $br = Get-Sheet 'BootRes'
  $br.Range('A1:F1').Value2 = [object[]]@('r_s','S','tx','ty','tau_b','')
  $br.Range("A2:A$last").Formula = '=IFERROR(CORREL(RXb!A2:AD2,RYb!A2:AD2),"")'
  $br.Range("B2:B$last").Formula2 = '=SUMPRODUCT(SIGN(Xb!A2:AD2-TRANSPOSE(Xb!A2:AD2))*SIGN(Yb!A2:AD2-TRANSPOSE(Yb!A2:AD2)))/2'
  $br.Range("C2:C$last").Formula2 = '=(SUMPRODUCT(--(Xb!A2:AD2=TRANSPOSE(Xb!A2:AD2)))-30)/2'
  $br.Range("D2:D$last").Formula2 = '=(SUMPRODUCT(--(Yb!A2:AD2=TRANSPOSE(Yb!A2:AD2)))-30)/2'
  $br.Range("E2:E$last").Formula = '=IFERROR(B2/SQRT((435-C2)*(435-D2)),"")'
  $br.Range('H1:H6').Value2 = [object[,]](New-Object 'object[,]' 6,1)
  $br.Range('H2').Formula = "=PERCENTILE.INC(A2:A$last,0.025)"
  $br.Range('H3').Formula = "=PERCENTILE.INC(A2:A$last,0.975)"
  $br.Range('H4').Formula = "=PERCENTILE.INC(E2:E$last,0.025)"
  $br.Range('H5').Formula = "=PERCENTILE.INC(E2:E$last,0.975)"
  $br.Range('H6').Formula = "=COUNTBLANK(A2:A$last)+COUNTIF(A2:A$last,`"`")"

  # permutation
  $pi = Get-Sheet 'PermIdx'
  Copy-Csv (Join-Path $Dir 'perm_idx.csv') $pi 'A2' $B
  $yp = Get-Sheet 'Yp'; $yp.Range("A2:AD$last").Formula = '=INDEX(Data!$C$2:$C$31,PermIdx!A2)'
  $ryp = Get-Sheet 'RYp'; $ryp.Range("A2:AD$last").Formula = '=INDEX(Data!$F$2:$F$31,PermIdx!A2)'
  $pr = Get-Sheet 'PermRes'
  $pr.Range("A2:A$last").Formula = '=CORREL(Fix!$A$2:$AD$2,RYp!A2:AD2)'
  $pr.Range("B2:B$last").Formula2 = '=SUMPRODUCT(SIGN(Fix!$A$1:$AD$1-TRANSPOSE(Fix!$A$1:$AD$1))*SIGN(Yp!A2:AD2-TRANSPOSE(Yp!A2:AD2)))/2/SQRT((435-Data!$J$2)*(435-Data!$K$2))'
  $pr.Range('H2').Formula = "=(SUMPRODUCT(--(ABS(A2:A$last)>=ABS(Data!`$H`$2)-1E-12))+1)/($B+1)"
  $pr.Range('H3').Formula = "=(SUMPRODUCT(--(ABS(B2:B$last)>=ABS(Data!`$L`$2)-1E-12))+1)/($B+1)"
  $report.BuildSeconds = [math]::Round(((Get-Date) - $t0).TotalSeconds, 1)

  $t1 = Get-Date
  $xl.CalculateFull()
  $report.FullCalcSeconds = [math]::Round(((Get-Date) - $t1).TotalSeconds, 1)

  $report.obs_rs = $data.Range('H2').Value2
  $report.obs_S = $data.Range('I2').Value2
  $report.obs_S_legacy = $data.Range('M2').Value2
  $report.obs_tau_b = $data.Range('L2').Value2
  $report.rs_lo = $br.Range('H2').Value2; $report.rs_hi = $br.Range('H3').Value2
  $report.tb_lo = $br.Range('H4').Value2; $report.tb_hi = $br.Range('H5').Value2
  $report.boot_undefined = $br.Range('H6').Value2
  $report.rs_p = $pr.Range('H2').Value2; $report.tb_p = $pr.Range('H3').Value2
  $report.FormulaLocal_tau = $br.Range('B2').Formula2Local
  $report.FormulaLocal_S_legacy = $data.Range('M2').FormulaLocal
  $report.FormulaLocal_p = $pr.Range('H3').FormulaLocal

  $out = Join-Path $Dir ("proto_B{0}.xlsx" -f $B)
  if (Test-Path $out) { Remove-Item $out -Force }
  $t2 = Get-Date
  $wb.SaveAs($out, 51)
  $report.SaveSeconds = [math]::Round(((Get-Date) - $t2).TotalSeconds, 1)
  $report.FileMB = [math]::Round((Get-Item $out).Length / 1MB, 2)
  $wb.Close($false)

  # reopen and time a full recalculation as a student would trigger it
  $t3 = Get-Date
  $wb2 = $xl.Workbooks.Open($out)
  $report.OpenSeconds = [math]::Round(((Get-Date) - $t3).TotalSeconds, 1)
  $t4 = Get-Date
  $xl.CalculateFull()
  $report.ReopenFullCalcSeconds = [math]::Round(((Get-Date) - $t4).TotalSeconds, 1)
  # edit one input value with automatic calculation, as a student would
  $xl.Calculation = -4105  # automatic
  $d2 = $wb2.Worksheets.Item('Data')
  $orig = $d2.Range('B2').Value2
  $sw = [Diagnostics.Stopwatch]::StartNew()
  $d2.Range('B2').Value2 = $orig + 1
  $report.EditRecalcSeconds = [math]::Round($sw.Elapsed.TotalSeconds, 2)
  $report.tb_lo_after_edit = $wb2.Worksheets.Item('BootRes').Range('H4').Value2
  $sw.Restart()
  $d2.Range('B2').Value2 = $orig
  $report.EditBackRecalcSeconds = [math]::Round($sw.Elapsed.TotalSeconds, 2)
  $report.tb_lo_restored = $wb2.Worksheets.Item('BootRes').Range('H4').Value2
  $xl.Calculation = -4135
  $wb2.Close($false)
} finally {
  $xl.Quit()
  [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
}
$report.GetEnumerator() | ForEach-Object { "{0}`t{1}" -f $_.Key, $_.Value }
