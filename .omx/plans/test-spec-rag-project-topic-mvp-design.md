## Test Spec

- title: AWS SAA RAG 학습 도우미 MVP 테스트 스펙
- status: approved
- created: 2026-04-17
- updated: 2026-04-17
- related_prd: `.omx/plans/prd-rag-project-topic-mvp-design.md`

## Test Goals

- 공식 AWS 문서만으로 학습 보조 기능을 충분히 만들 수 있는지 확인
- 설명 / 요약 / 암기카드 / 퀴즈 품질을 점검
- chunking 전략이 실제 생성 품질에 영향을 주는지 확인

## Test Matrix

### Corpus Inclusion

- 수집 대상이 AWS 공식 문서인지 확인
- 시험 가이드와 in-scope 서비스 기준이 반영됐는지 확인
- 외부 교재나 비공식 자료가 코퍼스에 들어가지 않았는지 확인

### Chunking

- fixed-size baseline 동작 여부
- structure-aware chunking 동작 여부
- heading / list / table / note block 보존 여부
- metadata 저장 여부

### Output Quality

- 개념 설명 정확성
- 요약 품질
- 암기카드 유용성
- 퀴즈 유용성
- 출처 연결 가능성

## Evaluation Set Spec

초기 수작업 평가셋:

- concept explanation 10
- summary 8
- flashcard generation 6
- quiz generation 6

## Scoring Rules

### Concept Explanation

- 공식 문서와 모순이 없어야 한다
- 핵심 포인트를 빠뜨리지 않아야 한다
- 지나치게 장황하지 않아야 한다

### Summary

- 핵심만 남겨야 한다
- 서비스 정의와 중요 포인트가 유지돼야 한다
- 공식 문서 취지와 충돌하지 않아야 한다

### Flashcards

- 용어-정의 또는 비교 포인트가 명확해야 한다
- 암기 포인트가 실제로 유효해야 한다
- 카드 단위가 지나치게 길지 않아야 한다

### Quiz

- 짧고 명확해야 한다
- 개념 확인에 적합해야 한다
- 정답 근거를 공식 문서에서 찾을 수 있어야 한다

### Chunking Comparison

- fixed-size 대비 structure-aware가 더 자연스러운 설명 근거를 제공하는지 확인한다
- 표, 리스트, 제한사항이 잘리지 않는지 확인한다

## Verification Procedure

1. source inventory 확인
2. fixed-size baseline chunking 생성
3. structure-aware chunking 생성
4. 동일 질문셋으로 설명 / 요약 / 암기카드 / 퀴즈 생성
5. manual eval sheet에 결과 기록
6. 발표용 sample outputs 선정

## Artifact To Criterion Mapping

- `source inventory table`
  - 코퍼스 출처 검증
- `chunking comparison sheet`
  - chunking 전략 차이 검증
- `manual eval sheet`
  - 설명 / 요약 / 암기카드 / 퀴즈 품질 검증
- `sample outputs`
  - 발표 데모 적합성 검증

## Exit Condition

아래를 모두 만족하면 다음 단계 구현 또는 역할 분담으로 넘어간다.

- 공식 문서 수집 범위가 닫혔다
- chunking 전략이 정해졌다
- 설명 / 요약 / 암기카드 / 퀴즈 평가 기준이 정해졌다
- 발표용 sample output을 만들 수 있다
