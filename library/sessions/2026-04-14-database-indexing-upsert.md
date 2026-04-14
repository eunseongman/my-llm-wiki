---
title: "2026-04-14 DB 실행계획 감각 정리"
type: session
status: evergreen
created: 2026-04-14
updated: 2026-04-14
source_path: "current conversation"
---

# 2026-04-14 DB 실행계획 감각 정리

## 오늘 다룬 주제

- JPA와 인덱스의 관계
- 루스 인덱스 스캔과 SQL 형태의 중요성
- 업서트, 배치 UPDATE, staging table + merge의 차이
- MERGE 문법을 지원하는 DB
- 문자열 콜레이션의 의미
- 인덱스 컬럼에 함수가 걸릴 때의 제약

## 핵심 질문

- JPA를 쓸 때 인덱스를 잘 타게 하려면 무엇을 제어해야 하는가
- 대규모 업서트는 왜 빠를 수 있고 언제 불리해지는가
- 배치 UPDATE와 staging table + merge는 각각 언제 쓰는가
- 콜레이션은 실제로 무엇을 바꾸는가
- 왜 `함수(컬럼)` 조건은 인덱스 사용에 불리한가

## 핵심 배움

- JPA는 인덱스를 직접 유도하는 도구가 아니라, DB가 인덱스를 잘 탈 수 있는 SQL을 생성하게 만드는 도구에 가깝다.
- 루스 인덱스 스캔 같은 최적화는 `GROUP BY` 유무만이 아니라 인덱스 순서와 SQL 형태가 함께 맞아야 한다.
- 업서트는 존재 확인과 분기 비용을 줄일 때 강력하지만, 수정 비중이 너무 높으면 배치 UPDATE나 staging 전략이 더 적합할 수 있다.
- 콜레이션은 문자열 비교와 정렬 규칙이므로 조회 조건, 정렬, 그룹화, 유니크 인덱스 동작에 직접 영향을 준다.
- 인덱스 컬럼에 SQL 함수를 적용하면 DB가 원래 인덱스 정렬을 그대로 활용하기 어려워진다.

## 새로 연결된 개념

- ORM과 실행계획은 분리해서 봐야 한다.
- 대량 데이터 반영 방식은 데이터 분포와 운영 목적에 따라 달라진다.
- 문자열 비교 규칙도 인덱스와 제약 조건에 영향을 준다.
- [대량 업서트](/C:/Users/user/working/llm-wiki/library/concepts/bulk-upsert.md)
- [콜레이션](/C:/Users/user/working/llm-wiki/library/concepts/collation.md)
- [인덱스 컬럼에 함수 적용](/C:/Users/user/working/llm-wiki/library/concepts/function-on-indexed-column.md)

## 열린 질문

- MySQL에서 `EXPLAIN`을 볼 때 어떤 지표부터 읽어야 하는가
- Querydsl과 native query를 어디서 나누는 것이 실무적으로 좋은가
- 함수 기반 인덱스나 generated column은 어떤 기준으로 도입하는가

## 관련 문서

- [DB 실행계획 감각을 잡기 위해 오늘 공부한 것](/C:/Users/user/working/llm-wiki/report/2026-04-14-database-indexing-upsert-report.md)
