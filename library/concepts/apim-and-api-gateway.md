---
title: "APIM과 API Gateway"
type: concept
status: draft
created: 2026-04-16
updated: 2026-04-16
aliases:
  - "API Management"
  - "Kong"
  - "API Gateway"
---

# APIM과 API Gateway

## 한 줄 정의

- APIM은 API를 외부에 안전하고 일관되게 공개하기 위한 운영 관리 체계이고, API Gateway는 그 앞단에서 실제 요청 정책을 적용하는 관문이다.

## 설명

- APIM은 인증, 권한, 정책 관리, 개발자 포털, 문서, 사용량 분석, 수명주기 관리를 포함하는 더 큰 개념이다.
- API Gateway는 라우팅, 인증 확인, 호출량 제한, 로깅 같은 API 요청 처리 정책을 담당한다.
- Kong, Layer7 같은 솔루션은 이 영역에서 많이 언급되는 대표 제품이다.
- 백엔드가 비즈니스 로직을 수행한다면, APIM과 Gateway는 공통 운영 정책을 앞단에서 처리한다.

## 왜 중요한가

- 고객사 연동, Open API 운영, 보안, 모니터링이 중요한 JD에서 반복해서 등장하는 핵심 용어다.
- 백엔드 개발과 운영/보안 계층의 역할 분리를 이해하는 데 도움이 된다.

## 예시

- 클라이언트 요청이 먼저 Kong으로 들어오고, Kong이 토큰과 호출량을 확인한 뒤 적절한 백엔드 API로 전달한다.
- 외부 파트너를 위한 API 문서와 키 발급, 사용량 대시보드까지 포함하면 APIM 관점으로 확장된다.

## 관련 개념

- [SOAP와 REST API](/C:/Users/user/working/llm-wiki/library/concepts/soap-vs-rest-api.md)
- [로드밸런서와 리버스 프록시, API Gateway, APIM](/C:/Users/user/working/llm-wiki/library/concepts/api-edge-components.md)

## 관련 세션

- [2026-04-16 API 연동과 게이트웨이 기초 정리](/C:/Users/user/working/llm-wiki/library/sessions/2026-04-16-api-integration-and-gateway.md)
