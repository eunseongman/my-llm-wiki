---
title: "인덱스 컬럼에 함수 적용"
type: concept
status: evergreen
created: 2026-04-14
updated: 2026-04-14
aliases: ["function on indexed column", "함수 적용과 인덱스"]
---

# 인덱스 컬럼에 함수 적용

## 한 줄 정의

- 인덱스 컬럼에 SQL 함수를 적용한 조건은 원래 인덱스 순서를 그대로 활용하기 어려워서 인덱스 사용에 불리해지는 경우가 많다.

## 설명

- 인덱스는 보통 저장된 원래 컬럼 값을 기준으로 정렬되어 있다.
- 그런데 `DATE(created_at)`, `YEAR(created_at)`, `UPPER(name)`, `SUBSTRING(phone, 1, 3)`처럼 컬럼에 함수를 씌우면 DB는 원래 인덱스 값이 아니라 가공된 결과를 기준으로 비교해야 한다.
- 이 경우 DB는 인덱스를 직접 좁혀 들어가기보다 많은 row를 읽으면서 함수 결과를 계산해야 할 수 있다.
- 그래서 가능하면 컬럼 원형 비교나 범위 조건으로 바꾸는 것이 일반적으로 더 인덱스 친화적이다.

## 왜 중요한가

- "인덱스를 만들었는데 왜 안 타지?"라는 질문의 매우 흔한 원인 중 하나를 설명해 준다.
- 쿼리를 조금만 바꿔도 실행계획이 크게 달라질 수 있다는 감각을 준다.

## 예시

- `DATE(created_at) = '2026-04-14'`보다 `created_at >= '2026-04-14 00:00:00' AND created_at < '2026-04-15 00:00:00'`가 더 인덱스 친화적일 수 있다.
- `UPPER(name) = 'KIM'`처럼 비교하기보다 저장 시 정규화하거나 함수 기반 인덱스를 고려하는 방식이 더 적합할 수 있다.

## 관련 개념

- [콜레이션](/C:/Users/user/working/llm-wiki/library/concepts/collation.md)
- [대량 업서트](/C:/Users/user/working/llm-wiki/library/concepts/bulk-upsert.md)

## 관련 세션

- [2026-04-14 DB 실행계획 감각 정리](/C:/Users/user/working/llm-wiki/library/sessions/2026-04-14-database-indexing-upsert.md)
