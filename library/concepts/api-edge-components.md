---
title: "로드밸런서와 리버스 프록시, API Gateway, APIM"
type: concept
status: draft
created: 2026-04-16
updated: 2026-04-16
aliases:
  - "로드밸런서"
  - "리버스 프록시"
  - "API Gateway"
  - "APIM"
---

# 로드밸런서와 리버스 프록시, API Gateway, APIM

## 한 줄 정의

- 이 네 가지는 모두 API 앞단에 놓일 수 있지만, 로드밸런서는 분산, 리버스 프록시는 중계, API Gateway는 API 정책 처리, APIM은 전체 운영 관리를 더 강조한다.

## 설명

- 로드밸런서는 요청을 여러 서버에 나눠 보내 가용성과 성능을 높인다.
- 리버스 프록시는 외부 요청을 대신 받아 뒤쪽 서버로 전달하고, SSL 종료나 캐싱, 정적 파일 처리 같은 역할을 맡을 수 있다.
- API Gateway는 인증, 권한, 라우팅, 호출 제한, 로깅처럼 API 전용 정책을 처리하는 관문이다.
- APIM은 Gateway 기능을 포함해 개발자 포털, 문서, 키 발급, 분석, 정책 관리까지 묶는 더 큰 운영 플랫폼이다.
- 실무에서는 한 제품이 여러 역할을 겸할 수 있어서 개념과 제품을 분리해서 이해하는 것이 중요하다.

## 왜 중요한가

- 아키텍처 면접에서 서로 비슷해 보이는 용어를 정확히 구분하는 데 도움이 된다.
- 시스템 앞단 계층을 어떤 기준으로 나눠 보는지 설명할 수 있게 해 준다.

## 예시

- `클라이언트 -> Load Balancer -> API Gateway -> 백엔드`처럼 계층을 나눌 수 있다.
- Nginx는 리버스 프록시와 로드밸런싱 역할을 겸할 수 있고, Kong은 API Gateway 역할을 강하게 수행한다.

## 관련 개념

- [SOAP와 REST API](/C:/Users/user/working/llm-wiki/library/concepts/soap-vs-rest-api.md)
- [APIM과 API Gateway](/C:/Users/user/working/llm-wiki/library/concepts/apim-and-api-gateway.md)

## 관련 세션

- [2026-04-16 API 연동과 게이트웨이 기초 정리](/C:/Users/user/working/llm-wiki/library/sessions/2026-04-16-api-integration-and-gateway.md)
