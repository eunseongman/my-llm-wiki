---
title: "콜레이션"
type: concept
status: evergreen
created: 2026-04-14
updated: 2026-04-14
aliases: ["collation", "문자열 비교 규칙"]
---

# 콜레이션

## 한 줄 정의

- 콜레이션은 문자열을 어떤 규칙으로 비교하고 정렬할지 정하는 설정이다.

## 설명

- 문자셋이 어떤 글자를 저장할 수 있는지 정한다면, 콜레이션은 그 글자들을 어떤 기준으로 같다고 보고 어떤 순서로 정렬할지 정한다.
- 그래서 콜레이션은 단순 정렬 옵션이 아니라 `WHERE`, `ORDER BY`, `GROUP BY`, `UNIQUE INDEX` 동작에도 영향을 준다.
- 예를 들어 case-insensitive 콜레이션에서는 `"abc"`와 `"ABC"`를 같은 값으로 볼 수 있고, binary 계열 콜레이션에서는 다르게 볼 수 있다.
- 문자열 비교 결과가 달라지면 인덱스 활용 방식과 제약 조건 충돌 여부도 함께 달라질 수 있다.

## 왜 중요한가

- 문자열 관련 버그를 단순 애플리케이션 로직 문제가 아니라 DB 비교 규칙 문제로 볼 수 있게 해 준다.
- 특히 검색 조건, 정렬 결과, 유니크 키 충돌을 이해할 때 필수적인 배경이 된다.

## 예시

- case-insensitive 콜레이션에서 `"abc"`가 이미 저장돼 있으면 `"ABC"` 삽입이 유니크 충돌로 처리될 수 있다.
- 한글이나 악센트 문자의 정렬 순서도 콜레이션에 따라 달라질 수 있다.

## 관련 개념

- [대량 업서트](/C:/Users/user/working/llm-wiki/library/concepts/bulk-upsert.md)
- [인덱스 컬럼에 함수 적용](/C:/Users/user/working/llm-wiki/library/concepts/function-on-indexed-column.md)

## 관련 세션

- [2026-04-14 DB 실행계획 감각 정리](/C:/Users/user/working/llm-wiki/library/sessions/2026-04-14-database-indexing-upsert.md)
