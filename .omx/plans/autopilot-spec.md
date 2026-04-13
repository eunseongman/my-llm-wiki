# Autopilot Spec: 대화 기반 개인 지식 도서관

## 입력 해석

사용자는 별도의 앱을 원하는 것이 아니라, 이 저장소 자체를 앞으로의 대화에서 추출한 지식이 쌓이는 개인 도서관으로 만들고 싶다. 이 저장소는 사용자와 LLM의 대화에서 나온 개념, 주제, 통찰, 질문, 종합 문서를 보관하고 연결하는 역할을 해야 한다.

## 원하는 결과

- 저장소를 지식 도서관 구조로 초기화한다
- 대화를 library 문서로 반영하는 최소한의 로컬 도구를 제공한다
- 미래 세션들이 같은 규칙으로 축적되도록 운영 가이드와 템플릿을 만든다
- 현재 대화에서 나온 핵심 내용을 첫 seed 문서로 반영한다

## 요구사항

### 필수

- `inbox/`, `archive/`, `library/`, `writing/`, `system/` 디렉터리 구조
- `library/index.md`, `library/log.md`
- session, concept, topic, synthesis, question, writing 템플릿
- 향후 대화를 어떻게 저장/정리/승격할지 적은 운영 가이드
- 대화 텍스트 파일 하나를 받아 session note와 관련 문서를 만드는 최소한의 로컬 스크립트
- 현재 대화 내용을 바탕으로 한 초기 도서관 문서

### 품질 요구

- 결과물은 한국어 중심으로 읽기 쉬워야 한다
- 링크와 frontmatter 규칙은 결정적이어야 한다
- raw 계층과 library 계층은 분리되어야 한다
- 스크립트는 외부 의존성 없이 로컬에서 실행 가능해야 한다

## 설계 결정

- 구현 언어는 표준 라이브러리만 사용하는 Python으로 한다
- 도구는 "완전 자동 지식 추출"보다 "안전한 초안 생성과 구조 유지"에 집중한다
- index/log는 우선 단순하고 읽기 쉬운 형식으로 관리한다
- 첫 구현은 보수적으로 session note 생성과 로그 기록, 인덱스 재생성까지 지원한다

## 산출물

- 저장소 구조 및 `.gitkeep`
- 운영 문서와 템플릿
- `scripts/library_cli.py`
- seed session/concept/topic/synthesis/question/writing 문서
- 업데이트된 index/log
