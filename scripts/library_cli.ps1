param(
    [Parameter(Position = 0, Mandatory = $true)]
    [ValidateSet("rebuild-index", "log", "new-session")]
    [string]$Command,

    [string]$Root = "",
    [string]$Title,
    [string]$Date,
    [string]$SummaryFile,
    [string]$Type,
    [string]$Details,
    [switch]$ArchiveCopy
)

if ([string]::IsNullOrWhiteSpace($Root)) {
    $Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
}

function Ensure-Structure {
    param([string]$Base)

    @(
        "inbox",
        "archive",
        "library\concepts",
        "library\topics",
        "library\sessions",
        "library\syntheses",
        "library\questions",
        "writing\posts",
        "system\templates"
    ) | ForEach-Object {
        New-Item -ItemType Directory -Force (Join-Path $Base $_) | Out-Null
    }
}

function Get-Slug {
    param([string]$Value)

    $ascii = [System.Text.Encoding]::ASCII.GetString(
        [System.Text.Encoding]::GetEncoding("Cyrillic").GetBytes($Value)
    )
    $lower = $ascii.ToLowerInvariant()
    $slug = $lower -replace "[^a-z0-9]+", "-" -replace "^-+", "" -replace "-+$", ""
    if ([string]::IsNullOrWhiteSpace($slug)) {
        $hash = [Math]::Abs($Value.GetHashCode())
        return "note-$hash"
    }
    return $slug
}

function Read-Utf8 {
    param([string]$Path)
    return Get-Content -LiteralPath $Path -Raw -Encoding utf8
}

function Write-Utf8 {
    param(
        [string]$Path,
        [string]$Content
    )
    $dir = Split-Path -Parent $Path
    if ($dir) {
        New-Item -ItemType Directory -Force $dir | Out-Null
    }
    [System.IO.File]::WriteAllText($Path, $Content, [System.Text.UTF8Encoding]::new($true))
}

function Get-DocTitle {
    param([string]$Path)
    $text = Read-Utf8 $Path
    if ($text -match '(?m)^title:\s*"?(.*?)"?$') {
        return $Matches[1].Trim()
    }
    if ($text -match '(?m)^#\s+(.+)$') {
        return $Matches[1].Trim()
    }
    return [System.IO.Path]::GetFileNameWithoutExtension($Path)
}

function Get-SummaryLine {
    param([string]$Path)
    $lines = (Read-Utf8 $Path) -split "`r?`n"
    $inFrontmatter = $false
    foreach ($line in $lines) {
        $trimmed = $line.Trim()
        if ($trimmed -eq "---") {
            $inFrontmatter = -not $inFrontmatter
            continue
        }
        if ($inFrontmatter) { continue }
        if (-not $trimmed) { continue }
        if ($trimmed.StartsWith("#")) { continue }
        return $trimmed
    }
    return "No summary"
}

function Add-LibraryLog {
    param(
        [string]$Base,
        [string]$EntryType,
        [string]$EntryTitle,
        [string]$EntryDetails
    )

    $logPath = Join-Path $Base "library\log.md"
    if (-not (Test-Path $logPath)) {
        Write-Utf8 $logPath "# Knowledge Library Log`n"
    }
    $stamp = Get-Date -Format "yyyy-MM-dd"
    $block = "`n## [$stamp] $EntryType | $EntryTitle`n`n- $EntryDetails`n"
    Add-Content -LiteralPath $logPath -Value $block -Encoding utf8
}

