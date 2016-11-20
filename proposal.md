# Proposal

## Title of this project

멜론 랭킹 역분석

## Name of group members

- 김태영
- 방준호
- 조휘철
- 유재홍

## What kind of data we will use

- 음원 정보
  - 음원명
  - 가수명
  - 음원 출시일
  - 관련 지표
- 멜론
  - 주간 차트 TOP100
  - 주별 트렌드 차트
- 가온 주별 차트
  - Digital Chart
  - Download Chart
  - Streaming Chart
  - BGM Chart
  - Mobile Chart
  - Album Chart
  - 노래방 Chart
  - Social Chart
  - Weibo Chart

## What kind of problem we are solving

음원시장에 있어서 멜론([link](http://www.melon.com))은 국내에서 압도적인 시장 점유율을 가지고 있다.

이에 음원의 성공 여부를 따질 수 있는 여러 요소중 "멜론에서의 음원 순위"와 어떤 요소들이 관계에 있는지 알아보기로 한다.

멜론의 순위에 대한 알고리즘은 공개되어있지 않으므로, 한국음악콘텐츠산업협회에서 만든 "가온차트"의 정보와 멜론 사이트의 데이터에

머신러닝기법을 적용한후 과연 어떤 요소들이 어떤식으로 순위에 영향을 미치는지 알아보기로 한다.

## How we would solve problem

### ETL Process

- 멜론 차트 크롤링 및 주별 순위 파싱
  - 순위
  - 음원명
  - 날짜
  - 가수정보
- 가온 주별 차트 크롤링 및 파싱
  - 곡별 Digital, Download, Streaming, BGM, Mobile, Album, 노래방, Social, Weibo 지표 생성
- 멜론, 가온 data join

### Training Process

- Linear Regression
   - ETL Process를 통해 얻은 데이터를 이용하여 변수들과 순위의 상관관계를 알아보고 적합한 예측 모델을 개발한다.
- SVM
 
## How we will evaluate solution

원하는 주차의 순위를 예측하기 위해 과거의 데이터들을 이용해 예측 모델을 만들고 순위를 예측해본다. 이를 통해 실제 멜론의 순위와 예측 순위를 비교해 예측 모델의 정확성을 평가한다.

위 과정을 통해 예측이 잘 맞는 모델을 선택하고 어떠한 feature가 유의미하며 큰 영향을 주는지 확인해본다.
