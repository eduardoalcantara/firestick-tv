# validate-structure.ps1 — confere a árvore mínima listada em min-tree.txt
[CmdletBinding()]
param(
    [switch]$Help
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Show-Usage {
    @"
Uso: validate-structure.ps1 [-Help]

Valida arquivos e pastas da única lista: scripts/validation/min-tree.txt

Opções:
  -Help    Mostra esta ajuda
"@
}

function Find-RepoRoot {
    $dir = $PSScriptRoot
    while ($true) {
        $spec = Join-Path $dir 'spec-root.md'
        $rules = Join-Path $dir 'rules.md'
        if ((Test-Path -LiteralPath $spec) -and (Test-Path -LiteralPath $rules)) {
            return $dir
        }
        $parent = Split-Path -Parent $dir
        if ([string]::IsNullOrEmpty($parent) -or $parent -eq $dir) {
            return $null
        }
        $dir = $parent
    }
}

if ($Help) {
    Show-Usage
    exit 0
}

if ($Host.UI.SupportsVirtualTerminal) {
    Clear-Host
}

$root = Find-RepoRoot
if (-not $root) {
    Write-Error "FAIL: raiz do repositório não encontrada (marcadores: spec-root.md + rules.md)"
    exit 1
}

$listPath = Join-Path $root 'scripts/validation/min-tree.txt'
if (-not (Test-Path -LiteralPath $listPath -PathType Leaf)) {
    Write-Error "FAIL: lista ausente: scripts/validation/min-tree.txt"
    exit 1
}

Write-Host "validate-structure.ps1 — validar árvore mínima (min-tree.txt)"
Write-Host "Raiz: $root"
Write-Host ""

$entries = @(Get-Content -LiteralPath $listPath | ForEach-Object {
    $line = $_.Trim()
    if ($line -and -not $line.StartsWith('#')) { $line }
})

$missing = 0
foreach ($entry in $entries) {
    $isDir = $entry.EndsWith('/')
    $rel = $entry.TrimEnd('/')
    $path = Join-Path $root ($rel -replace '/', [IO.Path]::DirectorySeparatorChar)
    if ($isDir) {
        if (Test-Path -LiteralPath $path -PathType Container) {
            Write-Host "OK   dir   $entry"
        }
        else {
            Write-Host "FAIL dir   $entry"
            $missing++
        }
    }
    else {
        if (Test-Path -LiteralPath $path -PathType Leaf) {
            Write-Host "OK   file  $rel"
        }
        else {
            Write-Host "FAIL file  $rel"
            $missing++
        }
    }
}

Write-Host ""
if ($missing -eq 0) {
    Write-Host "OK: estrutura mínima completa ($($entries.Count) itens)."
    exit 0
}

Write-Error "FAIL: $missing item(ns) ausente(s)."
exit 1
