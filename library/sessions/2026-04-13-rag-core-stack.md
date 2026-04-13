---
title: "2026-04-13 RAG 핵심 이론 스택 정리"
type: session
status: evergreen
created: 2026-04-13
updated: 2026-04-13
source_path: "C:/Users/user/working/llm-wiki/archive/2026-04-13-rag-core-stack-summary.md"
---

# 2026-04-13 RAG 핵심 이론 스택 정리

## 오늘 다룬 주제

- 기존 RAG의 구조와 한계
- RAPTOR와 Graph RAG의 차이
- 클러스터링, UMAP, GMM, HDBSCAN의 역할
- 실무에서 어떤 RAG 구조를 선택할지에 대한 기준

## 핵심 질문

- 왜 기본 RAG는 긴 문서나 복잡한 맥락에서 약해지는가
- RAPTOR는 단순 벡터 검색과 무엇이 다른가
- Graph RAG는 어떤 문제를 더 잘 푸는가
- 실무에서는 언제 어떤 구조를 선택해야 하는가

## 핵심 배움

- 기본 RAG의 병목은 검색 자체보다 문서 구조를 어떻게 표현하느냐에 있다.
- RAPTOR는 chunk를 요약과 계층화로 재구성해 문맥 보존을 강화한다.
- Graph RAG는 엔티티와 관계를 명시적으로 구조화해 multi-hop reasoning에 유리하다.
- 클러스터링 품질은 임베딩만이 아니라 UMAP, 알고리즘 선택, bandwidth 같은 구조적 결정의 영향을 크게 받는다.

## 새로 연결된 개념

- [기본 RAG의 한계](/C:/Users/user/working/llm-wiki/library/concepts/basic-rag-limitations.md)
- [RAPTOR](/C:/Users/user/working/llm-wiki/library/concepts/raptor.md)
- [Graph RAG](/C:/Users/user/working/llm-wiki/library/concepts/graph-rag.md)
- [RAG에서의 클러스터링](/C:/Users/user/working/llm-wiki/library/concepts/clustering-in-rag.md)

## 열린 질문

- 내 프로젝트에선 Parent-Child, Multi-Vector, RAPTOR, Graph RAG 중 어디부터 시작하는 게 맞는가
- 요약 기반 구조와 관계 기반 구조를 같이 쓰는 하이브리드 설계는 어떻게 할 것인가

## 관련 문서

- [RAG 아키텍처 선택 기준](/C:/Users/user/working/llm-wiki/library/topics/rag-architecture-selection.md)
- [RAG는 검색보다 구조화 문제에 가깝다](/C:/Users/user/working/llm-wiki/library/syntheses/rag-is-a-structuring-problem.md)
- [내 프로젝트에서는 어떤 RAG 구조가 맞을까](/C:/Users/user/working/llm-wiki/library/questions/which-rag-architecture-fits-my-project.md)
