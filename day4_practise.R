# 1.다음 물음의 답을 R 언어로 나타내시오.
# ① 자료 -0.2, 1, 2, 1.5, 2.2를 자료벡터로 x로 저장하라.
x <- c(-0.2, 1, 2, 1.5, 2.2)
x

# ② "Kim", "Lee", "Park", "Lim"을 자료벡터 name으로 저장하라. 
name <- c("Kim", "Lee", "Park", "Lim")
name

# ③ 2부터 9까지의 정수벡터를 생성하라.
n <- 2:9
n

# ④ 0부터 10까지 0.5씩 증가하는 실수 벡터를 생성하라.
r <- seq(from=0, to=10, by=0.5)
r

# ⑤ 정수 1,2,3이 3번 반복하는 벡터를 생성하라.
n.rep <- rep(1:3, times=3)
n.rep



 
# 2.x=c(2, -1, 3, 7, 0.5, 8)가 실행되었다 하자.
# 다음 물음을 R 언어로 답하시오.
# ① 5번째 원소는?
x <- c(2, -1, 3, 7, 0.5, 8)
x[5]

# ② 첫 번째부터 3번째까지의 원소는?
x[1:3]

# ③ 6, 2, 4번째 원소를 동시에 찾아라.
x[c(6,2,4)]

# ④ 3번째 원소를 제외한 나머지 원소는?
x[-3]

# ⑤ x의 원소 중 0보다 큰 값을 찾아라.
x[x>0]

# ⑥ 짝수 원소들을 찾아라.
x[x%%2 == 0]

# ⑦ x에서 홀수원소를 찾아 제거하라.
x <- c(2, -1, 3, 7, 0.5, 8)
x <- x[-which(x%%2 != 0)]
x




# 3.패키지에 내장된 데이터 cats는 다음 3개의 변수로 구성되어 있다.
library(MASS) # MASS패키지를 로드
cats.h <- head(cats)    # cats데이터프레임의 앞 줄 보기

# -생쥐 자료(cats)의 자료의 수를 구하시오
nrow(cats) * ncol(cats)
length(cats)

# -생쥐의 몸무게와 심장의 무게(Bwt와 Hwt)의 평균과 표준편차를 구하라.
# cats.h의 평균, 표준편차
Bwt.m <- mean(cat.h[["Bwt"]])
Bwt.m
Bwt.sd <- sd(cat.h[["Bwt"]])
Bwt.sd

Hwt.m <- mean(cat.h[["Hwt"]])
Hwt.m
Hwt.sd <- sd(cat.h[["Hwt"]])
Hwt.sd

# cats 자료 전체의 평균, 표준편차
Bwt.m <- mean(cats[["Bwt"]])
Bwt.m
Bwt.sd <- sd(cats[["Bwt"]])
Bwt.sd

Hwt.m <- mean(cats[["Hwt"]])
Hwt.m
Hwt.sd <- sd(cats[["Hwt"]])
Hwt.sd

# -생쥐의 암수별 몸무게와 심장의 무게의 평균과 표준편차를 각각 구하라.
# 1) 데이터프레임 cats에서 암수를 구분하여 따로 저장
cats.F <- subset(cats, Sex == "F")
cats.M <- subset(cats, Sex == "M")

# 2) 결과 matrix로 정리
Bwt.m <- c(mean(cats.F[["Bwt"]]), mean(cats.M[["Bwt"]]))
Bwt.sd <- c(sd(cats.F[["Bwt"]]), sd(cats.M[["Bwt"]]))
Hwt.m <- c(mean(cats.F[["Hwt"]]), mean(cats.M[["Hwt"]]))
Hwt.sd <- c(sd(cats.F[["Hwt"]]), sd(cats.M[["Hwt"]]))

cats.mtx <- rbind(Bwt.m, Bwt.sd, Hwt.m, Hwt.sd)
colnames(cats.mtx) <- c("F","M")
cats.mtx

# 4. 벡터 d1, d2가 다음과 같을 때 각 문제를 수행하기 위한
# 코드를 작성하고 답을 구하시오.
d1 <- 1:50
d2 <- 51:100
# d1, d2의 값을 출력하시오.
d1
d2

# d2의 길이(원소의 개수)를 보이시오.
length(d2)

# d1+d2, d2-d1, d1*d2, d2/d1의 각각의 결과를 출력하시오.
d1+d2
d2-d1
d1*d2
d2/d1

