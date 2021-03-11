p <- c(2,3,5,7,11,13,17,19)
p
p[3]
p[3:5]
p[c(1,5,7)]

p[-3]
p[-3:-5]
p[-(3:5)]

length(p)
p[1:length(p)-1]
p[-length(p)]

p[2] <- 13
p
p[c(6,8)] <- c(100,200)
p
length(p)
p[15] <- 99
p


# 불린참조
p
p<10

p[p<10] #p<10보다 작은 값들만 참조 출력

p
p[c(TRUE,TRUE,FALSE)]


# which() : 논리값 -> TRUE 위치 인덱스 추출 함수
# which.max()
# which.min()

data <- c(100:111)  #12건 데이터
data
which(data>105)

month.abb[which(data>105)]

# data에 저장된 자료 중 최소값의 인덱스
which.min(data)
# data에 저장된 자료 중 최대값의 인덱스
which.max(data)

# 요일별 교통사고 사망자수 데이터
traffic.death <- c(100,90,80,70,120,150,200) #월~일요일 사망자수
# 토요일 사망자수
traffic.death[6]

# names : 벡터에 이름을 정의하는 함수
# 하지만 인덱스로 참조하는 것보다 이름으로 참조하는것이 더 좋음
# 인덱스로 해놓으면 어떤 값인지 알기 어렵기 때문
names(traffic.death) <- c("mon","tue","wed","thu","fri","sat","sun")
names(traffic.death)

traffic.death["sat"]

traffic.death[c("sat","wed")]

# 사망자수가 100명 이상인 요일만 출력하고 싶다
traffic.death >= 100
traffic.death[traffic.death >= 100]
names(traffic.death[traffic.death >= 100])


# 팩터(factor)
# 카테고리 구분하는 목적으로 사용되는 데이터를 범주형 데이터라고 함
# 레벨을 원소로 하는 데이터

# 레벨(level)
# 범주형(팩터)에 포함된 범주값

# factor() 함수 : 범주형 데이터로 사용하고자 하는 문자or숫자 벡터를 팩터로 변환

review <- c("good","good","bad","indifferent","bad","good")
# 문자 벡터
review

review.factor <- factor(review)
review.factor

str(review.factor)
str(review)

as.numeric(review.factor) #펙터형 -> 숫자벡터로 변환

everyday <- c("mon","mon","fri","thu")
# everyday.factor <- factor(everyday)
# everyday.factor

everyday.factor <- factor(everyday, levels = c("mon","tue","wed","thu","fri","sat","sun"))
everyday.factor

levels(everyday.factor)

levels(review.factor) <- c("B","G","I")
review.factor

nlevels(review.factor)
length(levels(review.factor))


# 서열팩터(ordered factor)
# 순서가 있는 범주형 데이터, 부등호 기호로 서열 표시
eval <- c("Medium","Low","High","Medium","High")
eval.factor <- factor(eval)
eval.factor

eval.ordered <- factor(eval, levels = c("Low","Medium","High"), ordered = TRUE)
eval.ordered

# table() : 각 레벨별 빈도
eval.factor
table(eval.factor)
# 일반 factor -> 알파벳 순서대로 출력되었음

eval.ordered
table(eval.ordered)
# 순서가 있는 factor -> 지정한 순서로 출력


# 숫자벡터 ->팩터로 변환
# 남 : 1, 여 : 2
sex <- c(2,1,2,2,1)
sex.factor <- factor(sex, levels = c(1,2), labels = c("Male","Female"))
sex.factor

# 상관없는 값인 0이라는 값을 넣어본다면
sex <- c(2,1,2,2,1,0)
sex.factor <- factor(sex, levels = c(1,2), labels = c("Male","Female"))
sex.factor
# 0자리에 <NA>라고 표현됨


# 2차원 벡터 = 행렬
# 벡터에 차원을 부여하여 행렬 생성-> dim 함수
# 행렬은 벡터로 구성
# 즉, 행렬을 구성하는 벡터는 타입이 모두 동일해야함
# matrix 함수로도 행렬 생성(가장 일반적)

v <- 1:12
dim(v)
# NULL 출력 : 아무것도 들어있지 않으므로
dim(v) <- c(3,4)  #행:3, 열:4
v
dim(v)


matrix(data = v, nrow = 3, ncol = 4)
# 기본적으로 열방향으로 데이터가 나열됨
# 만약, 행방향으로 나열을 원하면 byrow
matrix(data = v, nrow = 3, ncol = 4, byrow = TRUE)

