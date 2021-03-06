id <- c("a1","a2","a3")
name <- c("x","y","z")
price <- c(1000,2000,3000)
product <- data.frame(id,name,price)
product
str(product)

# 새로운 행 추가
product[4,] <- list("a4","s",4000)
product
str(product)

product <- rbind(product,c("a4","s",4000))
product
str(product)  #이경우에도 price 부분이 문자열이 됨

new.rows <- data.frame(id=c("a5","a6"),
           name=c("i","j"),
           price=c(5000,6000))
new.rows

# 주의 사항 : 열 이름이 동일해야 함.
product <- rbind(product, new.rows)
product

# 새로운 열 추가
# 방법1
product <- cbind(product, madein=c("kor","chi","chi","kor","kor","usa"))
product

# 방법2
product$madein <- c("kor","chi","chi","kor","kor","usa")
product

# 두개 이상의 열을 추가하는 경우에는 데이터 프레임으로 생성한 다음 수행
new.cols <- data.frame(manu=c("aa","bb","aa","cc","aa","bb"),
           quantity=c(10,20,30,20,10,25))
new.cols

product

product <- cbind(product, new.cols)
product





df1 <- data.frame(sex="f", month=1, weight=3.5)
df2 <- data.frame(sex="m", month=3, weight=4.5)
df3 <- data.frame(sex="m", month=4, weight=5.5)
df4 <- data.frame(sex="f", month=7, weight=6.5)
df5 <- data.frame(sex="f", month=8, weight=7.5)

lst <- list(df1,df2,df3,df4,df5)
lst

class(lst[1])
class(lst[[1]])

str(lst[[1]])

rbind(lst[[1]],lst[[2]])

lst
#rbind(lst[[1]],lst[[2]],...lst[[120]])

# do.call() : 리스트 내의 여러 개 데이터프레임을 합치는 함수
# 작성 방법 : do.call(적용함수, list)
do.call(rbind, lst)
class(do.call(rbind, lst))



lst1 <- list(sex="f", month=1, weight=3.5)
lst2 <- list(sex="m", month=3, weight=4.5)
lst3 <- list(sex="m", month=4, weight=5.5)
lst4 <- list(sex="f", month=7, weight=6.5)
lst5 <- list(sex="f", month=8, weight=7.5)

lst <- list(lst1,lst2,lst3,lst4,lst5)
lst

# lst에 저장되어 있는 리스트들을 묶어서 하나의 데이터 프레임으로 생성
do.call(rbind, lst)
# 위와 형식이 좀 다름
# 데이터 프레임이 아니라 배열이라고 봐야함(2차원 배열)

lst[1]
as.data.frame(lst[1]) #리스트 -> 데이터 프레임


# lapply() : 첫번째 인수에는 리스트, 적용함수(반복)
lst
lapply(lst, as.data.frame)  
#lst(리스트)에 저장되어 있는 각 원소에 대해 as.data.frame 함수를 반복해서 적용해라

do.call(rbind, lapply(lst, as.data.frame))
# lst(리스트)에 저장되어 있는 각각의 요소에 대해 as.data.frame 함수를 적용하고
# 변환된 데이터프레임들을 rbind함수를 모두 적용하여 하나의 데이터 프레임으로 연결

# merge : 데이터 프레임을 결합하는 함수
state.x77
class(state.x77)  # matrix

states <- data.frame(state.x77)
str(states)  # dataframe

# 행이름만 추출
row.names(states)

states
# 열 추가
states$name <- row.names(states)
states
# 행 이름 삭제
row.names(states) <- NULL
states
# 가장 위에 6개만 보여주는 함수
head(states)
# 가장 아래 6개만 보여주는 함수
tail(states)
tail(states,10)


states
# states에서 income이 5000달러 이상에 해당되는 자료를 출력
states$name[states$Income >= 5000]

states[states$Income > 5000, "name"]
rich.states <- states[states$Income > 5000, c("name","Income")]
rich.states
# 해당하는 자료 전체 내용을 모두 추출하고 싶은 경우
# 조건을 만족하는 행을 추출(행 추출이므로 열자리 비운다)
states[states$Income>5000, ]

#states에서 Area가 100000이상에 해당되는 자료들 출력(name,Area)
large.states <- states[states$Area >= 100000, c("name","Area")]
large.states

# 데이터 프레임 결합
# (기본값 : 공통으로 열이 일치하는 행만 선택)
merge(rich.states, large.states) #all=FALSE
merge(rich.states, large.states, all = FALSE) 
merge(rich.states, large.states, all = TRUE)


# subset() : 행과 열을 선택할 수 있는 함수
states[states$Income>5000, ]
# Income이 5000보다 큰 모든 자료를 출력하라
# 위 내용을 subset으로도 줄 수 있음

subset(states, Income>5000)
# states 집합에서 ~~~조건을 만족하는 부분집합을 추출

