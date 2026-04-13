---
title: "RAG 구조를 이해하기 위해 오늘 공부한 것"
type: report
status: draft
created: 2026-04-13
updated: 2026-04-13
source_sessions:
  - "library/sessions/2026-04-13-rag-core-stack.md"
---

# RAG 구조를 이해하기 위해 오늘 공부한 것

## 오늘 무엇을 공부했나

오늘 정리한 내용의 중심은 단순히 "RAG가 뭔가"가 아니었다. 오히려 기본 RAG가 왜 한계에 부딪히는지, 그 한계를 넘기 위해 RAPTOR나 Graph RAG 같은 구조가 왜 등장하는지, 그리고 그 밑바닥에서 클러스터링과 차원축소 같은 기술이 어떤 역할을 하는지를 한 흐름으로 이해하는 쪽에 가까웠다.

처음 출발점은 익숙한 기본 RAG 구조였다. 문서를 chunk로 나누고, embedding해서, vector DB에서 유사한 chunk를 찾고, 그것을 LLM에 넣어 답을 생성하는 방식이다. 이 구조는 단순하고 강력하지만, 긴 문서나 복잡한 지식 구조를 다룰 때는 분명한 약점이 있다. 문서를 너무 잘게 쪼개면 상위 맥락이 끊기고, 중요한 정보가 여러 chunk에 분산되며, 벡터 유사도는 "비슷한 문장"은 잘 찾아도 "관련된 개념"이나 "멀리 떨어진 연결"까지 잡아내지는 못한다.

이 지점에서 오늘 가장 중요한 관점 전환이 나왔다. RAG의 문제는 단순히 retrieval 모델의 품질이 아니라, 문서를 어떤 구조로 표현하느냐의 문제라는 점이다. 즉, 검색 문제라기보다 구조화 문제에 가깝다.

## 한 번에 이해할 흐름

이 흐름을 이해하려면 세 단계를 따라가면 된다.

첫째, 기본 RAG는 문서를 벡터들의 집합으로 취급한다. 그래서 빠르고 단순하지만, 긴 문서의 전체 맥락이나 분산된 정보의 결합에는 약하다.

둘째, RAPTOR는 이 문제를 "계층 구조"로 풀려고 한다. chunk를 바로 검색 대상으로만 두지 않고, 비슷한 chunk들을 clustering한 뒤 각 그룹을 요약해서 상위 노드를 만들고, 그 과정을 재귀적으로 반복한다. 이렇게 되면 leaf에는 원문 chunk가 남고, 내부 노드에는 점점 추상화된 의미가 쌓이면서 하나의 tree 구조가 형성된다. 이 방식의 핵심은 단순 검색이 아니라 요약을 통해 새로운 상위 구조를 만든다는 데 있다.

셋째, Graph RAG는 전혀 다른 방향으로 나아간다. 문서를 chunk들의 묶음이 아니라 entity와 relation의 그래프로 바꿔서, 관계를 따라가며 맥락을 찾는다. 따라서 RAPTOR가 "의미를 계층화"하는 방식이라면, Graph RAG는 "관계를 구조화"하는 방식이라고 볼 수 있다.

이 두 방향 모두 결국은 같은 결론으로 이어진다. 좋은 RAG를 만들려면 검색 이전에 데이터를 어떤 구조로 만들지부터 생각해야 한다.

## 핵심 개념 정리

오늘 함께 묶인 핵심 개념은 네 덩어리였다.

첫 번째는 기본 RAG의 한계다. 문맥 단절, 정보 분산, 관계 탐색 부족이 대표적이다.

두 번째는 RAPTOR와 Graph RAG의 대비다. RAPTOR는 요약과 계층화를 통해 문맥을 압축하고, Graph RAG는 엔티티와 관계를 명시해서 multi-hop reasoning에 강해진다. 둘은 경쟁 관계라기보다, 서로 다른 문제를 잘 푸는 구조라고 보는 편이 더 정확하다.

세 번째는 클러스터링이다. 특히 RAPTOR를 이해하려면 clustering이 사실상 엔진이라는 점을 이해해야 한다. 여기서 중요한 오해 하나는 클러스터링이 "문맥을 이해해서" 묶는다는 생각이다. 실제로는 embedding된 벡터 간 거리와 분포를 바탕으로 그룹을 만든다. 그래서 차원축소와 알고리즘 선택이 매우 중요해진다.

네 번째는 UMAP, GMM, HDBSCAN 같은 도구들의 역할이다. UMAP은 고차원 임베딩을 clustering이 더 안정적으로 작동하는 공간으로 옮겨 주는 전처리 단계에 가깝다. GMM은 soft clustering이라서 하나의 데이터가 여러 cluster에 어느 정도 속할 수 있게 보고, HDBSCAN은 cluster 수를 미리 고정하지 않고 노이즈까지 다룰 수 있다. 이런 선택은 단순 구현 디테일이 아니라, 최종적으로 어떤 지식 구조가 만들어지는지에 직접 영향을 준다.

## 내가 다시 볼 포인트

다시 읽을 때 가장 먼저 붙잡아야 할 문장은 이것이다. "좋은 RAG는 좋은 embedding이 아니라 좋은 데이터 구조에서 나온다." 오늘 정리한 거의 모든 내용은 이 문장으로 다시 수렴한다.

실무 관점에서도 이 기준이 유용하다. 문서가 길고 전체 맥락이 중요하면 RAPTOR 같은 계층형 접근이 잘 맞을 가능성이 크다. 관계와 연결 탐색이 중요하면 Graph RAG가 더 적합할 수 있다. 반대로 문제 규모가 작다면 처음부터 고급 구조로 갈 필요 없이 Parent-Child나 Multi-Vector 같은 중간 단계 선택이 더 현실적일 수 있다.

다음에 이어서 생각해 볼 질문도 분명하다. 내 프로젝트의 데이터는 긴 문서 중심인가, 관계 중심인가? 내가 필요한 것은 압축된 상위 문맥인가, 아니면 엔티티 간 연결 탐색인가? 이 질문에 답해야 어떤 RAG 구조를 택할지 결정할 수 있다.

## 관련 library 문서

- [2026-04-13 RAG 핵심 이론 스택 정리](/C:/Users/user/working/llm-wiki/library/sessions/2026-04-13-rag-core-stack.md)
- [기본 RAG의 한계](/C:/Users/user/working/llm-wiki/library/concepts/basic-rag-limitations.md)
- [RAPTOR](/C:/Users/user/working/llm-wiki/library/concepts/raptor.md)
- [Graph RAG](/C:/Users/user/working/llm-wiki/library/concepts/graph-rag.md)
- [RAG에서의 클러스터링](/C:/Users/user/working/llm-wiki/library/concepts/clustering-in-rag.md)
- [RAG는 검색보다 구조화 문제에 가깝다](/C:/Users/user/working/llm-wiki/library/syntheses/rag-is-a-structuring-problem.md)
