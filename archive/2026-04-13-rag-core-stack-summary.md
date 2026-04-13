# 2026-04-13 RAG 핵심 이론 스택 정리 원문

이 문서는 사용자와 LLM의 대화에서 정리된 "AI Agent / RAG 구조 이해를 위한 핵심 개념 정리" 내용을 도서관에 반영하기 위한 raw 요약본이다.

핵심 범위:

- 기존 RAG의 한계
- RAPTOR의 계층 구조 기반 접근
- Graph RAG의 관계 기반 접근
- 클러스터링, UMAP, GMM, HDBSCAN
- 모수 vs 비모수
- bandwidth와 local/global trade-off
- 실무 설계에서의 선택 기준

핵심 결론:

- RAG의 본질은 검색 문제라기보다 구조화 문제에 가깝다.
- 성능은 모델 자체보다 데이터 구조 설계의 영향을 크게 받는다.
- RAPTOR는 의미 계층화에 강하고, Graph RAG는 관계 탐색에 강하다.
