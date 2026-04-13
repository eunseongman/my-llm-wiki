---
title: "기본 RAG의 한계"
type: concept
status: evergreen
created: 2026-04-13
updated: 2026-04-13
aliases: ["classic rag limitations", "naive rag limits"]
---

# 기본 RAG의 한계

## 한 줄 정의

- 기본 RAG는 문서를 chunk와 벡터의 집합으로 다루기 때문에 상위 맥락과 분산된 정보를 충분히 보존하지 못한다.

## 설명

- 기본 RAG는 문서를 chunking한 뒤 embedding하고, vector DB에서 유사한 chunk를 가져와 LLM에 전달한다.
- 이 구조는 구현이 단순하고 빠르지만 긴 문서나 복합 개념에서는 문맥 단절이 자주 발생한다.
- 서로 멀리 떨어진 chunk에 중요한 정보가 흩어져 있으면, 검색 단계에서 그 연결이 드러나지 않을 수 있다.

## 왜 중요한가

- RAG 성능 문제를 단순히 더 좋은 임베딩 모델의 문제로 오해하지 않게 해 준다.
- 더 상위 구조가 필요한 이유를 설명해 준다.

## 예시

- 한 개념의 정의는 앞 chunk에 있고, 예외 조건은 뒤 chunk에 있는데 둘이 함께 검색되지 않으면 답변이 부정확해질 수 있다.

## 관련 개념

- [RAPTOR](/C:/Users/user/working/llm-wiki/library/concepts/raptor.md)
- [Graph RAG](/C:/Users/user/working/llm-wiki/library/concepts/graph-rag.md)

## 관련 세션

- [2026-04-13 RAG 핵심 이론 스택 정리](/C:/Users/user/working/llm-wiki/library/sessions/2026-04-13-rag-core-stack.md)
