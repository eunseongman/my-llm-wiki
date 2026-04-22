## PRD

- title: AWS SAA RAG 학습 도우미 MVP 설계안
- status: approved
- created: 2026-04-17
- updated: 2026-04-17
- source_spec: `.omx/specs/deep-interview-rag-project-topic-pivot.md`

## Summary

### Product

`자격증 취득 도우미`

부제:

`SAA 취득을 위한 RAG 학습 도우미`

### Core Goal

AWS SAA를 준비하는 수험생이 방대한 공식 문서를 전부 읽지 않아도,
핵심 개념 설명, 요약, 암기카드, 퀴즈를 통해 빠르게 학습할 수 있도록 돕는
RAG 기반 챗봇 MVP를 만든다.

### Why This Topic

- 공식 문서가 풍부해 RAG 코퍼스 구축에 적합하다.
- 시험 범위와 문서 출처를 명확하게 연결할 수 있다.
- 서비스 수가 다양해 RAG 파이프라인 전 과정을 시연하기 좋다.
- 실무 연관성이 높아 팀 프로젝트 주제로 설득력이 있다.

## Problem

AWS SAA는 시험 범위가 넓고, 서비스 수가 많고, 공식 문서도 방대하다.
취업 준비생은 제한된 시간 안에 어떤 서비스가 중요한지, 각 개념이 왜 중요한지,
무엇을 우선 암기해야 하는지를 빠르게 파악하기 어렵다.

이 프로젝트는 AWS 공식 문서를 기반으로

- 질문에 답하고
- 개념을 설명하고
- 핵심만 요약하고
- 암기카드와 퀴즈를 생성하는

학습 도우미를 제공해 학습 효율을 높이는 것을 목표로 한다.

## MVP Scope

### Target Exam

- `AWS Certified Solutions Architect - Associate (SAA-C03)`

### Output Form

- `챗봇`

### Core Features

- 사용자 질의응답
- 시험 범위별 핵심 개념 설명
- 개념 요약
- 암기카드 생성
- 짧은 퀴즈 생성

### Excluded Scope

- 여러 자격증 지원
- 개인 맞춤 학습 스케줄링
- 실시간 웹 크롤링
- 로그인 / 사용자 관리
- 실제 시험과 흡사한 장문 문제 생성
- 점수 예측
- 개인 맞춤 추천

## Corpus Design

### Authority Corpus

- AWS Certified Solutions Architect - Associate 공식 페이지
- SAA-C03 공식 시험 가이드
- SAA-C03 In-scope AWS services
- SAA-C03 Technologies and Concepts
- 핵심 AWS 서비스의 공식 사용자 가이드 / 개발자 가이드

예시:

- EC2 User Guide
- S3 User Guide
- RDS User Guide
- Lambda Developer Guide
- VPC User Guide
- CloudFront Developer Guide
- DynamoDB Developer Guide

### Corpus Principle

- 공식 AWS 문서만 수집 대상으로 삼는다.
- 시험 가이드에서 `in-scope`로 제시된 서비스 중심으로 우선 수집한다.
- 설명과 요약도 공식 문서를 기반으로 생성한다.
- 외부 교재, 블로그, 커뮤니티 글은 MVP 코퍼스에서 제외한다.

## Chunking Strategy

SAA 문서는 PDF보다 `구조화된 HTML 문서`가 많기 때문에,
이번 MVP의 기본 전략은 `문서 구조 기반 hierarchical chunking`이다.

### Baseline

- `fixed-size + overlap`
- 목적: 비교용 baseline
- 목표 길이: 약 `500~700 tokens`
- overlap: 약 `80~120 tokens`

### Recommended Strategy

- `structure-aware hierarchical chunking`
- 기본 단위:
  - 문서 1페이지 내 `H2/H3 section`
  - subsection
  - bullet list
  - table block
  - note / best practice / limitation block

### Rules

- 한 chunk는 가능하면 하나의 개념이나 하나의 비교 포인트만 담는다.
- 긴 section은 문단 경계 또는 list 경계 기준으로 다시 나눈다.
- 표는 표 전체를 보존하거나 의미 단위별로 묶는다.
- 경고, 제한사항, best practice는 본문과 분리하지 않고 함께 유지한다.
- URL, 문서 제목, 서비스명, section heading, breadcrumb를 metadata로 저장한다.

### Metadata

각 chunk에 아래 메타데이터를 붙인다.

