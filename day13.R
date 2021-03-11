train <- read.csv("titanic/train.csv", na.strings = "")
train

test <- read.csv("titanic/test.csv", na.strings = "")
test

str(train)

# Name, Ticket, Cabin 컬럼 제거

names(train)
train <- train[,-c(4,9,11)]
train

names(test)
test <- test[,-c(3,8,10)]
test

# 성별 0,1로 변환

train$Sex <- sapply(train$Sex, switch, "male"=0, "female"=1)
test$Sex <- sapply(test$Sex, switch, "male"=0, "female"=1)

## 참고사항 : switch() ##
x <- c(5,6,7,8)
switch(1, mean(x), sum(x), var(x))

# 승선 항구 C,Q,R을 각각 0,1,2로 변환

train$Embarked <- sapply(train$Embarked, switch, "C"=0, "Q"=1, "R"=2)
test$Embarked <- sapply(test$Embarked, switch, "C"=0, "Q"=1, "R"=2)

# 나이와 운임 열에 대해 NA제거

train_age <- na.omit(train$Age)
train_age_avg <- mean(train_age) #na제외한 나머지 나이 평균
train$Age[is.na(train$Age)] <- train_age_avg

test_age <- na.omit(test$Age)
test_age_avg <- mean(test_age) #na제외한 나머지 나이 평균
test$Age[is.na(test$Age)] <- test_age_avg


# Fare

train_fare <- na.omit(train$Fare)
train_fare_avg <- mean(train_fare) #na제외한 나머지 fare 평균
train$Fare[is.na(train$Fare)] <- train_fare_avg

test_fare <- na.omit(test$Fare)
test_fare_avg <- mean(test_fare) #na제외한 나머지 fare 평균
test$Fare[is.na(test$Fare)] <- test_fare_avg


## 나이와 생존 여부 관계 그래프(시각화) ##
## 성별과 생존 여부 관계 그래프(시각화) ##
## ...
## 위와 같은 과정들이 진행된 후에 아래 내용을 이어서 진행해야함 ##
## 아래에서 age에서 18세를 기준으로 둘 수 있는 것이 
## 시각화를 진행해서 얻은 결과물이기 때문



# 나이가 18세 이상이면 0, 아니면 1로 치환

train$Age <- ifelse(train$Age<18, 1, 0)
test$Age <- ifelse(test$Age<18, 1, 0)

# 정규화(운임, 등실)

normalize <- function(x){
  num <- x-min(x)
  denom <- max(x)-min(x)
  return(num/denom)
}

train$Pclass <- normalize(train$Pclass)
test$Pclass <- normalize(test$Pclass)

test_length <- length(test$Fare)
fare <- normalize(c(train$Fare, test$Fare)) #같이 따져서 진행하지 않으면 데이터 기준이 따로놀게된다
fare
train$Fare <- fare[1:(length(fare)-test_length)] #train데이터 추출
test$Fare <- fare[(length(fare)-test_length+1):length(fare)] #test데이터 추출


# 결측값 처리할 때 : 딥러닝 예측, 회귀모델, ... 머신러닝

iris

install.packages("ggvis")
library(ggvis)
library(dplyr)

iris %>% 
  ggvis(~Petal.Length, ~Petal.Width, fill=~factor(Species)) %>% 
  layer_points()

# 정규화

mmn <- function(x){
  num <- x-min(x)
  denom <- max(x)-min(x)
  return(num/denom)
}

iris_n <- as.data.frame(lapply(iris[1:4], mmn))
summary(iris_n)

# 67% : 33%

table(iris$Species)
set.seed(1234)
rs <- sample(2, nrow(iris), replace=T, prob = c(0.67, 0.33))
train <- iris[rs==1, 1:4] #train(67%)
test <- iris[rs==2, 1:4] #test(33%)

train.label <- iris[rs==1, 5] #train(67%)
test.label <- iris[rs==2, 5] #test(33%)

library(class)

pred <- knn(train=train, test=test, cl=train.label, k=3)
pred
length(pred) # 48

sum(pred==test.label)/length(pred)

library(gmodels)
CrossTable(x=test.label, y=pred)



plot(faithful,
     main="main title",
     sub="sub title",
     xlab="eruption time(min)",
     ylab="waitin time to next eruption")


plot(faithful)
plot(faithful, las=0) #plot(faithful)결과와 같음
plot(faithful, las=1) #y축 이름들이 회전
plot(faithful, las=2) #y축 이름들이 회전+x축 이름들이 회전
plot(faithful, las=3) #x축 이름들이 회전


# 그래프 외곽선 모양 변경
plot(faithful)
plot(faithful, bty="o") #plot(faithful)결과와 같음
plot(faithful, bty="n") #수치선 제외한 외곽선 삭제
plot(faithful, bty="l") #x축,y축 제외한 외곽선 삭제
plot(faithful, bty="]") #y축 최대최소 수치선만 표현


plot(faithful)
plot(faithful, pch=3) #점이 아니라 +모양으로 좌표 찍힌다

