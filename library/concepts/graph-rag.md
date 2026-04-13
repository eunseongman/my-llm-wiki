---
title: "Graph RAG"
type: concept
status: evergreen
created: 2026-04-13
updated: 2026-04-13
aliases: ["knowledge graph rag", "graph-based rag"]
---

# Graph RAG

## 한 줄 정의

- Graph RAG는 문서를 엔티티와 관계의 그래프로 바꾼 뒤, 그래프 탐색을 통해 관련 맥락을 찾는 RAG 방식이다.

## 설명

- 문서에서 entity와 relation을 추출해 graph를 만든다.
- 이 graph는 Neo4j 같은 graph DB에 저장될 수 있고, 질의는 traversal 형태로 수행된다.
- 검색 단위가 chunk 유사도만이 아니라 node-edge 구조가 되기 때문에 multi-hop reasoning에 유리하다.

## 왜 중요한가

- 관계가 중요한 도메인에서 기본 RAG보다 훨씬 더 적합할 수 있다.
- 단순히 비슷한 문장을 찾는 것이 아니라, 연결된 개념망을 탐색할 수 있다.

## 예시

- 어떤 시스템에서 Redis가 어디에 의존하고 어떤 컴포넌트와 연결되는지 같은 관계형 질문은 Graph RAG가 강하다.

## 관련 개념

- [기본 RAG의 한계](/C:/Users/user/working/llm-wiki/library/concepts/basic-rag-limitations.md)
- [RAPTOR](/C:/Users/user/working/llm-wiki/library/concepts/raptor.md)

## 관련 세션

- [2026-04-13 RAG 핵심 이론 스택 정리](/C:/Users/user/working/llm-wiki/library/sessions/2026-04-13-rag-core-stack.md)
