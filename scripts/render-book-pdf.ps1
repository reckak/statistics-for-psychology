<#
.SYNOPSIS
Render the PDF of the whole book: introduction, all chapters listed in _quarto.yml,
literature and the reference overviews. Runs only on explicit request; the HTML
build never calls it. The result is published as a GitHub release (docs/PROVOZ.md).
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
# Chapters in the book's order; new chapters in _quarto.yml enter the PDF automatically.
$chapters = @([regex]::Matches([IO.File]::ReadAllText((Join-Path $repo '_quarto.yml')), 'quarto/kapitola_(\d\d)\.qmd') |
    ForEach-Object { [int]$_.Groups[1].Value })
if ($chapters.Count -eq 0) { throw 'No chapters found in _quarto.yml.' }
$build = Join-Path $repo 'tmp/pdf-book'
$output = Join-Path $repo 'output/pdf'
$target = Join-Path $output 'zaklady-statistiky-pro-psychology.pdf'
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
    # The title page states the date of the build, so a printed copy shows its version.
    $config = [IO.File]::ReadAllText((Join-Path $repo 'scripts/pdf/book.yml'))
    $config = $config.Replace('@DATE@', (Get-Date).ToString('d. M. yyyy'))
    [IO.File]::WriteAllText("$build/_quarto.yml", $config, $utf8)
    $layout = [IO.File]::ReadAllText((Join-Path $repo 'scripts/pdf/layout.typ')) +
        [IO.File]::ReadAllText((Join-Path $repo 'scripts/pdf/book-page.typ'))
    [IO.File]::WriteAllText("$build/layout.typ", $layout, $utf8)

    # Sentences that describe the web's controls or the whole book get PDF wording.
    $replacements = @{
        'index.qmd' = @{
            'a teprve potom otevřete **Ukázat řešení**.' = 'a teprve potom si přečtěte řešení na konci kapitoly.'
            # The PDF does not offer itself for download.
            "`n`nCelou učebnici si můžete stáhnout také jako [PDF](https://github.com/reckak/statistics-for-psychology/releases/download/ucebnice-pdf/zaklady-statistiky-pro-psychology.pdf), například k tisku nebo ke čtení bez připojení. Řešení cvičení jsou v něm na konci každé kapitoly. Interaktivní vizualizace a sešity s daty jsou jen na webu a odkazy z PDF vedou tam. Web průběžně doplňujeme; datum na titulní straně PDF ukazuje, ze kdy je stažená verze." = ''
        }
        'quarto/kapitola_03.qmd' = @{
            'Řešení otevírejte až po vlastním pokusu.' = 'Řešení na konci kapitoly čtěte až po vlastním pokusu.'
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
    # Web pages are separate documents, so two chapters may share an identifier;
    # in the one PDF the later chapter's copy gets the suffix -kNN.
    $seen = @{}
    $renames = foreach ($file in $files) {
        $text = [IO.File]::ReadAllText((Join-Path $repo $file))
        foreach ($id in ([regex]::Matches($text, '\{#([A-Za-z][\w-]*)') | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique)) {
            if (-not $seen.ContainsKey($id)) { $seen[$id] = $file; continue }
            $chapter = [regex]::Match($file, 'kapitola_(\d\d)\.qmd$')
            if (-not $chapter.Success) { throw "Identifier $id in $file repeats one from $($seen[$id])." }
            [pscustomobject]@{ File = $file; Number = $chapter.Groups[1].Value; Id = $id }
        }
    }
    foreach ($r in $renames) { Write-Output "PDF: $($r.File): identifier $($r.Id) renamed to $($r.Id)-k$($r.Number)." }
    $parts = foreach ($file in $files) {
        $source = [IO.File]::ReadAllText((Join-Path $repo $file)).Replace("`r`n", "`n")
        $source = Set-PdfColumnWidths $source
        foreach ($r in $renames) {
            $id = [regex]::Escape($r.Id); $new = "$($r.Id)-k$($r.Number)"
            # Links from any page to that chapter's copy.
            $source = [regex]::Replace($source, "(kapitola_$($r.Number)\.(?:qmd|html)#)$id(?![\w-])", "`${1}$new")
            if ($file -eq $r.File) {
                # The definition, same-page links and cross-references in the chapter itself.
                $source = [regex]::Replace($source, "(?<=[{(]#)$id(?![\w-])", $new)
                $source = [regex]::Replace($source, "(?<![\w.@])@$id(?![\w-])", "@$new")
            }
        }
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
        # Interactive visualizations exist only on the web, so the PDF links there.
        $source = [regex]::Replace($source, '\]\((viz_[a-z0-9_]+)\.qmd(#[^)\s]*)?\)', '](https://reckak.github.io/statistics-for-psychology/quarto/$1.html$2)')
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
