<#
.SYNOPSIS
Render a supported chapter to PDF on explicit request; never called by the HTML build.
#>
[CmdletBinding()]
param(
    [ValidateSet(3, 4, 5, 6, 7)][int]$Chapter = 3,
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
    Copy-Item -LiteralPath 'scripts/pdf/chapter.lua' -Destination $build -Force
    Copy-Item -LiteralPath 'scripts/pdf/typography.lua' -Destination $build -Force
    Copy-Item -LiteralPath 'filters/table-style.lua' -Destination $build -Force
    $config = [IO.File]::ReadAllText((Join-Path $repo 'scripts/pdf/chapter.yml'))
    [IO.File]::WriteAllText("$build/_quarto.yml", $config.Replace('@NN@', $number), $utf8)
    $layout = [IO.File]::ReadAllText((Join-Path $repo 'scripts/pdf/layout.typ'))
    $layout = $layout.Replace('@CHAPTER@', [string]$Chapter).Replace('@OFFSET@', [string]($Chapter - 1))
    # Chapters 4 and 5 contain short tables; keep each table on one page.
    if ($Chapter -in 4, 5) { $layout += "`n#show table: it => block(breakable: false, it)`n" }
    if ($Chapter -eq 5) { $layout += "`n#show table: it => block(breakable: false, { show raw: set text(size: 7pt); it })`n" }
    [IO.File]::WriteAllText("$build/layout.typ", $layout, $utf8)
    $source = [IO.File]::ReadAllText((Join-Path $repo "quarto/kapitola_$number.qmd"))
    # Adapt the one instruction that otherwise refers to the web's disclosure control.
    $source = $source.Replace('Řešení otevírejte až po vlastním pokusu.', 'Řešení v závěrečné části čtěte až po vlastním pokusu.')
    # Pipe tables with long cells get equal PDF columns; give wide ones text-led widths.
    $pdfColumnWidths = @{
        'tbl-k07-02' = '[9,37,40,14]'
        'tbl-k07-03' = '[7,10,15,14,15,13,26]'
    }
    foreach ($table in $pdfColumnWidths.Keys) {
        $source = $source.Replace("{#$table}", "{#$table tbl-colwidths=`"$($pdfColumnWidths[$table])`"}")
    }
    [IO.File]::WriteAllText("$build/quarto/kapitola_$number.qmd", $source, $utf8)
    Push-Location $build
    try {
        & $quarto render --to typst
        if ($LASTEXITCODE -ne 0) { throw 'PDF rendering failed; the previous output was preserved.' }
        # Citeproc emits bibliography text after Lua. Bind a final Czech single-letter
        # word to the following hyperlink there as well, without editing URL strings.
        $typPath = "$build/quarto/kapitola_$number.typ"
        $typSource = [IO.File]::ReadAllText($typPath)
        # Typst spaces upright() text away from a preceding variable ("p -hodnota");
        # a plain math string keeps a hyphenated label such as p-hodnota joined.
        $finalSource = [regex]::Replace($typSource, ' upright\("(-\p{L}+)"\)', '"$1"')
        # Spaces beside upright() text are kept in Typst math: join it to a slash.
        $finalSource = [regex]::Replace($finalSource, '\\/ (?=upright\(")', '\/')
        $finalSource = [regex]::Replace($finalSource, '(?<=upright\("[^"]*"\)) (?=\\/)', '')
        # Escaped bars around one symbol are an absolute value, e.g. |t|.
        $finalSource = [regex]::Replace($finalSource, '\\\| (\w+) \\\|', 'abs($1)')
        $refsStart = $finalSource.IndexOf('<pdf-references>')
        if ($refsStart -ge 0) {
            $refsText = $finalSource.Substring($refsStart)
            $boundRefs = [regex]::Replace($refsText, '(?<![\p{L}\p{N}_])([aikousvzAIKOUSVZ]) (?=#link\()', '$1~')
            $finalSource = $finalSource.Substring(0, $refsStart) + $boundRefs
        }
        if ($finalSource -cne $typSource) {
            [IO.File]::WriteAllText($typPath, $finalSource, $utf8)
            $quartoShare = (& $quarto --paths)[-1]
            & $quarto typst compile $typPath --root $build --package-path "$quartoShare/formats/typst/packages" --font-path "$quartoShare/formats/typst/fonts"
            if ($LASTEXITCODE -ne 0) { throw 'Final PDF typography compilation failed; previous output preserved.' }
        }
    } finally { Pop-Location }
    $pdf = "$build/quarto/kapitola_$number.pdf"
    if (-not (Test-Path -LiteralPath $pdf)) { throw "Missing rendered PDF: $pdf" }
    Copy-Item -LiteralPath $pdf -Destination "$output/kapitola_$number.pdf" -Force
    Write-Output "PDF: $output/kapitola_$number.pdf"
} finally {
    $env:LC_ALL = $previousLocale
    Pop-Location
}
