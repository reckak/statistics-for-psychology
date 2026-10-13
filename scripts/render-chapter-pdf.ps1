<#
.SYNOPSIS
Render chapter 3 to PDF on explicit request; the HTML build never calls this script.
#>
[CmdletBinding()]
param(
    [ValidateSet(3)][int]$Chapter = 3,
    [string]$QuartoPath,
    [string]$RscriptPath
)
$ErrorActionPreference = 'Stop'
$repo = Split-Path $PSScriptRoot -Parent
function Find-Executable($Specified, $Name, $Fallback) {
    if ($Specified) { return (Get-Item -LiteralPath $Specified).FullName }
    $command = Get-Command $Name -ErrorAction SilentlyContinue
    if ($command) { return $command.Source }
    if (Test-Path -LiteralPath $Fallback) { return $Fallback }
    throw "Install $Name or supply its path explicitly."
}
$quarto = Find-Executable $QuartoPath 'quarto' 'C:/Program Files/RStudio/resources/app/bin/quarto/bin/quarto.exe'
$rscript = Find-Executable $RscriptPath 'Rscript' 'C:/Program Files/R/R-4.5.1/bin/Rscript.exe'
$number = '{0:00}' -f $Chapter
$build = Join-Path $repo "tmp/pdf-chapter-$number"
$output = Join-Path $repo 'output/pdf'
$utf8 = New-Object System.Text.UTF8Encoding($false)
$previousLocale = $env:LC_ALL
New-Item -ItemType Directory -Force -Path $build, "$build/quarto", "$build/assets", $output | Out-Null
Push-Location $repo
try {
    $env:LC_ALL = 'Czech_Czechia.utf8'
    # The existing generator is the single source for the chapter's diagrams.
    & $rscript --vanilla -e "Sys.setlocale('LC_CTYPE', '.UTF-8'); source('scripts/kapitola_$number.R', encoding='UTF-8')"
    if ($LASTEXITCODE -ne 0) { throw 'Figure generation failed.' }
    Copy-Item -LiteralPath "assets/chapter-$number" -Destination "$build/assets" -Recurse -Force
    Copy-Item -LiteralPath 'references.bib' -Destination $build -Force
    Copy-Item -LiteralPath 'styles/apa.csl' -Destination "$build/apa.csl" -Force
    Copy-Item -LiteralPath 'scripts/pdf/chapter.lua', 'scripts/pdf/layout.typ' -Destination $build -Force
    Copy-Item -LiteralPath 'scripts/pdf/chapter.yml' -Destination "$build/_quarto.yml" -Force
    $source = [IO.File]::ReadAllText((Join-Path $repo "quarto/kapitola_$number.qmd"))
    # Adapt the one instruction that otherwise refers to the web's disclosure control.
    $source = $source.Replace('Řešení otevírejte až po vlastním pokusu.', 'Řešení v závěrečné části čtěte až po vlastním pokusu.')
    [IO.File]::WriteAllText("$build/quarto/kapitola_$number.qmd", $source, $utf8)
    Push-Location $build
    try {
        & $quarto render --to typst
        if ($LASTEXITCODE -ne 0) { throw 'PDF rendering failed; the previous output was preserved.' }
    } finally { Pop-Location }
    $pdf = "$build/quarto/kapitola_$number.pdf"
    if (-not (Test-Path -LiteralPath $pdf)) { throw "Missing rendered PDF: $pdf" }
    Copy-Item -LiteralPath $pdf -Destination "$output/kapitola_$number.pdf" -Force
    Write-Output "PDF: $output/kapitola_$number.pdf"
} finally {
    $env:LC_ALL = $previousLocale
    Pop-Location
}
