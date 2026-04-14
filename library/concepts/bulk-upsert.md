---
title: "대량 업서트"
type: concept
status: evergreen
created: 2026-04-14
updated: 2026-04-14
aliases: ["bulk upsert", "upsert at scale"]
---

# 대량 업서트

## 한 줄 정의

- 대량 업서트는 신규와 기존 데이터가 섞인 대규모 입력을 한 번에 반영하면서, 유니크 키 충돌 시 INSERT 대신 UPDATE로 처리하는 방식이다.

## 설명

- 업서트는 애플리케이션이 먼저 존재 여부를 조회한 뒤 INSERT와 UPDATE를 나누는 대신, DB가 유니크 인덱스를 기준으로 충돌 여부를 판단하게 만든다.
- 이 방식은 네트워크 왕복 수, SQL 파싱 비용, 인덱스 탐색 반복 비용을 줄일 수 있어서 대량 반영에 유리하다.
- 다만 모든 상황에서 최적은 아니다. 충돌 비율이 매우 높거나 사실상 대부분이 기존 row 수정이라면 배치 UPDATE가 더 단순하고 효율적일 수 있다.
- 데이터 검증, 중복 제거, 재처리 안정성까지 중요해지면 staging table + merge 전략이 더 적합해질 수 있다.

## 왜 중요한가

- 대량 데이터 반영 성능을 단순히 "쿼리 한 줄이 짧으냐"가 아니라 처리 전략 관점에서 보게 해 준다.
- 업서트가 만능이 아니라 데이터 분포와 운영 목적에 따라 선택해야 하는 전략임을 보여 준다.

## 예시

- `INSERT ... ON DUPLICATE KEY UPDATE`는 MySQL 계열에서 대표적인 업서트 방식이다.
- 신규와 기존 주문 상태를 함께 반영하는 배치에서는 업서트가 편리하지만, 이미 존재하는 주문 상태만 대량 수정한다면 배치 UPDATE가 더 잘 맞을 수 있다.

## 관련 개념

- [콜레이션](/C:/Users/user/working/llm-wiki/library/concepts/collation.md)
- [인덱스 컬럼에 함수 적용](/C:/Users/user/working/llm-wiki/library/concepts/function-on-indexed-column.md)

## 관련 세션

- [2026-04-14 DB 실행계획 감각 정리](/C:/Users/user/working/llm-wiki/library/sessions/2026-04-14-database-indexing-upsert.md)