- exam: `SAA-C03`
- service: 예) `Amazon EC2`
- guide: 예) `EC2 User Guide`
- page_title
- section_heading
- source_url
- content_type:
  - concept
  - best_practice
  - limitation
  - comparison
  - procedure
  - pricing_or_cost

### Why This Strategy

- SAA 문서는 서비스 비교와 제한사항이 중요해서 문맥 보존이 중요하다.
- fixed-size만 쓰면 표/리스트/주의사항이 잘려 설명 품질이 떨어질 수 있다.
- 구조 기반 chunking은 설명, 요약, 암기카드, 퀴즈 생성에 더 유리하다.

## Retrieval and Generation

### Retrieval Goals

- 질문과 관련된 공식 서비스 문서를 찾는다.
- 개념 설명에 필요한 section을 우선 검색한다.
- 서비스 비교 질문에는 comparison / limitation 성격 chunk를 우선 노출한다.

### Generation Goals

- 설명: 공식 문서 기반으로 핵심 개념을 풀어쓴다.
- 요약: 핵심 포인트만 짧게 정리한다.
- 암기카드: 용어-정의, 서비스-특징, 비교 포인트 중심으로 만든다.
- 퀴즈: 짧은 개념 확인형 문제를 생성한다.

## Evaluation Plan

### Evaluation Categories

- 질의응답
- 개념 설명
- 요약
- 암기카드
- 퀴즈

### Manual Evaluation Set

초기 평가셋은 소규모 수작업으로 구성한다.

- concept explanation: 10문항
- summary: 8문항
- flashcard generation: 6문항
- quiz generation: 6문항

### Evaluation Criteria

- 공식 문서 근거에 어긋나지 않는가
- 설명이 핵심을 잘 담는가
- 요약이 불필요하게 길지 않은가
- 암기카드가 실제 암기 포인트를 담는가
- 퀴즈가 개념 확인용으로 적절한가

## Acceptance Criteria

1. 사용자가 특정 SAA 개념이나 서비스를 질문하면 공식 문서 기반 설명을 생성할 수 있다.
2. 핵심 개념 요약이 가능하다.
3. 암기카드가 생성된다.
4. 짧은 퀴즈가 생성된다.
5. 답변에 공식 문서 출처를 연결할 수 있다.
6. chunking 전략을 fixed-size baseline과 비교 설명할 수 있다.

## Verification

- `source inventory table`
  - 시험 가이드와 핵심 서비스 문서 수집 범위를 검증
- `chunking comparison sheet`
  - fixed-size와 structure-aware 차이를 검증
- `manual eval sheet`
  - 설명 / 요약 / 암기카드 / 퀴즈 품질 검증
- `sample outputs`
  - 발표용 예시 답변 검증

## Risks

- 공식 문서만으로 답변이 건조해질 수 있다
  - 대응: 요약 프롬프트를 다듬고 explanatory chunk를 우선 검색
- chunk가 너무 크면 요약 품질이 떨어질 수 있다
  - 대응: section 경계 기반 분할
- chunk가 너무 작으면 서비스 맥락이 깨질 수 있다
  - 대응: heading / list / note 묶음 유지
- 퀴즈가 지나치게 문서 요약형이 될 수 있다
  - 대응: 비교 포인트와 제한사항 위주로 문제 생성

## ADR

### Decision

정처기 기반 자격증 도우미 대신,
공식 문서가 풍부한 `AWS SAA`를 대상으로 한 RAG 학습 도우미로 방향을 전환한다.

### Drivers

- 공식 문서량이 충분하다
- 시험 범위와 코퍼스 출처를 명확히 설명할 수 있다
- 설명 / 요약 / 암기카드 / 퀴즈 기능이 공식 문서와 잘 맞는다

### Alternatives Considered

- 정보처리기사 실기
- 공개 자료가 제한적인 자격증
- 실제 시험형 문제 생성 중심 제품

### Why Chosen

- SAA는 공식 문서가 훨씬 풍부하다
- 수집 기준을 방어하기 쉽다
- MVP 범위를 설명형 학습 도우미로 잡기에 적합하다

### Consequences

- 범위는 클라우드 자격증으로 좁혀진다
- 문제 생성보다는 설명/요약형 가치가 중심이 된다
- 공식 문서 구조를 활용한 chunking 전략이 중요해진다

### Follow-ups

- 핵심 서비스 우선순위 확정
- structure-aware chunk schema 구체화
- sample outputs 작성
- 발표용 1페이지 주제 소개 자료 정리