function Rebuild-Index {
    param([string]$Base)

    Ensure-Structure $Base
    $sections = @(
        @{ Folder = "sessions"; Label = "Sessions" },
        @{ Folder = "concepts"; Label = "Concepts" },
        @{ Folder = "topics"; Label = "Topics" },
        @{ Folder = "syntheses"; Label = "Syntheses" },
        @{ Folder = "questions"; Label = "Questions" }
    )

    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add("# Knowledge Library Index")
    $lines.Add("")
    $lines.Add("This file is the entry point to the library.")
    $lines.Add("")

    foreach ($section in $sections) {
        $lines.Add("## $($section.Label)")
        $lines.Add("")
        $dir = Join-Path $Base ("library\" + $section.Folder)
        $files = @(Get-ChildItem -LiteralPath $dir -Filter *.md | Sort-Object Name)
        if ($files.Count -eq 0) {
            $lines.Add("- No entries yet")
        } else {
            foreach ($file in $files) {
                $title = Get-DocTitle $file.FullName
                $summary = Get-SummaryLine $file.FullName
                $rel = $file.FullName.Substring($Base.Length + 1).Replace("\", "/")
                $lines.Add("- [$title](/C:/Users/user/working/llm-wiki/$rel): $summary")
            }
        }
        $lines.Add("")
    }

    $lines.Add("## Writing")
    $lines.Add("")
    $writingDir = Join-Path $Base "writing\posts"
    $writingFiles = @(Get-ChildItem -LiteralPath $writingDir -Filter *.md | Sort-Object Name)
    if ($writingFiles.Count -eq 0) {
        $lines.Add("- No entries yet")
    } else {
        foreach ($file in $writingFiles) {
            $title = Get-DocTitle $file.FullName
            $summary = Get-SummaryLine $file.FullName
            $rel = $file.FullName.Substring($Base.Length + 1).Replace("\", "/")
            $lines.Add("- [$title](/C:/Users/user/working/llm-wiki/$rel): $summary")
        }
    }
    $lines.Add("")

    $indexPath = Join-Path $Base "library\index.md"
    Write-Utf8 $indexPath ($lines -join "`n")
    return $indexPath
}

function New-SessionDraft {
    param(
        [string]$Base,
        [string]$SessionTitle,
        [string]$SessionDate,
        [string]$SourceFile,
        [bool]$ShouldArchive
    )

    Ensure-Structure $Base
    $slug = Get-Slug $SessionTitle
    $sourceResolved = (Resolve-Path $SourceFile).Path
    $sessionPath = Join-Path $Base ("library\sessions\" + $SessionDate + "-" + $slug + ".md")
    $excerpt = Get-SummaryLine $sourceResolved
    $content = @"
---
title: "$SessionTitle"
type: session
status: draft
created: $SessionDate
updated: $SessionDate
source_path: "$sourceResolved"
---

# $SessionTitle

## Today

- 

## Questions

- 

## Learnings

- $excerpt

## Linked Concepts

- 

## Open Questions

- 

## Related Notes

- 
"@
    Write-Utf8 $sessionPath $content

    if ($ShouldArchive) {
        $archiveTarget = Join-Path $Base ("archive\" + [System.IO.Path]::GetFileName($sourceResolved))
        Copy-Item -LiteralPath $sourceResolved -Destination $archiveTarget -Force
    }

    Add-LibraryLog -Base $Base -EntryType "ingest" -EntryTitle $SessionTitle -EntryDetails ("session note created: " + [System.IO.Path]::GetFileName($sessionPath))
    Rebuild-Index -Base $Base | Out-Null
    return $sessionPath
}

switch ($Command) {
    "rebuild-index" {
        $path = Rebuild-Index -Base $Root
        Write-Output ("index rebuilt: " + $path)
    }
    "log" {
        if (-not $Type -or -not $Title -or -not $Details) {
            throw "log requires -Type, -Title, and -Details."
        }
        Add-LibraryLog -Base $Root -EntryType $Type -EntryTitle $Title -EntryDetails $Details
        Write-Output "log appended"
    }
    "new-session" {
        if (-not $Title -or -not $Date -or -not $SummaryFile) {
            throw "new-session requires -Title, -Date, and -SummaryFile."
        }
        $path = New-SessionDraft -Base $Root -SessionTitle $Title -SessionDate $Date -SourceFile $SummaryFile -ShouldArchive:$ArchiveCopy
        Write-Output ("session created: " + $path)
    }
}