# d1, d2의 값들의 합을 각각 출력하시오.
sum(d1)
sum(d2)

# d1, d2에 있는 모든 값들의 합을 출력하시오.
sum(c(d1,d2))

# d2에서 가장 큰 값과 가장 작은 값을 출력하시오.
max(d2)
min(d2)

# d2와 d1의 값들의 평균값을 각각 구하고 두 평균의 차이를 출력하시오.
d2.m <- mean(d2)
d1.m <- mean(d1)
abs(d2.m-d1.m)

# 5.다음과 같이 벡터 v1을 생성한 다음
# 각 문제를 수행하기 위한 코드를 작성하고 답을 구하시오
# (문제를 풀다 보면 v1의 내용이 변경되기도 하는데,
# 모든 문제는 최초의 v1을 대상으로 하여 해결 할 것).
v1<- 30:100
# v1에서 60보다 작은 수를 모두 출력하시오.
v1[v1<60]

# v1에서 70보다 작은 수가 몇 개인지 출력하시오.
length(v1[v1<70])

# v1에서 65보다 큰 수들의 합을 출력하시오.
sum(v1[v1>65])

# v1에서 60보다 크고 73보다 작은 수를 모두 출력하시오.
v1[60<v1 & v1<73]

# v1에서 65보다 작거나 80보다 큰 수를 모두 출력하시오.
v1[v1<65 | v1>80]

# v1에서 7로 나누었을 때 나머지가 3인 수를 모두 출력하시오.
v1[v1%%7 == 3]

# v1에서 7의 배수들은 값을 0으로 변경하시오.
v1<- 30:100
v1[v1%%7 == 0] <- 0
v1

# v1에서 짝수를 모두 합한 값을 출력하시오.
v1<- 30:100
sum(v1[v1%%2 ==0])

# v1에서 홀수이거나 80보다 큰 수를 모두 출력하시오.
v1[v1%%2 != 0 | v1>80]

# v1에서 3과 5의 공배수를 출력하시오.
v1[v1%%3==0 & v1%%5==0]

# v1에서 짝수에 대해서만 2를 곱하여 저장하시오.
v1<- 30:100
v1[v1%%2==0] <- v1[v1%%2==0]*2
v1

# v1에서 7의 배수들을 제거한 후 v1의 내용을 출력하시오.
v1 <- 30:100
v1 <- v1[-which(v1%%7 == 0)]
v1

# 6. iris데이터에서
# Sepal.Length Sepal.Width Petal.Length Petal.Width 값이 각각 
# (4.0, 3.0, 1.5, 0.15)일때 예상되는 종(setosa, verisicolor, virginica)을 출력하시오
# (4.0, 3.0, 1.5, 0.15)와 가장 유클리디안 거리가 가까운 데이터를 9개 찾아낸다
# 9개의 데이터에 대한 종별 빈도수를 기반으로 유추
# ex) setosa:6, veri:2, vir:1 => setosa 예상
iris
x <- c(4.0-min(iris$Sepal.Length)/(max(iris$Sepal.Length) - min(iris$Sepal.Length)), 
       3.0- min(iris$Sepal.Width) / (max(iris$Sepal.Width) - min(iris$Sepal.Width)), 
       1.5- min(iris$Petal.Length) / (max(iris$Petal.Length) - min(iris$Petal.Length)), 
       0.15 - min(iris$Petal.Width) / (max(iris$Petal.Width) - min(iris$Petal.Width)))
x

# 정규화 작업(normalization) : (각각의 자료값 - 최소값) / (최대값 - 최소값)
iris$Sepal.Length <- (iris$Sepal.Length - min(iris$Sepal.Length)) / (max(iris$Sepal.Length) - min(iris$Sepal.Length))
iris$Sepal.Width <- (iris$Sepal.Width - min(iris$Sepal.Width)) / (max(iris$Sepal.Width) - min(iris$Sepal.Width))
iris$Petal.Length <- (iris$Petal.Length - min(iris$Petal.Length)) / (max(iris$Petal.Length) - min(iris$Petal.Length))
iris$Petal.Width <- (iris$Petal.Width - min(iris$Petal.Width)) / (max(iris$Petal.Width) - min(iris$Petal.Width))
iris

iris.euclid <- within(iris, euclid <- sqrt(rowSums((iris[,-5] - x)^2)))
iris.euclid

key<-sort(iris.euclid$euclid)[1:10]
key
summary(iris.euclid$Species[iris.euclid$euclid<=key])




