df <- read.csv("day7_practise/train.csv", na.strings = "")

str(df)

# 표로 정리해서 보여줌 : view

View(df)

# 하지만 이 경우, 데이터가 많아지면 NA 빈도 등을 알아보기 쉽지 않음



# 패키지 설치

# 기술통계량 포함된 패키지
install.packages("psych")
library(psych)

# 결측맵 함수가 포함된 패키지
install.packages("Amelia")
library(Amelia)
missmap(df, col = c("red","grey"))
# 옆에 plot 탭에 그래프 형태로 나타남

# 데이터 전처리에 많이 이용되는 패키지

library(dplyr)
df.sel <- select(df, Survived, Pclass, Age, Sex, SibSp, Parch)
missmap(df.sel, col = c("red","grey"))
# df를 missmap했을 때보다 확연히 붉은색이 줄었다


df.omit <- na.omit(df.sel)
missmap(df.omit, col = c("red","grey"))
# 이제 붉은색이 아예없다


class(df.omit$Survived)

# 생존은 어떤 값보다는 생존 유무로 이해하므로
# factor로 변경
# 단, 순서 없음

df.omit$Survived <- factor(df.omit$Survived)

# 위와 마찬가지로 factor로 변경
# 단, 순서 있음

df.omit$Pclass <- factor(df.omit$Pclass, order = TRUE, levels = c(3,2,1))

str(df.omit)
# Survived : Factor
# Pclass : Ord.Factor



# 시각화 패키지
library(ggplot2)

install.packages("GGally")
library(GGally)


# ggcorr() : correlation 시각화해주는 함수

ggcorr(df)

# 오른쪽의 범례를 원하는 양만큼 나누고 싶은 경우

ggcorr(df, nbreaks = 6)

ggcorr(df, nbreaks = 6, label = TRUE,
       label_size = 3, color = "grey50")






mtcars
str(mtcars)

# match함수를 이용한 데이터셋 결합

a <- c(1,2,3,4,5)
b <- c(2,5,7,8,9)
match(a,b)
match(a,b,nomatch = 0)

car <- mtcars
row.names(car)
car$name <- row.names(car)
head(car)

row.names(car) <- NULL
head(car)


# car에서 hp 145마력이 넘는 자동차 모델로만 데이터 프레임 구성

highhp.car <- car[car$hp>145, ]
highhp.car


# car에서 wt 3200파운드 미만

lightwt.car <- car[car$wt<3.2, ]
lightwt.car

# 무게가 가벼우면서 힘이 쎈 자동차 모델

# 위 조건에 만족하는 인덱스 번호

index <- match(highhp.car$name, lightwt.car$name)
index

lightwt.car[na.omit(index),]


# match 함수 대신, %in% 연산자 사용 가능

vec <- 10:1
vec

7 %in% vec
c(20,15,11,9,8,3,1,0) %in% vec

match(c(20,15,11,9,8,3,1,0), vec)

# match 함수와 차이점이 있다면, 없는 경우
# match 함수는 NA 출력, %in%는 FALSE 출력


!is.na(match(c(20,15,11,9,8,3,1,0), vec))
c(20,15,11,9,8,3,1,0) %in% vec

# 위처럼 !is.na를 붙이면, 같은 결과 출력


# 무게가 가벼우면서 힘 쎈 자동차 모델을 %in% 써서 출력해보자

idx <- highhp.car$name %in% lightwt.car$name
idx
highhp.car[idx,]


# 서브셋
# $ : 데이터로부터 하나의 원소를 추출
# 데이터프레임에 적용하면 벡터로 반환

# [[]] : 데이터로부터 하나의 원소를 추출
# 이름과 위치에 의해 원소 선택 가능
# 리스트나 데이터 프레임 모두 사용가능

# [] : 데이터로부터 여러 개의 원소 추출

str(mtcars)

mtcars$mpg

mtcars[["mpg"]]
mtcars[[1]]

mtcars["mpg"]
mtcars[1]

mtcars[c(1,4)]
mtcars[c("mpg","hp")]


# 음수 인덱스 : 특정 원소를 제외한 서브셋 생성

mtcars[-c(2,3,5,7:11)]

# 특정 열 제거

