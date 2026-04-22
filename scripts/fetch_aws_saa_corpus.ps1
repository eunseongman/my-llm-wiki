param(
    [switch]$DownloadAll,
    [int]$MaxPagesPerService = 0
)

$ErrorActionPreference = "Stop"

$workspace = Get-Location
$root = Join-Path $workspace ".omx\aws-saa"
$examDir = Join-Path $root "raw\exam"
$sitemapDir = Join-Path $root "sitemaps"
$urlListDir = Join-Path $root "url-lists"
$seedDir = Join-Path $root "seeds"
$pageDir = Join-Path $root "pages"

$null = New-Item -ItemType Directory -Force -Path $examDir, $sitemapDir, $urlListDir, $seedDir, $pageDir

$manifest = [ordered]@{
    examPages = @(
        "https://docs.aws.amazon.com/aws-certification/latest/solutions-architect-associate-03/solutions-architect-associate-03.md",
        "https://docs.aws.amazon.com/aws-certification/latest/solutions-architect-associate-03/solutions-architect-associate-03-domain1.md",
        "https://docs.aws.amazon.com/aws-certification/latest/solutions-architect-associate-03/solutions-architect-associate-03-domain2.md",
        "https://docs.aws.amazon.com/aws-certification/latest/solutions-architect-associate-03/solutions-architect-associate-03-domain3.md",
        "https://docs.aws.amazon.com/aws-certification/latest/solutions-architect-associate-03/solutions-architect-associate-03-domain4.md",
        "https://docs.aws.amazon.com/aws-certification/latest/solutions-architect-associate-03/saa-technologies-concepts.md",
        "https://docs.aws.amazon.com/aws-certification/latest/solutions-architect-associate-03/saa-service-mentions.md",
        "https://docs.aws.amazon.com/aws-certification/latest/solutions-architect-associate-03/saa-03-in-scope-services.md",
        "https://docs.aws.amazon.com/aws-certification/latest/solutions-architect-associate-03/saa-03-out-of-scope-services.md"
    )
    serviceSitemaps = @(
        @{ name = "amazon-ec2"; sitemap = "https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/sitemap.xml" },
        @{ name = "amazon-s3"; sitemap = "https://docs.aws.amazon.com/AmazonS3/latest/userguide/sitemap.xml" },
        @{ name = "amazon-rds"; sitemap = "https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/sitemap.xml" },
        @{ name = "amazon-aurora"; sitemap = "https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/sitemap.xml" },
        @{ name = "amazon-dynamodb"; sitemap = "https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/sitemap.xml" },
        @{ name = "aws-lambda"; sitemap = "https://docs.aws.amazon.com/lambda/latest/dg/sitemap.xml" },
        @{ name = "amazon-vpc"; sitemap = "https://docs.aws.amazon.com/vpc/latest/userguide/sitemap.xml" },
        @{ name = "transit-gateway"; sitemap = "https://docs.aws.amazon.com/vpc/latest/tgw/sitemap.xml" },
        @{ name = "amazon-route53"; sitemap = "https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/sitemap.xml" },
        @{ name = "amazon-cloudfront"; sitemap = "https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/sitemap.xml" },
        @{ name = "elastic-load-balancing-app"; sitemap = "https://docs.aws.amazon.com/elasticloadbalancing/latest/application/sitemap.xml" },
        @{ name = "elastic-load-balancing-net"; sitemap = "https://docs.aws.amazon.com/elasticloadbalancing/latest/network/sitemap.xml" },
        @{ name = "amazon-ecs"; sitemap = "https://docs.aws.amazon.com/AmazonECS/latest/developerguide/sitemap.xml" },
        @{ name = "amazon-eks"; sitemap = "https://docs.aws.amazon.com/eks/latest/userguide/sitemap.xml" },
        @{ name = "amazon-sqs"; sitemap = "https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sitemap.xml" },
        @{ name = "amazon-sns"; sitemap = "https://docs.aws.amazon.com/sns/latest/dg/sitemap.xml" },
        @{ name = "amazon-api-gateway"; sitemap = "https://docs.aws.amazon.com/apigateway/latest/developerguide/sitemap.xml" },
        @{ name = "aws-cloudformation"; sitemap = "https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/sitemap.xml" },
        @{ name = "amazon-cloudwatch"; sitemap = "https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/sitemap.xml" },
        @{ name = "aws-cloudtrail"; sitemap = "https://docs.aws.amazon.com/awscloudtrail/latest/userguide/sitemap.xml" },
        @{ name = "aws-kms"; sitemap = "https://docs.aws.amazon.com/kms/latest/developerguide/sitemap.xml" },
        @{ name = "aws-secrets-manager"; sitemap = "https://docs.aws.amazon.com/secretsmanager/latest/userguide/sitemap.xml" },
        @{ name = "aws-organizations"; sitemap = "https://docs.aws.amazon.com/organizations/latest/userguide/sitemap.xml" },
        @{ name = "aws-config"; sitemap = "https://docs.aws.amazon.com/config/latest/developerguide/sitemap.xml" },
        @{ name = "aws-guardduty"; sitemap = "https://docs.aws.amazon.com/guardduty/latest/ug/sitemap.xml" },
        @{ name = "aws-waf"; sitemap = "https://docs.aws.amazon.com/waf/latest/developerguide/sitemap.xml" },
        @{ name = "aws-systems-manager"; sitemap = "https://docs.aws.amazon.com/systems-manager/latest/userguide/sitemap.xml" },
        @{ name = "aws-backup"; sitemap = "https://docs.aws.amazon.com/aws-backup/latest/devguide/sitemap.xml" },
        @{ name = "aws-direct-connect"; sitemap = "https://docs.aws.amazon.com/directconnect/latest/UserGuide/sitemap.xml" }
    )
}

