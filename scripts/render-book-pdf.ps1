<#
.SYNOPSIS
Render one working PDF of chapters 1-6 with literature and the reference overviews.
Runs only on explicit request; the HTML build never calls it.
#>
[CmdletBinding()]
param(
    [string]$QuartoPath,
    [string]$RscriptPath
)
$ErrorActionPreference = 'Stop'
$repo = Split-Path $PSScriptRoot -Parent
. (Join-Path $PSScriptRoot 'pdf/common.ps1')
$quarto = Find-Executable $QuartoPath 'quarto' 'C:/Program Files/RStudio/resources/app/bin/quarto/bin/quarto.exe'
$rscript = Find-Executable $RscriptPath 'Rscript' 'C:/Program Files/R/R-4.5.1/bin/Rscript.exe'
$chapters = 1..6
$build = Join-Path $repo 'tmp/pdf-book'
$output = Join-Path $repo 'output/pdf'
$target = Join-Path $output 'ucebnice_01-06.pdf'
$utf8 = New-Object System.Text.UTF8Encoding($false)
$previousLocale = $env:LC_ALL
# Start from an empty helper folder; it is regenerated on every run.
if (Test-Path -LiteralPath $build) { Get-ChildItem -LiteralPath $build -Force | Remove-Item -Recurse -Force }
New-Item -ItemType Directory -Force -Path $build, "$build/quarto", "$build/assets", $output | Out-Null
Push-Location $repo
try {
    $env:LC_ALL = 'Czech_Czechia.utf8'
    foreach ($chapter in $chapters) {
        $number = '{0:00}' -f $chapter
        # The existing generators are the single source for the chapters' diagrams.
        & $rscript --vanilla -e "Sys.setlocale('LC_CTYPE', '.UTF-8'); source('scripts/kapitola_$number.R', encoding='UTF-8')"
        if ($LASTEXITCODE -ne 0) { throw "Figure generation failed for chapter $number." }
        Copy-Item -LiteralPath "assets/chapter-$number" -Destination "$build/assets" -Recurse -Force
    }
    Copy-Item -LiteralPath 'references.bib' -Destination $build -Force
    Copy-Item -LiteralPath 'styles/apa.csl' -Destination "$build/apa.csl" -Force
    foreach ($filter in 'scripts/pdf/book.lua', 'scripts/pdf/typography.lua', 'filters/table-style.lua') {
        Copy-Item -LiteralPath $filter -Destination $build -Force
    }
    Copy-Item -LiteralPath 'scripts/pdf/book.yml' -Destination "$build/_quarto.yml" -Force
    $layout = [IO.File]::ReadAllText((Join-Path $repo 'scripts/pdf/layout.typ')) +
        [IO.File]::ReadAllText((Join-Path $repo 'scripts/pdf/book-page.typ'))
    [IO.File]::WriteAllText("$build/layout.typ", $layout, $utf8)

    # Sentences that describe the web's controls or the whole book get PDF wording.
    $replacements = @{
        'index.qmd' = @{
            'a teprve potom otevřete **Ukázat řešení**.' = 'a teprve potom si přečtěte řešení na konci kapitoly.'
        }
        'quarto/kapitola_03.qmd' = @{
            'Řešení otevírejte až po vlastním pokusu.' = 'Řešení na konci kapitoly čtěte až po vlastním pokusu.'
        }
        'quarto/literatura.qmd' = @{
            'Společný seznam obsahuje zdroje citované v celé učebnici.' = 'Seznam obsahuje zdroje citované v kapitolách 1–6.'
        }
        'quarto/slovnicek.qmd' = @{ ' Vyhledávání zahrnuje i anglické názvy, alternativy a vysvětlení.' = '' }
        'quarto/znaceni.qmd' = @{ ' Vyhledávat lze i podle slovního významu.' = '' }
    }
    # Unnumbered pages get identifiers so that links to them stay inside the PDF.
    $pageIds = @{
        'index.qmd' = 'pdf-index'; 'quarto/literatura.qmd' = 'pdf-literatura'
        'quarto/slovnicek.qmd' = 'pdf-slovnicek'; 'quarto/znaceni.qmd' = 'pdf-znaceni'
        'quarto/excel.qmd' = 'pdf-excel'
    }
    $files = @('index.qmd') + ($chapters | ForEach-Object { 'quarto/kapitola_{0:00}.qmd' -f $_ }) +
        @('quarto/literatura.qmd', 'quarto/slovnicek.qmd', 'quarto/znaceni.qmd', 'quarto/excel.qmd')
    $parts = foreach ($file in $files) {
        $source = [IO.File]::ReadAllText((Join-Path $repo $file)).Replace("`r`n", "`n")
        if ($replacements.ContainsKey($file)) {
            foreach ($entry in $replacements[$file].GetEnumerator()) {
                if (-not $source.Contains($entry.Key)) { throw "Expected text not found in ${file}: $($entry.Key)" }
                $source = $source.Replace($entry.Key, $entry.Value)
            }
        }
        if ($pageIds.ContainsKey($file)) {
            $source = [regex]::Replace($source, '\A# (.+?) \{\.unnumbered\}', "# `$1 {#$($pageIds[$file]) .unnumbered}")
        }
        # Raw HTML reference tables reach the filter as one block.
        $source = $source.Replace("<!--| quarto-html-table-processing: none -->`n", '')
        $source = [regex]::Replace($source, '(?s)(<table .*?</table>)', "``````{=html}`n`$1`n``````")
        $source.TrimEnd() + "`n"
    }
    [IO.File]::WriteAllText("$build/quarto/kniha.qmd", ($parts -join "`n"), $utf8)
    # Remove the project render list entry's directory prefix: kniha.qmd lives in quarto/.
    $config = [IO.File]::ReadAllText("$build/_quarto.yml").Replace('    - kniha.qmd', '    - quarto/kniha.qmd')
    [IO.File]::WriteAllText("$build/_quarto.yml", $config, $utf8)

    Push-Location $build
    try {
        & $quarto render --to typst
        if ($LASTEXITCODE -ne 0) { throw 'PDF rendering failed; the previous output was preserved.' }
        Complete-PdfTypography $quarto "$build/quarto/kniha.typ" $build 'pdf-literatura'
    } finally { Pop-Location }
    $pdf = "$build/quarto/kniha.pdf"
    if (-not (Test-Path -LiteralPath $pdf)) { throw "Missing rendered PDF: $pdf" }
    Copy-Item -LiteralPath $pdf -Destination $target -Force
    Write-Output "PDF: $target"
} finally {
    $env:LC_ALL = $previousLocale
    Pop-Location
}