mtcars[1] <- NULL
mtcars

# 단, 음수와 양수 함께 섞어서 사용 못함



# Quiz

data(iris)
str(iris)

# 1~4번 열 추출

iris[1:4]
iris[c(1,2,3,4)]
iris[c(1:4)]
iris[-5]


# Sepal.Length, Sepal.Width 추출 

iris[,c("Sepal.Length", "Sepal.Width")]  #데이터프레임형태

# Sepal.Length만 추출

iris[,"Sepal.Length"]  #벡터형태
iris[,"Sepal.Length",drop=FALSE]  #데이터프레임형태
class(iris[,"Sepal.Length",drop=FALSE])


iris["Sepal.Length"]  #데이터프레임형태
iris[,"Sepal.Length"]  #벡터형태


iris[1:5]  #1~5 열 데이터 전체가 추출
iris[1:5,]  #1~5 행 인덱스의 데이터가 추출

iris[1:5,c("Sepal.Length","Sepal.Width")]
iris[1:5,c(1,2)]
iris[1:5,1:2]


# Quiz : Sepal.Length가 7 초과한 데이터 전체를 추출

iris[iris$Sepal.Length>7,]
iris[iris["Sepal.Length"]>7,]



subset(iris,
       select = c("Sepal.Length","Sepal.Width"),
       subset = (Sepal.Length>7))



# 데이터 무작위 표본 추출
# sample()
# sample(데이터셋,  표본개수, 복원추출여부)

# 1~10 수 중에서 5개 숫자를 비복원 추출

sample(1:10, 5)

# 디폴트값 : replace=FALSE(비복원추출 즉, 중복 없음)

sample(1:10, 5, replace = TRUE)

# replace=TRUE(복원추출 즉, 중복 가능)

# 10개가 랜덤하게 비복원추출

sample(1:10)


iris  #순서대로 정렬이 되어있는 상태, sample함수로 뒤죽박죽 만들 수 있음




# 데이터 -> 모델 -> 예측/분류

# 모델링 과정?
#   1) 데이터를 훈련용(70%)/테스트용(30%)으로 분할
#   2) 오직 훈련용 데이터만으로 모델(예측/분류)을 생성
#     과적합(오버피팅, overfitting)
#     : 훈련데이터로 평가한 결과 >> 테스트 데이터 평가 결과
#     과적합 원인
#     : 데이터가 부족 -> 보충, 변수가 너무많음(고차원)->차원축소(저차원),
#       다중공선성, ...
#   3) 테스트






# sample 함수 동일한 난수가 발생
# seed값을 동일하게 주면, 매번 발생되는 난수가 동일하게 추출

# seed값 설정
set.seed(20210303)
sample(1:10)

# 데이터의 일부를 추출해 모델을 생성하는데,
# 이때 seed값을 설정하지 않으면 매번 추출이 달라짐
# ex) 데이터가 1~10번까지 10개
#     랜덤 : 1245679 번 추출(훈련데이터) -> 모델 -> 평가(3,8,10번으로 평가해봄. 잘 맞는지 아닌지)
#     정확도 30%
#     정확도 평가 하려면 처음에 넣은 3,8,10번을 또 넣어서 평가해봐야 함
#     즉, 동일한 데이터를 넣어야하는데 이를 위해 seed를 설정하는 것이다


set.seed(1)  #이 작업은 한번만 수행하고 이후 진행하는 모든 sample함수에 적용된다
sample(1:10,5,replace = TRUE)


# 데이터 프레임으로부터 무작위 추출

sample(iris, 3)

# 데이터 프레임 행으로부터 표본 추출

set.seed(1)

# 행번호 추출

index <- sample(1:nrow(iris),5)
iris[index,]

# 일반적으로 중복값은 제거
# duplicated() : 중복 여부를 논리값으로 출력

duplicated(c(1,2,3,1,1,4,3))


id <- c("a001","a002","a003")
name <- c("mouse","keyboard","usb")
price <- c(3000,9000,5000)
product <- data.frame(id=id, name=name, price=price)
product

# c("a001","mouse",3000) 추가하고 싶다

product <- rbind(product, c("a001","mouse",3000))

# 중복 제거

duplicated(product)
product.unique <- product[!duplicated(product),]

