---
title: "Deep Interview Spec - Pokemon Showdown battle decision assistant"
type: spec
status: draft
created: 2026-04-17T15:40:32Z
updated: 2026-04-17T15:40:32Z
---

# Metadata

- Profile: standard
- Context type: greenfield
- Final ambiguity: 0.19
- Threshold: 0.20
- Context snapshot: `.omx/context/pokemon-showdown-battle-decision-assistant-20260417T154032Z.md`
- Interview transcript: `.omx/interviews/pokemon-showdown-battle-decision-assistant-20260417T154032Z.md`

# Clarity breakdown

| Dimension | Score |
| --- | ---: |
| Intent clarity | 0.95 |
| Outcome clarity | 0.90 |
| Scope clarity | 0.78 |
| Constraint clarity | 0.74 |
| Success criteria clarity | 0.86 |

# Intent

Pokemon Showdown에서 실제 승률 기여가 가능한 배틀 AI를 만들고 싶다.  
겉으로는 설명 가능한 추천을 제공하지만, 본질은 `선출 추천 + 턴별 행동 추천`을 수행하는 의사결정 엔진이다.

# Desired outcome

- 특정 시즌 / 특정 포맷에서 동작하는 Pokemon Showdown 배틀 AI MVP
- Showdown 로그를 파싱해 현재 상태를 추적
- 시즌 메타 통계를 사용해 비공개 정보에 확률을 부여
- 추천 행동과 간단한 근거를 함께 제시
- 실제 래더에서 규칙 기반 베이스라인보다 나은 성능을 보이는지 검증

# In scope

- 특정 시즌의 특정 포맷 하나에 한정된 MVP
- 배틀 시작 전 선출 추천
- 배틀 중 턴별 행동 추천
- Showdown 로그 파싱 기반 상태 추적
- 공개 정보 + 메타 기반 확률 추정
- 추천 + 근거 출력
- 실제 래더 기반 평가

# Out of scope / non-goals

- 특정 시즌의 특정 포맷 외 지원
- 팀 빌딩 추천
- 복기 / 리플레이 해설 기능
- 자동 플레이 / 자동 입력
- 비공개 정보를 사실처럼 단정하는 강한 추정

# Decision boundaries

- 비공개 정보는 시즌 메타 기반의 확률 추정으로만 다룬다.
- 확률이 낮거나 불확실성이 크면 보수적인 추천을 우선한다.
- 동률일 때는 안전한 선택을 우선한다.

# Constraints

- 프로젝트는 RAG 자체가 아니라 배틀 AI / 의사결정 엔진 프로젝트다.
- 메타 정보는 핵심이 아니라 추천 재료다.
- MVP는 실제 래더를 평가 환경으로 삼는다.
- 규칙 기반 베이스라인보다 낮은 성능이면 실패로 본다.
- 사용자는 입문자를 주요 상정 사용자로 둔다.

# Testable acceptance criteria

1. Showdown 로그를 받아 현재 배틀 상태를 구조화할 수 있다.
2. 현재 상태와 시즌 메타 정보를 바탕으로 선출 또는 턴 행동을 추천할 수 있다.
3. 추천마다 간단한 근거를 자연어로 제시할 수 있다.
4. 추천 엔진은 비공개 정보에 대해 확률 기반 가정을 사용한다.
5. 실제 래더 평가에서 규칙 기반 베이스라인보다 높은 성능을 보인다.

# Assumptions exposed and resolutions

- 초기 가정: 이 프로젝트는 설명 가능한 코칭 시스템이다.
  - Resolution: 실제 평가는 승률 중심이므로 배틀 AI가 맞다.

- 초기 가정: RAG가 핵심일 수 있다.
  - Resolution: RAG는 메타 정보 공급원일 뿐이고, 핵심은 의사결정 엔진이다.

- 초기 가정: 입력 UX는 나중에 정리하면 된다.
  - Resolution: MVP는 Showdown 로그 파싱으로 고정한다.

# Pressure-pass findings

- 코칭/학습이라는 표면 설명은 실제 프로젝트 난도를 숨기고 있었다.
- 입문자 대상이라 하더라도, 실제 구현 난제는 불완전 정보 하의 행동 결정이다.
- 범위를 계속 넓히는 경향이 있어 비범위를 문서로 강하게 잠가야 한다.

# Evidence vs inference notes

- Evidence:
  - 사용자는 선출 추천과 턴별 추천을 둘 다 반드시 원한다고 명시했다.
  - 입력은 Showdown 로그 파싱, 평가는 실제 래더, 성공 기준은 규칙 기반 베이스라인 초과로 명시했다.
  - 정보 경계는 메타 기반 확률 추정으로 명시했다.
- Inference:
  - 사용자 표현은 코칭 시스템에서 시작했지만, 실질적 제품 정체성은 배틀 AI다.
  - 메타 정보는 설명용이 아니라 추천의 재료이므로 엔진 품질이 프로젝트 성패를 좌우한다.

# Recommended next handoff

- Recommended: `$ralplan`
- Reason:
  - 요구사항은 상당히 정리됐지만, MVP 아키텍처와 평가 설계는 아직 합의가 더 필요하다.
  - 특히 `포맷 구체화`, `규칙 기반 베이스라인 정의`, `LLM/규칙/통계 역할 분해`, `실제 래더 운영 리스크`를 설계해야 한다.
