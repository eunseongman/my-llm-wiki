# Autopilot Implementation Plan: 대화 기반 개인 지식 도서관

## 구현 순서

1. 저장소 구조 생성
2. 운영 문서와 템플릿 작성
3. 라이브러리 유지용 경량 CLI 작성
4. 현재 대화 기반 seed 문서 작성
5. 인덱스/로그 정리
6. 스크립트 검증 및 결과 검토

## 구현 항목

### A. 구조

- `inbox/`
- `archive/`
- `library/concepts/`
- `library/topics/`
- `library/sessions/`
- `library/syntheses/`
- `library/questions/`
- `writing/posts/`
- `system/templates/`
- `scripts/`

### B. 운영 문서

- `README.md`: 저장소 목적과 사용 흐름
- `system/guide.md`: 운영 원칙, 문서 규칙, ingest/query/lint 흐름
- `system/templates/*.md`: 문서 템플릿

### C. 로컬 도구

- `library_cli.py init-index`
- `library_cli.py new-session --title --date --summary-file`
- `library_cli.py rebuild-index`
- `library_cli.py log --type --title --details`

### D. seed 문서

- "대화 기반 개인 지식 도서관" topic note
- "LLM 위키" concept note
- "지식 도서관과 앱의 차이" concept note
- 현재 세션 note
- 앞으로 쌓을 질문 note
- 블로그형 요약 글 1개

## 검증 계획

- CLI 도움말 실행
- session 생성 명령 실행
- index 재생성 실행
- 생성된 파일/로그 검토
