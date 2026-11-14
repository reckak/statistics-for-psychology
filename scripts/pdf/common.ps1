# Shared steps of the on-request PDF scripts (render-chapter-pdf.ps1, render-book-pdf.ps1).

function Find-Executable($Specified, $Name, $Fallback) {
    if ($Specified) { return (Get-Item -LiteralPath $Specified).FullName }
    $command = Get-Command $Name -ErrorAction SilentlyContinue
    if ($command) { return $command.Source }
    if (Test-Path -LiteralPath $Fallback) { return $Fallback }
    throw "Install $Name or supply its path explicitly."
}

# Pipe tables with long cells get equal PDF columns; give wide ones text-led widths.
# Shared by the chapter and book PDFs; the web keeps its own column layout.
$PdfColumnWidths = @{
    'tbl-k07-02' = '[9,37,40,14]'
    'tbl-k07-03' = '[7,10,15,14,15,13,26]'
}
function Set-PdfColumnWidths([string]$Source) {
    foreach ($table in $PdfColumnWidths.Keys) {
        $Source = $Source.Replace("{#$table}", "{#$table tbl-colwidths=`"$($PdfColumnWidths[$table])`"}")
    }
    $Source
}

# Final Typst corrections after Quarto's render; recompiles only when something changed.
function Complete-PdfTypography($Quarto, $TypPath, $Root, $ReferencesLabel) {
    $utf8 = New-Object System.Text.UTF8Encoding($false)
    $typSource = [IO.File]::ReadAllText($TypPath)
    # Typst spaces upright() text away from a preceding variable ("p -hodnota");
    # a plain math string keeps a hyphenated label such as p-hodnota joined.
    $finalSource = [regex]::Replace($typSource, ' upright\("(-\p{L}+)"\)', '"$1"')
    # Spaces beside upright() text are kept in Typst math: join it to a slash.
    $finalSource = [regex]::Replace($finalSource, '\\/ (?=upright\(")', '\/')
    $finalSource = [regex]::Replace($finalSource, '(?<=upright\("[^"]*"\)) (?=\\/)', '')
    # Escaped bars around one symbol are an absolute value, e.g. |t|.
    $finalSource = [regex]::Replace($finalSource, '\\\| (\w+) \\\|', 'abs($1)')
    # Citeproc emits bibliography text after Lua. Bind a final Czech single-letter
    # word to the following hyperlink there as well, without editing URL strings.
    $refsStart = $finalSource.IndexOf("<$ReferencesLabel>")
    if ($refsStart -ge 0) {
        $refsText = $finalSource.Substring($refsStart)
        $boundRefs = [regex]::Replace($refsText, '(?<![\p{L}\p{N}_])([aikousvzAIKOUSVZ]) (?=#link\()', '$1~')
        $finalSource = $finalSource.Substring(0, $refsStart) + $boundRefs
    }
    if ($finalSource -cne $typSource) {
        [IO.File]::WriteAllText($TypPath, $finalSource, $utf8)
        $quartoShare = (& $Quarto --paths)[-1]
        & $Quarto typst compile $TypPath --root $Root --package-path "$quartoShare/formats/typst/packages" --font-path "$quartoShare/formats/typst/fonts"
        if ($LASTEXITCODE -ne 0) { throw 'Final PDF typography compilation failed; previous output preserved.' }
    }
}
