---
title: "RAPTOR"
type: concept
status: evergreen
created: 2026-04-13
updated: 2026-04-13
aliases: ["recursive abstractive processing for tree organized retrieval"]
---

# RAPTOR

## 한 줄 정의

- RAPTOR는 문서를 계층적 트리 구조로 재구성해, 원문 chunk와 요약된 상위 의미를 함께 탐색하게 만드는 RAG 방식이다.

## 설명

- RAPTOR는 chunk를 embedding한 뒤 의미적으로 비슷한 chunk를 clustering한다.
- 각 cluster를 LLM으로 요약해 상위 노드를 만들고, 이 과정을 재귀적으로 반복해 tree를 만든다.
- leaf node는 원문 chunk이고, internal node는 요약된 의미이며, root는 전체 문서 수준의 요약이 된다.

## 왜 중요한가

- 단순 chunk retrieval보다 상위 문맥을 유지하기 쉽다.
- 긴 문서나 구조가 복잡한 문서에서 전체적인 의미를 잡는 데 유리하다.
- 단순 검색을 넘어 추상화된 지식 구조를 만든다는 점이 핵심이다.

## 예시

- 긴 기술 문서를 chunk별로 찾는 대신, 먼저 상위 요약 노드에서 적절한 문맥을 찾고 아래 leaf로 내려가는 식으로 탐색할 수 있다.

## 관련 개념

- [기본 RAG의 한계](/C:/Users/user/working/llm-wiki/library/concepts/basic-rag-limitations.md)
- [RAG에서의 클러스터링](/C:/Users/user/working/llm-wiki/library/concepts/clustering-in-rag.md)
- [Graph RAG](/C:/Users/user/working/llm-wiki/library/concepts/graph-rag.md)

## 관련 세션

- [2026-04-13 RAG 핵심 이론 스택 정리](/C:/Users/user/working/llm-wiki/library/sessions/2026-04-13-rag-core-stack.md)
