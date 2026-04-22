## Metadata

- profile: `standard`
- rounds: `5`
- final_ambiguity: `0.09`
- threshold: `0.20`
- context_type: `greenfield`
- context_snapshot: `.omx/context/rag-project-topic-pivot-20260417T003300Z.md`
- transcript: `.omx/interviews/rag-project-topic-pivot-20260417T004100Z.md`
- updated_direction: `AWS Certified Solutions Architect - Associate (SAA-C03)`
- updated_at: `2026-04-17`

## Intent

기존의 "AI가 신기술에 대해 인사이트를 주는 프로젝트"는 데이터 축적과 품질 측면에서
리스크가 컸다. 이후 단일 시험 심화형 자격증 학습 도우미 방향으로 좁혔고,
최종적으로는 공개 공식 문서가 풍부하고 문서 출처를 명확히 설명할 수 있는
`AWS Certified Solutions Architect - Associate (SAA-C03)`를 대상으로 삼는다.

## Desired Outcome

공식 AWS 문서를 기반으로, 수험생이 짧은 시간 안에 핵심 개념을 빠르게 학습할 수 있도록
다음 기능을 제공하는 RAG 학습 도우미 MVP를 정의한다.

- 사용자 질의응답
- 개념 설명과 요약
- 핵심 포인트 정리
- 암기카드 생성
- 짧은 퀴즈 생성

## Product Framing

`자격증 취득 도우미`

부제:

`SAA 취득을 위한 RAG 학습 도우미`

## Problem Definition

AWS SAA는 시험 범위가 넓고, 공식 문서 양이 많아 수험생이 짧은 시간 안에
핵심 개념과 서비스별 차이를 빠르게 파악하기 어렵다.
특히 벼락치기 상황에서는 "무엇이 중요한가", "이 서비스가 왜 중요한가",
"이 개념을 어떻게 짧게 정리해야 하는가"를 빠르게 얻는 것이 중요하다.

본 프로젝트는 AWS 공식 문서를 기반으로 개념 설명, 요약, 암기카드, 퀴즈를 제공하는
RAG 기반 학습 도우미를 만들어 학습 시간을 줄이고 이해를 돕는 것을 목표로 한다.

## Why SAA

- 공식 문서가 매우 풍부하다.
- 시험 가이드, in-scope 서비스, 서비스별 사용자 가이드가 모두 공식적으로 제공된다.
- 문서 수집 출처를 설명하기 쉽다.
- 서비스 종류가 다양해 수집, 청킹, 임베딩, 검색, 리랭킹, 평가를 단계적으로 시연하기 좋다.
- EC2, S3, RDS, VPC, Lambda 같은 핵심 AWS 서비스가 포함되어 있어 실무 연관성이 높다.
- 출처 기반 설명과 개념 브리핑 기능에 적합하다.

## In Scope

- 대상 시험을 `AWS Certified Solutions Architect - Associate (SAA-C03)`로 고정
- 공식 AWS 시험 가이드와 공식 서비스 문서를 코퍼스로 사용
- 챗봇 형태의 인터페이스
- 사용자 질의에 대한 답변 제공
- 시험 범위별 핵심 개념 설명 및 요약
- 암기카드 생성
- 짧은 퀴즈 생성

## Out of Scope / Non-goals

- 여러 자격증 지원
- 개인 맞춤 학습 스케줄링
- 실시간 웹 크롤링
- 로그인 / 사용자 관리
- 실제 시험과 유사한 장문 문제 생성
- 점수 예측
- 개인 맞춤 추천

## Decision Boundaries

다음 항목은 현재 기준으로 고정한다.

- 대상 시험은 `SAA-C03`
- 코퍼스는 `AWS 공식 시험 가이드 + 공식 서비스 문서`
- 출력 형태는 `챗봇`
- 핵심 기능은 `설명 / 요약 / 암기카드 / 퀴즈`

다음 항목은 계획 단계에서 구체화한다.

- 수집할 핵심 서비스 범위
- 청킹 전략의 세부 규칙
- 암기카드와 퀴즈 생성 방식
- 평가셋 구성 방식

## Corpus Sources

### 시험 기준 문서

- AWS Certified Solutions Architect - Associate 공식 페이지
- SAA-C03 공식 시험 가이드
- SAA-C03 In-scope AWS services
- SAA-C03 Technologies and Concepts

### 공식 서비스 문서 코퍼스

- AWS Docs sitemap index
- 예시 핵심 서비스 문서:
  - EC2 User Guide
  - S3 User Guide
  - RDS User Guide
  - Lambda Developer Guide
  - VPC User Guide
  - CloudFront Developer Guide
  - DynamoDB Developer Guide

## Acceptance Criteria

- 특정 서비스나 개념을 질문하면 공식 문서 근거를 바탕으로 설명을 제공할 수 있다.
- 시험 범위 내 핵심 개념을 요약해 줄 수 있다.
- 특정 개념에 대한 암기카드를 생성할 수 있다.
- 특정 개념이나 범위에 대한 짧은 퀴즈를 생성할 수 있다.
- 왜 이 문서를 수집했는지 시험 범위 기준으로 설명할 수 있다.

## Execution Bridge

### Recommended

- `.omx/plans/prd-rag-project-topic-mvp-design.md`
- `.omx/plans/test-spec-rag-project-topic-mvp-design.md`

이 문서들을 기준으로 SAA용 상세 설계와 평가 계획을 진행한다.
