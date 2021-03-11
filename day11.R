# 모델
# 1. 데이터를 7:3 비율로 train(890건)/test(4~500건) 데이터로 나눔
# - train 데이터를 7:3 비율로 나눔
#     단, 꼭 7:3비율일 필요는 없음
# - train/검증(validation) 데이터로 나눔
# 2. 데이터 전처리
# 3. 데이터 분석
# 4. 알고리즘 선택
# 5. 모델링
# -->모델 성능 평가
#   모델 성능 평가는 검증 데이터로 하게 됨
#   퍼러미터 수정, 과적합 여부 확인
# 6. 모델 수정 -> 5번과정으로 이동
# 7. 성능평가 결과에 대해 만족 -> 모델링 중단
# 8. 모델 사용



# 데이터 전처리(S-A-C) 패키지 : dplyr
# 데이터 분할(S) -> 분할 자료에 대해 함수 적용(A) -> 결과 취합(C)
# arrange(정렬), filter(행추출), select(열추출), mutate(열추가), summarise(요약)

head(airquality)

# Month가 6인 자료 

library(dplyr)
air <- filter(airquality, Month==6)
head(air)

# 다른 방법1 : 인덱스 추출
airquality[airquality$Month==6,]

# 다른 방법2 : subset 함수
subset(airquality, subset = (Month==6))


# Month가 6, Temp가 90 초과
# and 연결은 , 또는 & 기호를 사용

air <- filter(airquality, Month==6, Temp>90)
# 또는
air <- filter(airquality, Month==6 & Temp>90)
head(air)

# or 연산

air <- filter(airquality, Temp>90 | Ozone>80)
air



# 단순히 특정 위치의 행데이터 추출을 원하면 slice()  함수

slice(airquality, 6:10) # 6:10 -> 추출하고자 하는 행 번호


# arrange() : 지정한 열을 기준으로 데이터 프레임 정렬

# Temp를 기준으로 오름차순 정렬
arrange(airquality, Temp)
# Temp를 기준으로 내림차순 정렬
arrange(airquality, desc(Temp))

# Temp의 값이 같은 경우 다음 조건(Month)에 따라 정렬하라
arrange(airquality, desc(Temp), Month)
arrange(airquality, desc(Temp), Month, Day)

# Quiz order함수

airquality[order(-airquality$Temp,airquality$Month, airquality$Day),]
with(airquality, airquality[order(-Temp, Month, Day),])


# select() : 열 추출
# ,는 여러 개의 떨어진 열을 추출
# :는 연속된 열을 추출
# -는 특정 열 제거해 추출

air <- select(airquality, Month, Day, Temp)
head(air)

select(airquality, Temp:Day)
head(select(airquality, Temp:Day))

select(airquality, -(Ozone:Wind))
head(select(airquality, -(Ozone:Wind)))

select(airquality, Solar=Solar.R)
head(select(airquality, Solar=Solar.R))
# 단, 이름 변경은 select보다는 rename을 쓰는 것을 권장

air <- rename(airquality, Solar=Solar.R)
head(air)


# 특정 열에 포함된 중복되지 않은 데이터 추출 : select+distinct 함수 조합(=unique함수)

distinct(select(airquality, Month)) #dataframe 형태
unique(airquality$Month) #vector 형태


# mutate : 새로운 열(파생변수) 추가

airquality$Temp

# 화씨 -> 섭씨 : (화씨-32)/1.8

head(mutate(airquality, Temp.c=(Temp-32)/1.8))

# mutate 함수는 생성한 새로운 열을 동일한 함수 내에서 사용 가능
head(mutate(airquality, Temp.c=(Temp-32)/1.8, diff=Temp.c-mean(Temp.c)))


# transform 함수에서는 에러 발생(새로운 열(Temp.c)을 동일한 함수 내에서 (Diff) 사용 불가)
# head(transform(airquality, Temp.c=(Temp-32)/1.8, diff=Temp.c-mean(Temp.c)))
# 위와 같은 명령이 안된다는 말이다


# 요약 통계 : summarise 함수
summarise(airquality, mean(Temp))

summarise(airquality,
          Min=min(Temp, na.rm = TRUE),
          Median=median(Temp, na.rm = TRUE),
          Mean=mean(Temp, na.rm=TRUE),
          Sd=sd(Temp, na.rm = TRUE),
          Max=max(Temp, na.rm = TRUE),
          N=n(),
          )


summarise(airquality,
          Min=min(Temp, na.rm = TRUE),
          Median=median(Temp, na.rm = TRUE),
          Mean=mean(Temp, na.rm=TRUE),
          Sd=sd(Temp, na.rm = TRUE),
          Max=max(Temp, na.rm = TRUE),
          N=n(),
          Distinct.Month=n_distinct(Month),
          First.Month=first(Month),
          Last.Month=last(Month),
)


summary(airquality)


