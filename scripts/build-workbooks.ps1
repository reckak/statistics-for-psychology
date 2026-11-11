param([ValidateRange(1,10)][int[]]$Chapter=@(1,2,3,4,5,6,7,8,9,10),[switch]$Verify)
# Common entry point. Requires ordinary Node.js, Windows PowerShell and Excel;
# Rscript (base R only) supplies fixed simulations for chapters 1, 4, 5, 6 and 7
# and the data and fixed resampling indices for chapter 10.
$ErrorActionPreference='Stop'
$taskRoot=(Resolve-Path (Join-Path $PSScriptRoot '..')).Path
Push-Location $taskRoot
try {
  if(@($Chapter | Where-Object {$_ -in 4,5,6,7}).Count){
    & Rscript --vanilla scripts/sesity-simulace.R
    if($LASTEXITCODE -ne 0){throw 'Simulation inputs failed'}
  }
  if(@($Chapter | Where-Object {$_ -eq 10}).Count){
    # Same data and resampling indices as the book; figures are skipped.
    $env:CH10_NOFIG='1'
    & Rscript --vanilla -e "if(.Platform`$OS.type=='windows')Sys.setlocale('LC_CTYPE','.UTF-8');source('scripts/kapitola_10.R',encoding='UTF-8')"
    $code=$LASTEXITCODE;Remove-Item Env:CH10_NOFIG
    if($code -ne 0){throw 'Chapter 10 inputs failed'}
  }
  foreach($n in ($Chapter|Select-Object -Unique)){
    # Avoid non-ASCII literals in Windows PowerShell 5.1 source.
    $builder=Join-Path $PSScriptRoot ('kapitola_{0:00}-se{1}it.mjs' -f $n,[char]0x161)
    & node $builder
    if($LASTEXITCODE -ne 0){throw "Chapter $n build failed"}
    if($Verify -and $n -ge 2){
      & powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $taskRoot ('quarto/_verification/check-chapter-{0:00}-excel.ps1' -f $n))
      if($LASTEXITCODE -ne 0){throw "Chapter $n Excel verification failed"}
    }
  }
  if($Verify){
    & powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $taskRoot 'quarto/_verification/check-workbooks-excel.ps1')
    if($LASTEXITCODE -ne 0){throw 'Workbook verification failed'}
  }
} finally {Pop-Location}