$manifestPath = Join-Path $root "manifest.json"
$manifest | ConvertTo-Json -Depth 6 | Set-Content -Encoding utf8 $manifestPath

function Save-RemoteFile {
    param(
        [string]$Url,
        [string]$OutFile
    )
    Invoke-WebRequest -UseBasicParsing -Uri $Url -OutFile $OutFile
}

function Get-SitemapUrls {
    param([string]$SitemapPath)
    [xml]$xml = Get-Content -Raw $SitemapPath
    @($xml.urlset.url | ForEach-Object { $_.loc.Trim() }) | Where-Object { $_ }
}

function Get-SafeName {
    param([string]$Value)
    ($Value -replace "[^a-zA-Z0-9._-]", "_")
}

foreach ($url in $manifest.examPages) {
    $name = Split-Path $url -Leaf
    $outFile = Join-Path $examDir $name
    Save-RemoteFile -Url $url -OutFile $outFile
}

$summary = @()

foreach ($svc in $manifest.serviceSitemaps) {
    $serviceName = $svc.name
    $sitemapUrl = $svc.sitemap
    $sitemapPath = Join-Path $sitemapDir "$serviceName.xml"
    $urlListPath = Join-Path $urlListDir "$serviceName.txt"
    $seedServiceDir = Join-Path $seedDir $serviceName
    $pagesServiceDir = Join-Path $pageDir $serviceName

    $null = New-Item -ItemType Directory -Force -Path $seedServiceDir, $pagesServiceDir

    Save-RemoteFile -Url $sitemapUrl -OutFile $sitemapPath
    $urls = Get-SitemapUrls -SitemapPath $sitemapPath
    $urls | Set-Content -Encoding utf8 $urlListPath

    if ($urls.Count -gt 0) {
        $seedUrl = $urls[0]
        $seedName = Get-SafeName ([IO.Path]::GetFileName([uri]$seedUrl))
        if (-not $seedName) {
            $seedName = "index.html"
        }
        $seedPath = Join-Path $seedServiceDir $seedName
        Save-RemoteFile -Url $seedUrl -OutFile $seedPath
    }

    if ($DownloadAll) {
        $targets = $urls
        if ($MaxPagesPerService -gt 0) {
            $targets = $targets | Select-Object -First $MaxPagesPerService
        }

        $mapLines = New-Object System.Collections.Generic.List[string]
        $i = 0
        foreach ($target in $targets) {
            $i += 1
            $ext = [IO.Path]::GetExtension(([uri]$target).AbsolutePath)
            if (-not $ext) {
                $ext = ".html"
            }
            $fileName = "{0:D5}{1}" -f $i, $ext
            $outFile = Join-Path $pagesServiceDir $fileName
            Save-RemoteFile -Url $target -OutFile $outFile
            $mapLines.Add("$fileName`t$target")
        }
        $mapLines | Set-Content -Encoding utf8 (Join-Path $pagesServiceDir "index.tsv")
    }

    $summary += [pscustomobject]@{
        service = $serviceName
        sitemap = $sitemapUrl
        urlCount = $urls.Count
        downloadedAll = [bool]$DownloadAll
        maxPagesPerService = $MaxPagesPerService
    }
}

$summary | ConvertTo-Json -Depth 4 | Set-Content -Encoding utf8 (Join-Path $root "summary.json")
Write-Output "AWS SAA corpus bootstrap complete."
