---
title: "2026-04-16 API 연동과 게이트웨이 기초 정리"
type: session
status: draft
created: 2026-04-16
updated: 2026-04-16
source_path: "chat"
---

# 2026-04-16 API 연동과 게이트웨이 기초 정리

## 오늘 다룬 주제

- SOAP API와 REST API의 차이
- APIM과 Kong의 의미
- APIM이 왜 필요한지와 백엔드와의 역할 분리
- 로드밸런서, 리버스 프록시, API Gateway, APIM의 차이

## 핵심 질문

- SOAP는 REST와 무엇이 다른가
- APIM과 Kong은 각각 무엇을 뜻하는가
- 백엔드가 있는데 왜 API 관리 계층이 따로 필요한가
- 로드밸런서, 리버스 프록시, API Gateway, APIM은 어떻게 구분해야 하는가

## 핵심 배움

- SOAP는 XML 기반의 엄격한 프로토콜이고, REST는 HTTP 자원을 중심으로 설계하는 아키텍처 스타일이다.
- APIM은 API의 인증, 정책, 사용량, 문서, 외부 공개를 관리하는 운영 체계이고, Kong은 그중 API Gateway 역할을 수행하는 대표 솔루션이다.
- 백엔드가 비즈니스 로직을 담당한다면, APIM이나 Gateway는 인증, 호출 제한, 라우팅, 로깅 같은 횡단 관심사를 앞단에서 공통 처리한다.
- 로드밸런서는 분산, 리버스 프록시는 중계, API Gateway는 API 정책 처리, APIM은 그보다 더 넓은 관리 플랫폼으로 이해하면 된다.
- 개념은 분리되지만 제품은 겹칠 수 있어서, 실무에서는 한 제품이 여러 역할을 함께 맡기도 한다.

## 새로 연결된 개념

- [SOAP와 REST API](/C:/Users/user/working/llm-wiki/library/concepts/soap-vs-rest-api.md)
- [APIM과 API Gateway](/C:/Users/user/working/llm-wiki/library/concepts/apim-and-api-gateway.md)
- [로드밸런서와 리버스 프록시, API Gateway, APIM](/C:/Users/user/working/llm-wiki/library/concepts/api-edge-components.md)

## 열린 질문

- 실제 서비스 규모가 커질 때 로드밸런서와 API Gateway를 어디까지 분리해서 두는 것이 좋은가
- Kong과 Layer7 같은 솔루션은 어떤 요구사항에서 선택이 갈리는가

## 관련 문서

- [API 연동과 게이트웨이 기초 정리 리포트](/C:/Users/user/working/llm-wiki/report/2026-04-16-api-integration-and-gateway-report.md)
- [SOAP와 REST API](/C:/Users/user/working/llm-wiki/library/concepts/soap-vs-rest-api.md)
- [APIM과 API Gateway](/C:/Users/user/working/llm-wiki/library/concepts/apim-and-api-gateway.md)
- [로드밸런서와 리버스 프록시, API Gateway, APIM](/C:/Users/user/working/llm-wiki/library/concepts/api-edge-components.md)
