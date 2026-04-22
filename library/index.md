# Knowledge Library Index

This file is the entry point to the library.

## Sessions

- [2026-04-13 도서관 방향 정리](/C:/Users/user/working/llm-wiki/library/sessions/2026-04-13-library-direction.md): - 이 저장소를 무엇으로 만들 것인가
- [2026-04-13 RAG 핵심 이론 스택 정리](/C:/Users/user/working/llm-wiki/library/sessions/2026-04-13-rag-core-stack.md): - 기존 RAG의 구조와 한계
- [2026-04-14 DB 실행계획 감각 정리](/C:/Users/user/working/llm-wiki/library/sessions/2026-04-14-database-indexing-upsert.md): - JPA와 인덱스, 업서트, 콜레이션, 함수 적용이 실행계획과 어떻게 연결되는지 정리했다.
- [2026-04-16 API 연동과 게이트웨이 기초 정리](/C:/Users/user/working/llm-wiki/library/sessions/2026-04-16-api-integration-and-gateway.md): - SOAP와 REST 차이, APIM과 Kong의 의미, API 앞단 계층의 역할 구분을 함께 정리했다.
- [sample session](/C:/Users/user/working/llm-wiki/library/sessions/2026-04-13-sample-session.md): -

## Concepts

- [지식 도서관과 앱의 차이](/C:/Users/user/working/llm-wiki/library/concepts/library-vs-app.md): - 앱은 기능을 제공하는 산출물이고, 지식 도서관은 읽고 연결하고 축적하는 문서 중심 산출물이다.
- [LLM 위키](/C:/Users/user/working/llm-wiki/library/concepts/llm-wiki.md): - LLM이 문서를 단순 검색하는 대신, 읽고 정리하고 갱신하며 유지하는 지속적 지식 문서 집합이다.
- [APIM과 API Gateway](/C:/Users/user/working/llm-wiki/library/concepts/apim-and-api-gateway.md): - APIM은 API 운영 관리 체계이고, API Gateway는 인증과 라우팅, 호출 제한 같은 정책을 실제 요청에 적용하는 관문이다.
- [기본 RAG의 한계](/C:/Users/user/working/llm-wiki/library/concepts/basic-rag-limitations.md): - 기본 RAG는 문서를 chunk와 벡터의 집합으로 다루기 때문에 상위 맥락과 분산된 정보를 충분히 보존하지 못한다.
- [로드밸런서와 리버스 프록시, API Gateway, APIM](/C:/Users/user/working/llm-wiki/library/concepts/api-edge-components.md): - API 앞단 계층을 분산, 중계, 정책 처리, 운영 관리의 관점에서 나눠 보는 정리다.
- [대량 업서트](/C:/Users/user/working/llm-wiki/library/concepts/bulk-upsert.md): - 신규와 기존 데이터가 섞인 대규모 반영을 유니크 키 충돌 기준으로 한 번에 처리하는 전략이다.
- [콜레이션](/C:/Users/user/working/llm-wiki/library/concepts/collation.md): - 문자열을 어떤 규칙으로 비교하고 정렬할지 정하는 설정이다.
- [RAG에서의 클러스터링](/C:/Users/user/working/llm-wiki/library/concepts/clustering-in-rag.md): - RAG에서의 클러스터링은 임베딩된 텍스트를 벡터 유사도 기준으로 묶어 상위 의미 구조를 만들기 위한 핵심 단계다.
- [인덱스 컬럼에 함수 적용](/C:/Users/user/working/llm-wiki/library/concepts/function-on-indexed-column.md): - 인덱스 컬럼에 SQL 함수를 적용하면 원래 인덱스 순서를 그대로 활용하기 어려워질 수 있다.
- [Graph RAG](/C:/Users/user/working/llm-wiki/library/concepts/graph-rag.md): - Graph RAG는 문서를 엔티티와 관계의 그래프로 바꾼 뒤, 그래프 탐색을 통해 관련 맥락을 찾는 RAG 방식이다.
- [RAPTOR](/C:/Users/user/working/llm-wiki/library/concepts/raptor.md): - RAPTOR는 문서를 계층적 트리 구조로 재구성해, 원문 chunk와 요약된 상위 의미를 함께 탐색하게 만드는 RAG 방식이다.
- [SOAP와 REST API](/C:/Users/user/working/llm-wiki/library/concepts/soap-vs-rest-api.md): - SOAP는 XML 기반의 엄격한 프로토콜이고, REST는 HTTP 자원을 중심으로 설계하는 아키텍처 스타일이다.

## Topics

- [대화 기반 개인 지식 도서관](/C:/Users/user/working/llm-wiki/library/topics/conversation-knowledge-library.md): - 사용자와 LLM의 대화에서 나온 학습 내용을 이 저장소 안의 문서로 축적하는 운영 방식이다.
- [RAG 아키텍처 선택 기준](/C:/Users/user/working/llm-wiki/library/topics/rag-architecture-selection.md): - RAG 설계는 단순한 검색기 선택이 아니라, 문서를 어떤 구조로 표현할지 결정하는 문제다.

## Syntheses

- [왜 이 저장소는 앱보다 도서관에 가깝나](/C:/Users/user/working/llm-wiki/library/syntheses/why-this-repo-is-a-library.md): - 이 저장소의 가장 중요한 결과물은 실행 가능한 기능이 아니라, 나중에 다시 읽을 수 있는 지식 문서들의 집합이다.
- [RAG는 검색보다 구조화 문제에 가깝다](/C:/Users/user/working/llm-wiki/library/syntheses/rag-is-a-structuring-problem.md): - 좋은 RAG의 성능은 단순히 검색기나 임베딩의 품질보다, 데이터를 어떤 구조로 조직하느냐에 더 크게 영향을 받는다.

## Questions

- [앞으로 쌓아갈 질문](/C:/Users/user/working/llm-wiki/library/questions/future-library-questions.md): - 질문은 아직 답이 없더라도, 다음 학습의 방향을 잡아 준다.
- [내 프로젝트에서는 어떤 RAG 구조가 맞을까](/C:/Users/user/working/llm-wiki/library/questions/which-rag-architecture-fits-my-project.md): - 이론을 이해하는 것과 실제 프로젝트에 적용하는 것은 다르기 때문이다.

## Writing

- [이 폴더를 지식 도서관으로 쓰는 법](/C:/Users/user/working/llm-wiki/writing/posts/how-to-use-this-library.md): - 우리는 종종 LLM과 깊은 대화를 나누고도, 그 내용을 나중에 다시 읽을 수 있는 형태로 남기지 못한다.
