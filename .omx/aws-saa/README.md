# AWS SAA Corpus

This directory stores the official AWS SAA-C03 corpus bootstrap artifacts.

## What is stored

- `manifest.json`
  - exam-guide markdown pages and selected service sitemap URLs
- `raw/exam/`
  - official SAA-C03 exam guide pages in markdown
- `sitemaps/`
  - downloaded AWS service sitemap XML files
- `url-lists/`
  - extracted page URL lists per service
- `seeds/`
  - first official page fetched from each service sitemap
- `pages/`
  - optional full-page downloads when `-DownloadAll` is used
- `summary.json`
  - URL counts per selected service

## How to refresh

```powershell
.\scripts\fetch_aws_saa_corpus.ps1
```

This refreshes the exam guide, service sitemaps, URL lists, and seed pages.

## How to do a heavier crawl

```powershell
.\scripts\fetch_aws_saa_corpus.ps1 -DownloadAll
```

Optional cap:

```powershell
.\scripts\fetch_aws_saa_corpus.ps1 -DownloadAll -MaxPagesPerService 50
```

## Notes

- This bootstrap focuses on SAA core services first.
- Full recursive collection across every in-scope service can become very large.
- All sources are official AWS documentation pages or official AWS Certification exam-guide pages.
