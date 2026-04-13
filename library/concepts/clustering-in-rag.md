---
title: "RAG에서의 클러스터링"
type: concept
status: evergreen
created: 2026-04-13
updated: 2026-04-13
aliases: ["clustering in rag", "umap gmm hdbscan"]
---

# RAG에서의 클러스터링

## 한 줄 정의

- RAG에서의 클러스터링은 임베딩된 텍스트를 벡터 유사도 기준으로 묶어 상위 의미 구조를 만들기 위한 핵심 단계다.

## 설명

- RAPTOR 같은 구조에서는 chunk를 embedding한 뒤 distance를 계산하고 clustering을 수행한다.
- UMAP은 고차원 임베딩을 저차원으로 줄여 clustering이 더 안정적으로 작동하게 돕는 전처리 도구다.
- K-Means는 hard clustering, GMM은 soft clustering, HDBSCAN은 비모수 기반 clustering으로 볼 수 있다.
- bandwidth는 데이터를 얼마나 넓게 묶을지 결정하는 감각과 연결되며 local/global trade-off를 만든다.

## 왜 중요한가

- 실제 구조화 품질은 단순히 임베딩 모델만이 아니라 clustering 설계에 크게 좌우된다.
- 어떤 알고리즘을 선택하느냐에 따라 cluster 개수, 노이즈 허용, 중첩 표현이 달라진다.

## 예시

- HDBSCAN은 cluster 수를 미리 고정하지 않고 노이즈를 허용하기 때문에 복잡한 문서 집합에서 유연할 수 있다.

## 관련 개념

- [RAPTOR](/C:/Users/user/working/llm-wiki/library/concepts/raptor.md)
- [기본 RAG의 한계](/C:/Users/user/working/llm-wiki/library/concepts/basic-rag-limitations.md)

## 관련 세션

- [2026-04-13 RAG 핵심 이론 스택 정리](/C:/Users/user/working/llm-wiki/library/sessions/2026-04-13-rag-core-stack.md)