#help에서 points 검색

plot(faithful, pch=24, col="green2", bg="blue")


plot(LakeHuron) #시계열 데이터(호수의 수위 기록)
plot(LakeHuron, lty="solid") #default
plot(LakeHuron, lty="dashed") #default
plot(LakeHuron, lty="dotted") #default
plot(LakeHuron, lty="twodash") #default



#########################################

pressure  #기온과 기압 데이터
plot(pressure) #산점도
plot(pressure, type="p") #default
plot(pressure, type="l") #line
plot(pressure, type="b") #both
plot(pressure, type="o") #both
plot(pressure, type="h") #histogram
plot(pressure, type="s") #step

plot(pressure, type="n") #nothing, 그래프 틀만 생성
# 사용자 정의 형식의 그래프 생성하고자 할 때, 사용

x <- 1:10
y1 <- exp(1:10)
y2 <- exp(10:1)
plot(x, y1, type = "n") #x축 이름:x, y축 이름:y1
lines(x, y1, type = "o", col="red")
lines(x, y2, type = "o", col="blue")


plot(x, y1, type = "n", ylab = "y") #x축 이름:x, y축 이름:y
lines(x, y1, type = "o", col="red")
lines(x, y2, type = "o", col="blue")


# 1) 격자모양 출력

plot(faithful, type="n")
grid()
points(faithful, pch=19, col="blue")

dev.off()

# 2) 격자모양 출력

plot(faithful, pch=19, col="blue")
grid()





colors() #col 속성값 657가지 색상들
grep("purple", colors(), value = T)

palette("default") #기본색상 파레트
palette()
pie(rep(1,12), col=1:12) #기본 색상 파레트

palette(rainbow(6)) #변경 파레트
palette()
pie(rep(1,12), col=1:12)


# 그라데이션 효과
pie(rep(1,12), col=gray(level = seq(0,1,length=12)))

pie(rep(1,12), col=rainbow(12, alpha=seq(0,1,length=12)))
#alpha : 투명도 (0: 완전 투명, 1: 완전 불투명)


pie(rep(1,12), col=heat.colors(12))
pie(rep(1,12), col=terrain.colors(12))
pie(rep(1,12), col=cm.colors(12))


########################################

install.packages("mlbench")
library(mlbench)

data("Ozone")
Ozone
plot(Ozone$V8, Ozone$V9)
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone", 
     pch="+")

#구글 검색어 : r pch symbols 검색하면 pch에 넣을 수 있는 것 다 나옴


plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone",
     cex=1  #defualt
     )

plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone",
     cex=0.1
)

plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone",
     cex=2
)

plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone",
     cex=1,
     col="red"  #ff0000=red
)



# 좌표 축 값의 범위 설정

plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone",
     cex=0.1,
     col="red",
     xlim = c(0,150),
     ylim = c(0,100)
)


cars
plot(cars, type="l")
plot(cars, type="o", cex=0.5)
# x가 14일 때, y값이 4개가 있음
# 이를 해결하기 위해 각각의 x(speed)마다 평균 y(dist)를 계산해보자


# quiz1
# 각각의 speed마다 평균 dist 계산

# 방법1

library(dplyr)
cars %>% 
  group_by(speed) %>% 
  summarise(mean(dist))

# 방법2

tapply(cars$dist, cars$speed, mean)

plot(tapply(cars$dist, cars$speed, mean),
     type = "o",
     xlab = "speed",
     ylab = "dist",
     cex = 0.7)



## 참고사항 : tapply(데이터, 색인, 함수) ##


# 1~10까지의 숫자를 홀수, 짝수별 합계
tapply(1:10, 1:10 %% 2==0, sum)

# iris에서 종별 Sepal.Length의 평균
tapply(iris$Sepal.Length, iris$Species, mean)





# 창 하나에 그래프 여러개 놓고 비교해야할 경우

# 창을 2칸으로 나누어 시각화 : par()
opar <- par(mfrow=c(1,2))

plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone"
     )
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone2"
)

par(opar)
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone"
)
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone2"
)


p11 <- par(mfrow=c(1,1))
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone"
)

p12 <- par(mfrow=c(1,2))

plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone"
)
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone2"
)


plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone"
)
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone2"
)


par(p11)  #기존에 설정된 화면 출력방식(p11)을 불러오기
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone"
)


p12 <- par(mfrow=c(1,2))

plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone"
)
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone2"
)


dev.off()

plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone"
)


p21 <- par(mfcol=c(2,1))
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone"
)
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone2"
)

p22 <- par(mfcol=c(2,2))
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone"
)
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone2"
)
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone"
)
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone2"
)


# 1 3
# 2 4
# 순서로 진행


p22 <- par(mfrow=c(2,2))
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone"
)
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone2"
)
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone"
)
plot(Ozone$V8, Ozone$V9, 
     xlab="Sandburg", 
     ylab="El Monte", 
     main="Ozone2"
)

# 1 2
# 3 4
# 순서로 진행

