---
title: "SOAP와 REST API"
type: concept
status: draft
created: 2026-04-16
updated: 2026-04-16
aliases:
  - "SOAP API"
  - "REST API"
---

# SOAP와 REST API

## 한 줄 정의

- SOAP는 XML 기반의 엄격한 프로토콜이고, REST는 HTTP 자원을 중심으로 설계하는 아키텍처 스타일이다.

## 설명

- SOAP는 정해진 메시지 형식과 계약을 중시하며, XML과 WSDL을 많이 사용한다.
- REST는 URI, HTTP 메서드, 상태 코드를 활용해 자원을 다루며, 보통 JSON 기반으로 많이 구현된다.
- SOAP는 표준화와 엄격성이 강하고, REST는 단순함과 웹 친화성이 강하다.

## 왜 중요한가

- 면접에서 API 기초를 확인할 때 가장 자주 비교되는 주제 중 하나다.
- 기업 시스템 연동과 웹 서비스 API 설계를 서로 다른 관점에서 이해하는 데 도움이 된다.

## 예시

- SOAP: 주문 생성 동작을 정해진 XML 메시지 규격으로 호출한다.
- REST: `/orders` 자원에 `POST` 요청을 보내 주문을 생성한다.

## 관련 개념

- [APIM과 API Gateway](/C:/Users/user/working/llm-wiki/library/concepts/apim-and-api-gateway.md)
- [로드밸런서와 리버스 프록시, API Gateway, APIM](/C:/Users/user/working/llm-wiki/library/concepts/api-edge-components.md)

## 관련 세션

- [2026-04-16 API 연동과 게이트웨이 기초 정리](/C:/Users/user/working/llm-wiki/library/sessions/2026-04-16-api-integration-and-gateway.md)