matrix(v, 3, 4, byrow=TRUE)

rnames <- c("r1","r2","r3")
cnames <- c("c1","c2","c3","c4")
matrix(v,3,4,byrow = TRUE, dimnames = list(rnames,cnames))

matrix(0, 3, 4)
matrix(NA,3,4)

matrix(v,3,4)
mat <- matrix(v,ncol=4)
mat
str(mat)
dim(mat)
nrow(mat)
ncol(mat)
length(mat) #벡터의 길이


# 두 벡터를 결합하여 행렬을 생성
v1 <- 1:5
v2 <- 6:10

rbind(v1,v2)
cbind(v1,v2)

# 벡터와 행렬을 결합하여 새로운 행렬 생성
1:3
4:6
cbind(1:3,4:6,matrix(7:12,3,2))


# 행력과 행렬간 결합하여 새로운 행렬 가능
matrix(1:6,2,3)
matrix(7:12,2,3)
rbind(matrix(1:6,2,3),matrix(7:12, 2, 3))


v <- 1:12
mat <- matrix(v,3,4)
mat

mat[1,]
mat[,3]
# 행렬이 아니라 벡터의 형태로 출력됨

# 그대로 행렬 상태로 출력하고 싶은 경우
# 행 또는 열이 2차원 형식을 그대로 유지
mat[1,,drop=FALSE]
mat[,3,drop=FALSE]
# 그대로 행렬 상태로 출력

mat[2:3,]
mat[,3:4]
mat[1:2,2:3]
mat[c(1,3),]

mat
mat[,c(1,4)]
mat[,-c(2,3)]

# 값 변경
mat[1,3] <- 77
mat

mat[2,] <- c(22,55)
mat

mat[2:3,3:4] <- c(1,2,3,4)
mat


# Quiz
# matrix 생성

rnames <- c("seoul","busan","daegu","gwangju","jeonju")
v <- c(0, 350, 300, 300, 200,350,0,50,200,190,300,50,0,180,200,300,200,180,0,80,200,190,200,80,0)
city.distance.mat <- matrix(v,5,5,byrow = TRUE, dimnames=list(rnames,rnames))

city.distance.mat
city.distance.mat["seoul","busan"]
city.distance.mat[,"seoul"]
city.distance.mat[c("seoul","gwangju"),]


w <- c(1,2,3,4,5,6)
mtx <- matrix(w,2,3)
mtx

# 행렬의 연산

# 벡터의 연산과 똑같이 적용된다.
mtx + 1
mtx - 1
mtx * 2
mtx / 2

# 행렬 간 연산할 때는 반드시 두 행렬의 차원이 같아야함
matrix(1:6,2,3)
matrix(6:1,2,3)

matrix(1:6,2,3)+matrix(6:1,2,3)

# 만약 차원의 크기가 다르면 어떻게 될까?
matrix(1:6,2,3)+matrix(6:1,3,2)
# error : 배열의 크기가 올바르지 않습니다



matrix(1:6,2,3) * matrix(6:1,2,3)
#element-wise product
#같은 위치에 있는 요소들끼리만 연산된다.
matrix(1:6,2,3)
matrix(6:1,2,3)

# 행렬의 곱셈은 앞의 행렬의 행의 개수와 뒤의 행렬의 열의 개수가 일치

w
matrix(w,2,3) %*%matrix(w,2,3)  #행렬의 곱셈
#error : 적합한 인자들이 아닙니다.
matrix(w,2,3) %*%matrix(w,3,2)

# 행렬과 벡터의 곱셈
mtx <- matrix(w,2,3)
mtx %*% 1:3
# (2행3열의 행렬) %*% (길이3인 벡터)
# 행렬의 곱셈이 진행되기 위해서는 앞의 행렬의 행의 개수와
# 뒤의 행렬의 열의 개수가 일치해야 하므로
# (2행3열의 행렬) %*% (3행1열의 행렬)
# 결과적으로 2행1열의 행렬로 결과가 도출된다.


# 행 <-> 열 바꾸기 : t 함수
mtx
t(mtx)
t(t(mtx))  #mtx와 동일하게 생겼다.


# 행 단위의 합계 : rowSums
mtx
rowSums(mtx)

# 열 단위의 합계 : colSums
colSums(mtx)

# 행 단위의 평균 : rowMeans
rowMeans(mtx)

# 열 단위의 합계 : colMeans
colMeans(mtx)

