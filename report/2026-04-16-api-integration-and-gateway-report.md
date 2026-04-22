---
title: "API 연동과 게이트웨이 기초 정리"
type: report
status: draft
created: 2026-04-16
updated: 2026-04-16
source_sessions:
  - "2026-04-16-api-integration-and-gateway"
---

# API 연동과 게이트웨이 기초 정리

## 오늘 무엇을 공부했나

오늘은 채용 JD를 이해하려다가 API 연동 쪽에서 자주 나오는 용어들을 한꺼번에 정리하게 됐다. 처음 출발점은 SOAP가 무엇인지, REST API와 어떻게 다른지였다. 여기서 끝나지 않고 APIM과 Kong이 왜 필요한지, 백엔드가 원래 하던 일을 왜 따로 앞단 계층으로 빼는지까지 연결해서 봤다. 마지막에는 로드밸런서, 리버스 프록시, API Gateway, APIM이 각각 무엇을 담당하는지 비교하면서, 실제 실무에서는 한 제품이 여러 역할을 겸하기도 한다는 점까지 정리했다.

이번에 특히 중요했던 포인트는 "이 기술들이 서로 완전히 다른 세계의 도구가 아니라, API를 외부에 안정적으로 노출하고 운영하기 위한 서로 다른 계층과 역할"이라는 감각이었다. 백엔드가 실제 비즈니스 로직을 수행한다면, 그 앞단에는 요청을 분산하고, 전달하고, 인증하고, 정책을 적용하고, 사용량을 관리하는 운영 계층이 붙을 수 있다. 이 흐름을 이해하니 JD에 있던 APIM, Kong, Layer7 같은 단어도 훨씬 덜 낯설어졌다.

## 한 번에 이해할 흐름

웹이나 앱에서 어떤 요청이 들어오면, 그 요청이 무조건 곧바로 백엔드 비즈니스 로직으로 들어가는 것은 아니다. 규모가 커질수록 앞단에 여러 역할이 붙는다. 먼저 로드밸런서가 여러 서버로 트래픽을 나누고, 리버스 프록시가 외부 요청을 대신 받아 뒤쪽 서버로 넘겨줄 수 있다. 그 다음 API Gateway가 인증, 권한, 호출량 제한, 라우팅 같은 API 전용 정책을 적용한다. APIM은 여기서 한 걸음 더 나아가, 개발자 포털, 문서, 키 발급, 사용량 분석, 정책 관리까지 포함하는 더 큰 운영 체계가 된다.

이 흐름에서 SOAP와 REST는 API를 어떤 스타일과 규약으로 주고받을 것인지에 대한 이야기다. SOAP는 XML 기반의 엄격한 프로토콜이고, REST는 HTTP 자원을 중심으로 설계하는 더 가볍고 유연한 스타일이다. 반면 APIM이나 Kong은 이렇게 만들어진 API를 외부에 어떻게 열고, 어떻게 통제하고, 어떻게 운영할지에 더 가까운 개념이다. 즉 SOAP와 REST가 "API의 말투"에 가깝다면, APIM과 Gateway는 "그 API를 어떤 입구를 통해, 어떤 규칙으로 드나들게 할 것인가"에 가깝다.

## 핵심 개념 정리

SOAP는 Simple Object Access Protocol의 약자이고, 보통 XML과 WSDL을 바탕으로 엄격한 계약 기반 API를 구성할 때 등장한다. 보안, 신뢰성, 트랜잭션 같은 표준이 강한 대신 무겁고 복잡한 편이다. REST는 HTTP 메서드와 자원 중심 URI를 활용하는 설계 방식이며, 보통 JSON을 많이 써서 더 직관적이고 가볍다. 면접에서는 "SOAP는 프로토콜, REST는 아키텍처 스타일"이라는 차이를 먼저 말하면 뼈대가 잘 잡힌다.

APIM은 API Management의 약자다. 백엔드가 실제 기능을 수행하는 동안, APIM은 API를 외부에 안전하고 일관되게 공개하기 위한 관리 체계를 맡는다. 누가 API를 쓸 수 있는지, 어떤 인증 방식을 적용할지, 너무 많이 호출하면 어떻게 제한할지, 사용량과 에러율은 어떻게 볼지 같은 질문을 다룬다. Kong은 이 영역에서 많이 쓰는 대표적인 API Gateway 솔루션이다. 쉽게 말하면 백엔드 앞문에 서서 인증, 라우팅, 제한, 로깅을 처리하는 API 관문이다.

로드밸런서, 리버스 프록시, API Gateway, APIM은 구분해서 이해하되, 실무에서는 제품 단위로 겹칠 수 있다. 로드밸런서는 트래픽 분산이 핵심이고, 리버스 프록시는 요청을 대신 받아 뒤쪽 서버로 중계하는 역할이 중심이다. API Gateway는 여기에 API 전용 정책을 강하게 얹은 관문이고, APIM은 Gateway를 포함해 문서, 포털, 분석, 수명주기 관리까지 다루는 더 큰 운영 플랫폼이다. 개념은 분리되지만 제품은 겹친다는 점이 실무 감각으로 중요하다.

## 내가 다시 볼 포인트

- SOAP와 REST를 비교할 때는 "무겁다/가볍다"보다 먼저 `프로토콜 vs 아키텍처 스타일` 차이를 말하기
- APIM은 백엔드의 대체물이 아니라 `API 운영 관리 계층`이라는 점 기억하기
- Kong은 개념이 아니라 `API Gateway 솔루션 이름`이라는 점 구분하기
- 로드밸런서, 리버스 프록시, API Gateway, APIM은 역할이 다르지만 제품 수준에서는 겹칠 수 있다는 점 기억하기
- 실무 구조는 `클라이언트 -> LB/프록시 -> Gateway/APIM -> 백엔드` 순서로 많이 이해하면 편하다

## 관련 library 문서

- [SOAP와 REST API](/C:/Users/user/working/llm-wiki/library/concepts/soap-vs-rest-api.md)
- [APIM과 API Gateway](/C:/Users/user/working/llm-wiki/library/concepts/apim-and-api-gateway.md)
- [로드밸런서와 리버스 프록시, API Gateway, APIM](/C:/Users/user/working/llm-wiki/library/concepts/api-edge-components.md)
- [2026-04-16 API 연동과 게이트웨이 기초 정리](/C:/Users/user/working/llm-wiki/library/sessions/2026-04-16-api-integration-and-gateway.md)
