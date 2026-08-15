#!/usr/bin/env pwsh
# Verifies the setup prompt stays byte-identical across prompt.txt, README.md,
# and index.html. Exits 1 with a diff if any copy has drifted.
# Usage: pwsh scripts/check-prompt-sync.ps1  (run from repo root)

$ErrorActionPreference = "Stop"
$root = Split-Path $PSScriptRoot -Parent
$canonical = Get-Content (Join-Path $root "prompt.txt") -Raw

function Get-ReadmeBlock([string]$text) {
    if ($text -notmatch '(?s)```text\r?\n(.*?)```') { return $null }
    return $Matches[1].TrimEnd("`r`n") + "`n"
}

function Get-HtmlBlock([string]$text) {
    if ($text -notmatch '(?s)<pre[^>]*id="setup-prompt"[^>]*>(.*?)</pre>') { return $null }
    return [System.Net.WebUtility]::HtmlDecode($Matches[1])
}

$failures = @()

$readme = Get-Content (Join-Path $root "README.md") -Raw
$readmeBlock = Get-ReadmeBlock $readme
if ($null -eq $readmeBlock) {
    $failures += "README.md: no ```text fenced prompt block found"
} elseif ($readmeBlock -cne $canonical) {
    $failures += "README.md prompt block differs from prompt.txt"
}

$html = Get-Content (Join-Path $root "index.html") -Raw
$htmlBlock = Get-HtmlBlock $html
if ($null -eq $htmlBlock) {
    $failures += "index.html: no <pre id=`"setup-prompt`"> block found"
} elseif ($htmlBlock -cne $canonical) {
    $failures += "index.html prompt block differs from prompt.txt"
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Host "DRIFT: $_" -ForegroundColor Red }
    Write-Host "Canonical source: prompt.txt — sync the copies, don't edit around them." -ForegroundColor Yellow
    exit 1
}

Write-Host "OK: prompt.txt = README.md block = index.html block ($($canonical.Length) chars)" -ForegroundColor Green
exit 0