subset(states, Income>5000 & Area>50000)
# 원래 정식 구조
subset(x=states, subset = (Income>5000 & Area>50000))
# 특정 열을 선택해서 출력
subset(x=states, subset = (Income>5000 & Area>50000), select = Murder)
subset(states, subset = (Income>5000 & Area>50000), Murder)
# 특정 열 두개 이상 선택해서 출력
subset(x=states, subset = (Income>5000 & Area>50000), select = c(Murder,Illiteracy))
subset(x=states, subset = (Income>5000 & Area>50000), c(Murder,Illiteracy))

# name이 알래스카인 모든 행 추출
subset(states, name=="Alaska")



# test문제
mtcars  #dataframe 형태
# mpg가 30보다 큰 자동차 데이터 출력
# 방법1
subset(mtcars, mpg>30)
subset(mtcars, subset = mpg>30)
# 방법2
mtcars[mtcars$mpg>30, ]

# mpg가 30보다 큰 자동차의 mpg데이터 출력
subset(mtcars, subset = mpg>30, select = mpg)

# cyl가 4개 이면서 am가 0인 자료의 mpg,hp,wt를 출력
subset(mtcars, subset=(cyl==4 & am==0), select = c(mpg,hp,wt))
# 혹은 아래와 같이 간결하게 나타낼 수 있다
subset(mtcars, cyl==4 & am==0, c(mpg,hp,wt))

# mpg열의 평균값보다 큰 자료에 대한 mpg,hp,wt를 출력
subset(x=mtcars, subset=(mpg>mean(mpg)), select = c(mpg,hp,wt))
subset(mtcars, mpg>mean(mpg), c(mpg,hp,wt))

# 이렇게 써도 나오기는 나옴. 단, 이렇게 많이 쓰지 않음
subset(subset=(mpg>mean(mpg)), select = c(mpg,hp,wt), x=mtcars)



iris
# 문제 : Sepal.width열과 Petal.Length 열을 추출
subset(iris, select = c(Sepal.Width, Petal.Length))

subset(iris, select = -c(Sepal.Width, Petal.Length))

subset(iris, select = -Sepal.Width)



# iris Sepal.Length와 Sepal.Width간 비율
iris$Sepal.Length / iris$Sepal.Width
# 특성공학(feature engineering)
# : 주어진 데이터 컬럼으로부터 연산을 수행하여 새로운 컬럼값을 생성

with(iris, Sepal.Length / Sepal.Width)


# with(iris, {
#   # 명령문 기술
# })

summary(iris$Sepal.Length)

with(iris, {
  print(summary(Sepal.Length))
  plot(Sepal.Length, Sepal.Width)
  plot(Petal.Length, Petal.Width)
})


with(iris, {
  stats <<- summary(Sepal.Length)
  stats
})
stats


iris$Sepal.Ratio <- iris$Sepal.Length / iris$Sepal.Width
iris

within(iris, Sepal.Ratio <- Sepal.Length/Sepal.Width)
iris

# with, within은 거의 동일(코드의 양을 줄여줌)
# 차이점
# within은 데이터 수정이 가능함
# with은 데이터 수정 불가능

within(iris, {
  Sepal.Ratio=ifelse(is.na(Sepal.Ratio), median(Sepal.Ratio, na.rm = T), Sepal.Ratio)
})
# Sepal.Ratio 열의 값이 na -> 중앙값으로 대체

# sqldf 패키지 : SQL 명령문을 사용할 수 있음
install.packages("sqldf") #패키지 설치
library(sqldf)  #설치된 패키지를 프로그램에서 사용하기 위해 불러오기

# SQL(Structured Query Language)
# : 데이터베이스에 데이터를 검색(select)/수정(update)/삭제(delete)/추가(insert into) 작업
# 수행할 수 있도록 해주는 사전에 약속된 데이터베이스 표준 질의어

mtcars
sqldf("select * from mtcars")
# mtcars에 저장되어 있는 모든(*) 데이터를 추출하시오.
# 검색 = select 추출컬럼1, ..., 추출컬럼n from 테이블명

sqldf("select cyl from mtcars")

sqldf("select cyl, hp, gear from mtcars")

sqldf("select cyl, hp, gear from mtcars", row.names=TRUE)

mtcars
sqldf("select  * from mtcars", row.names=TRUE)

sqldf("select * from mtcars where mpg>30", row.names=TRUE)
# where이 조건문 역할

sqldf("select * from mtcars where mpg>30 order by hp", row.names=TRUE)

sqldf("select avg(mpg) as avg_mpg from mtcars where mpg>30 group by cyl", row.names=TRUE)
# mpg 평균을 구하는게 목표


st <- state.x77
class(state.x77)  #배열

# st를 데이터 프레임으로
st <- data.frame(st)

# st의 컬럼명 출력
colnames(st)

# st의 로우명 출력
rownames(st)

# 차원?
dim(st)  # 50개, 변수(피처) 8개

rowSums(st)
rowMeans(st)