# sample_n : 포본 추출(개수)
# sample_frac : 표본 추출(비율)
# 옵션 : replace=TRUE(복원추출)

sample_n(airquality, 5)
sample_frac(airquality, 0.1)


# group_by() : 그룹별로 분할

air.group <- group_by(airquality, Month) # 월별로 그룹화
air.group


# 월별 통계량

summarise(air.group,
          Mean_Temp=mean(Temp, na.rm=TRUE))


air.group.Temp <- summarise(group_by(airquality, Month),
                            Mean_Temp=mean(Temp, na.rm=TRUE))
air.group.Temp


# 파이프연산자 : %>%(ctrl+shift+m) 
# 한 함수로부터 연산결과가 다음 함수의 인수로 전달되도록 하는 연산자

iris
head(iris)

iris %>% head

# 위 두 구문은 같은 결과를 가져온다

1:10 %>% mean
1:10 %>% mean %>% sqrt

# 위와 같이 연결해서 쓸 수 있다는 장점이 있다



# 1. 파이프 연산자 사용하지 않은 경우

a1 <- select(airquality, Ozone, Temp, Month)

# a데이터를 Month를 기준으로 그룹화
group_by(a1, Month)

a2 <- group_by(a1, Month)
summarise(a2,
          Mean.Ozone=mean(Ozone, na.rm=TRUE),
          Mean.Temp=mean(Temp, na.rm=TRUE)
          )

a3 <- summarise(a2,
                Mean.Ozone=mean(Ozone, na.rm=TRUE),
                Mean.Temp=mean(Temp, na.rm=TRUE)
                )

# a3자료 중 Ozone이 40초과하거나, Temp가 80초과인 데이터(행)를 추출
a4 <- filter(a3, Mean.Ozone>40 | Mean.Temp>80)
a4


# 2. 파이프 연산자 사용한 경우


air <- airquality %>% 
  select(Ozone, Temp, Month) %>%  #a1
  group_by(Month) %>%  #a2
  summarise(Mean.Ozone=mean(Ozone, na.rm=T),
            Mean.Temp=mean(Temp, na.rm=T)) %>%   #a3
  filter(Mean.Ozone>40 | Mean.Temp>80)  #a4
air


# as.data.frame() : tibble -> data frame 
air_df <- as.data.frame(air)
air_df  #dataframe 형태로 변환

# tbl_df() : data frame -> tibble
tbl_df(air_df)



install.packages("Lahman")
library(Lahman)
str(Batting)
tail(Batting)

library(dplyr)
Batting.tbl.df <- tbl_df(Batting)
Batting.tbl.df

Batting
Batting.tbl.df



# 데이터 변환

# 데이터의 외형상 특징 : 와이드형, 롱형
# 와이드형 : 하나의 행이 하나의 개체의 특징들에 대한 값으로 채워지는 경우
# 롱형 : 데이터를 열에 따라 아래쪽으로 쭉 늘어놓음
# ex) 롱형 예시
# subject      var      value
# abercda01   siint       1
# abercda01   teamID      1
# abercda01    ..        0.5
# abercda01    ..
# abercda01    HR        



# melt함수 : 와이드형 -> 롱형 변환, reshape2패키지 설치
# dcast함수 : 롱형 -> 와이드형 변환, reshape2패키지 설치

install.packages("reshape2")
library(reshape2)


smiths  #reshape2에 포함된 데이터, 와이드형식으로 저장

# 롱포멧으로 변환
smiths.long <- melt(data=smiths)
smiths.long

# 특정하게 지정하여 만들고 싶은 경우 : id.vars=""
smiths.long <- melt(smiths, id.vars = "subject")
smiths.long

str(smiths)
# subject가 팩터로 되어있으므로
# melt함수를 이용하여 와이드형->롱형으로 변환시,
# 자동으로 subject변수를 식별자로 사용하게 됨

# dcast : 롱포맷 -> 와이드포맷
# 변수 배치는 formula로 지정
# x~y : x에는 식변자 변수, y에는 측정변수, 변수가 여러개일 때는 +로 연결

smith.wide <- dcast(smiths.long, formula = subject ~ variable)
smith.wide

airquality  # 와이드포맷 자료, 153개 행으로 구성
# 롱형으로 변환
aq.long <- melt(airquality)
aq.long  # 153*6=918개 행으로 구성


# Month와 Day를 묶어서 식별자로 사용해보자
aq.long <- melt(airquality, id.vars = c("Month", "Day"))
aq.long


# aq.long를 와이드형으로 변환
# 변수 배치는 formula로 지정
# x~y : x에는 식별자 변수, y에는 측정변수, 변수가 여러개일 때는 +로 연결

aq.wide <- dcast(aq.long, formula = Month+Day ~ variable)
aq.wide




# left_join() : 열 데이터 합치기
# bind_rows() : 행 데이터 합치기