# which함수와 duplicated 함수로 중복 위치 파악할 수 있다
# which() : true에 해당되는 데이터의 index 추출

which(duplicated(product))

# 중복 행 제거

idx <- which(duplicated(product))
product.unique <- product[-idx,]
product.unique

# 중복 원소 파악하지 않고 제거만 수행

product
unique(product)


# complete.cases 함수 : 결측값 여부를 true/false(false : 해당되는 결측값 제거)

airquality
str(airquality)
complete.cases(airquality)

# 결측값이 없는 행만 추출
# (complet.cases 수행결과 true)

airquality[complete.cases(airquality),]

# 결측값이 있는 행만 추출

airquality[!complete.cases(airquality),]




airquality.nona <- airquality[complete.cases(airquality),]
airquality.nona
str(airquality.nona)


airquality.nona2 <- na.omit(airquality)
airquality.nona2


# cut() : 데이터를 구간에 따라 그룹별로 범주화
# () : 개구간, [] : 폐구간(포함)
# (3,10) : 범위가 3초과, 10미만
# (3,10] : 범위가 3초과, 10이하

iris$Sepal.Width
min(iris$Sepal.Width)
max(iris$Sepal.Width)

cut(x=iris$Sepal.Width, breaks = c(0,1,2,3,4,5))
# 디폴트값 : right = TRUE : ( , ] 형식으로 범위 생김


cut(x=iris$Sepal.Width, breaks = c(0,1,2,3,4,5), right = FALSE)
# right = FALSE : [ , )


# table 함수, summary 함수와 함께 사용

iris.cut1 <- cut(x=iris$Sepal.Width, breaks = c(0,1,2,3,4,5))
table(iris.cut1)
summary(iris.cut1)


# 

iris.cut2 <- cut(x=iris$Sepal.Width,
    breaks = c(0,1,2,3,4,5),
    labels = c("Smaller","Small","Medium","Big","Bigger"))
table(iris.cut2)
summary(iris.cut2)



# 구간 자동설정(breaks 자동 설정)

cut(x=iris$Sepal.Width, breaks = 5)


# 범위의 최소값 포함

cut(x=iris$Sepal.Width, breaks = 5, include.lowest = TRUE)

# 범위의 최소값 미포함

cut(x=iris$Sepal.Width, breaks = 5, include.lowest = FALSE)


iris.cut3 <- cut(x=iris$Sepal.Width,
                 breaks = 5,
                 labels = c("Smaller","Small","Medium","Big","Bigger"),
                 include.lowest = TRUE)
iris.cut3


# include.lowest=TRUE는 최소값을 포함시키는 옵션




# 데이터 정렬

x <- c(3,7,5,1,2,5)

# 오름차순
sort(x)
# 내림차순
sort(x, decreasing = TRUE)


# 길이
length(x)
# NA 추가
length(x) <- 7
x


sort(x)
# NA값이 출력되지 않음

# NA를 맨 마지막에 넣어달라
sort(x, na.last = TRUE)
# NA를 맨 앞으로 넣어라
sort(x, na.last = FALSE)



# order함수 : 정렬, 데이터프레임 정렬 사용시 사용

y <- c(11,22,33,55,44)
order(y)
y[order(y)] # 정렬된 결과물 얻는다


y <- c(11,22,33,55,44)
z <- c("ss","bb","ii","aa","pp")
df <- data.frame(y,z)
df


# y열을 기준으로 오름차순 정렬
order(df$y)
df[order(df$y),]

# y열을 기준으로 내림차순 정렬
df[order(df$y, decreasing = TRUE),]


w<-c("c","c","n","n","n")
df<-data.frame(y,z,w)
df

# w열 1차 기준, y열 2차 기준

df[order(df$w, df$y),]

df[order(df$z, df$y),]



# xtfrm() : 동일하지 않은 정렬 방법을 적용

df$w
xtfrm(df$w)  #숫자벡터로 변환


# w열을 기준을 내림차순(-), y열 기준으로 오름차순

index <- order(-xtfrm(df$w), df$y)
index
df[index,]



# Quiz

idx <- order(-xtfrm(iris$Species), iris$Sepal.Length)
iris[idx,]



 