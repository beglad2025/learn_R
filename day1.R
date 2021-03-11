print("hello")
print(
  "hello"
)
print("hello")

?print
?apply

# 스칼라, 벡터, 행렬, 데이터프레임, 리스트, 텐서

# 변수 정의할 때,
a <- 3
# a 출력하는 방법 두 가지
a
print(a)

# 벡터 : 데이터 분석에서 자료의 기본형
# 스칼라 : 길이가 1인 벡터
a <- 3
b <- 2
print(b)

# 각 구문을 작성하고 ctrl + enter를 하지 않고
# 그냥 엔터만 치고 넘어가면 error 생길 수 있음
# 예로 만약 b<-2 작성 후 엔터로 넘어가면
# 그 뒤에 print(b) 했을 때, 객체 b를 찾을 수 없다고 뜸

# 벡터 생성하는 함수 : c (concatenate 의 약자)
c(1,2,3)
c("we","love","data")

odd <- c(1,3,5)
even <- c(2,4,6)
c(odd,even)

# 3부터 9까지 1씩 증가하는 수
3:9
# 5부터 1까지 1씩 감소하는 수
5:1
# 5부터 -1까지 1씩 감소하는 수
5:-1

# 다양한 증감치를 이용한 수열 생성
seq(from=3, to=9) #3:9와 동일
# 3에서 9까지 0.5씩 증가하는 수
seq(from=3, to=9, by=0.5)
# 9에서 3까지 0.5씩 감소하는 수
seq(from=9, to=3, by=-0.5)

# 수열의 길이 지정
seq(from=0, to=100, length.out=5) #0 25 50 75 100 출력

# 벡터 전체를 반복하는 함수 : times
rep(1, times=3)
rep(c(1,2,3), times=5) #1 2 3이 5번 반복

# 벡터의 각 원소값들을 반복하는 함수 : each
rep(c(1,2,3), each=5) #1이 5번, 2가 5번, 3이 5번 반복

# 활용
rep(1:3, length.out=8)
# 1 2 3이 반복되는데, 길이가 8일 때까지 반복

# 벡터는 동일한 데이터 유형으로 표현됨
n <- c(1,2,3)
cha <- c("x","y","z")
c(n,cha)  # 문자 타입으로 통일되어 출력됨

# 벡터의 유형 및 구조 확인 함수 : str (structure 의 약자)
str(n)
# num [1:3] 1 2 3 으로 출력
# num : numeric 의 약자(수치라는 의미)
str(cha)
# chr [1:3] "x" "y" "z" 으로 출력
# chr : character 의 약자

# 벡터의 길이 : 3 (=3개의 원소를 갖는 1차원 벡터)

#length : 벡터의 길이만 확인
length(n)

# 상수 벡터
LETTERS  #A-Z까지 출력
letters  #a-z까지 출력
month.abb  #월에 해당하는 문자(축약형)
month.name  #월에 해당하는 문자(풀네임)
pi  #원주율

m <- c(12,9,3,5,1)
month.name
month.name[1]  #"January" 출력
# month.name[1,2]  #error
month.name[c(1,2)]  #"January" "February" 출력

# 12,9,3,5,1에 해당하는 월 이름으로 출력되었으면 좋겠다
month.name[m]


# 벡터

# 시가 종가 거래량 (features)
# 100  200  500         [100 200 500]

# 벡터화(vectorized) 연산 => 속도가 빠르다

#이건 그냥 보통의 연산
1+2  #1이라는 벡터와 2라는 벡터에 더하기 연산을 수행한 결과
2^10
10%%3  #나머지
10%/%3  #몫

# 벡터 연산은 '원소와 원소끼리' 연산 수행
c(1,2,3) + c(4,5,6)  #5 7 9 출력

x <- c(1,2,3)
x*c(4,5,6)  #4 10 18 출력

y <- c(10,20,30)
y/c(2,4,6)  #5 5 5 출력
y%%c(3,5,7)  #1 0 2 출력
y%/%c(3,5,7)


# 원소의 개수가 서로 다른 벡터의 연산

x <- c(1:3)
y <- c(4:9)
x+y  #(1 2 3 1 2 3) + (4 5 6 7 8 9)
# x의 길이가 y의 길이보다 짧으므로
# 자동으로 x를 반복시켜서 y와 같은 길이로 만들고
# 그 다음 연산을 수행한다

c(1,2,3)+c(4,5,6,7,8)  #(1 2 3 1 2) + (4 5 6 7 8)
# 5 7 9 8 10 출력
# 두 객체의 길이가 서로 배수관계에 있지 않다는 경고메세지 나옴

# 벡터 + 스칼라
c(1,3,5) + 10  #11 13 15 출력


# 논리 연산자
# ==
# !=
# >, <, >=, <=
# !x
# x|y (or 연산)
# x&y (and 연산)
# isTRUE (x가 참입니까 여부)
v <- pi
w <- 10/3
v == w  #FALSE 출력
v != w  #TRUE
v > w  #FALSE
!(v>w)  #TRUE
v < w  #TRUE
(v==w) | (v<w)  #TRUE
(v==w) & (v<w)  #FALSE
isTRUE(v==w)  #FALSE

x<-c(1,3,5)
y<-c(3,3,3)
x==y
x==3

# R은 true는 1, false는 0으로 간주
# 논리값 -> 숫자로 변환 함수 : as.numeric
as.numeric(TRUE)  #1
as.numeric(FALSE)  #0
TRUE+TRUE #2
FALSE+FALSE #0
FALSE+TRUE #1
FALSE*TRUE #0
TRUE*TRUE #1



x<-c(0,25,50,75,100)
x>50

sum(1:5)
sum(1,2,3)
sum(1:2,3:5)
sum(TRUE,FALSE,TRUE)

sum(x>50)


# any 함수 : 논리값이 하나라도 TRUE이면 결과가 TRUE
# all 함수 : 논리값이 모두 TRUE이면 결과가 TRUE

a <- -3:3
a
a>0
any(a>0) #TRUE
all(a>0) #FALSE

# 2의 제곱근의 제곱 -> 2
# 하지만 R에서는 정확하게 2가 아님
# 부동소수점수 연산을 사용하기 때문
sqrt(2) #1.414214
sqrt(2)^2 #2
sqrt(2)^2-2 #0일거 같지만 4.440892e-16 나옴


# 수치 비교시, 정밀도 문제를 피하기 위해서는
# all.equal() 함수를 이용
all.equal(sqrt(2)^2,2)  #TRUE
# 약간의 오차를 무시하므로 두 값이 같다고 출력


# 문자 벡터끼리 연산하고 싶을 때 : paste
fruits <- c("Apple","Banana","Strawberry")
food <- c("Pie","Juice","Cake")

# fruits+food #error:이항연산자에 수치가 아닌 인수
paste(fruits,food)

paste(fruits,"Juice")


# 절댓값 함수 : abs
x <- -3:3
abs(x)

# 로그값 함수 : log
# 디폴트값은 밑수가 e(=2.718...)인 자연로그
log(1:5)
# 밑수가 e가 아닌 경우 : base 추가해서 사용
log(1:5, base=3) #밑수가 3인 로그
log(1:5, base=2) #밑수가 2인 로그
log(1:10, base=10) #밑수가 10인 로그

log10(1:10) #밑수가 10인 로그
log2(1:10) #밑수가 2인 로그


# 밑수가 e인 지수값 함수 : exp
exp(1:5)

y <- exp(1:5)
log(y) #1 2 3 4 5


# 펙토리얼 함수 : factorial
factorial(1:5)


# 컴비네이션 함수 : choose
# 5개 중에서 2개를 선택하는 경우의 수
choose(5,2) #10


# 제곱근 함수 : sqrt
sqrt(1:5)  #유효자릿수가 7자리
# 유효자리수 확인
options("digits")  #7
# 특정하게 유효자리 숫자 지정하고 싶을 때,
signif(456.789, digits = 2)
signif(456.789, digits = 3)
signif(456.789, digits = 4)

# 반올림 함수 : round
round(456.789, digits = 1)
round(456.789, digits = 2)
round(456.789, digits = 3)


# Quiz
# 1~10까지 수에 대한 각각의 제곱근을 구한다음
# 소수이하 2자리까지 출력
x <- sqrt(1:10)
x
signif(x, digits = 3)
round(x, digits = 2)
# 혹은
round(sqrt(1:10), digits = 2)
round(sqrt(1:10), 2)

round(456.789, digits = 1)
#정수자리에서 첫번째 자리에서 반올림
round(456.789, digits = -1)  #460
#정수자리에서 두번째 자리에서 반올림
round(456.789, digits = -2)  #500

#반올림 숫자가 5인 경우에는 가까운 짝수로 반올림
round(11.5) #12
round(12.5) #12
round(12.51) #13
round(12.49) #12

# floor : 작은 가까운 정수로 반올림
# ceiling : 큰 가장 가까운 정수로 반올림
# trunc : 0에 가까운 정수로 반올림(버림)
floor(456.78) #456
floor(-456.78) #-457

ceiling(456.78) #457
ceiling(-456.78) #-456

trunc(456.78) #456
trunc(-456.78) #-456


# 무한대(Infinite; Inf)
3/0 #Inf
5-Inf #-Inf
Inf*Inf #Inf
Inf*(-Inf) #-Inf

# R에서는 1.8*10의 308승까지 표현 가능
# 그 이후부터는 무한대로 표현
10^306
is.infinite(10^306) #FALSE
is.infinite(10^307) #FALSE
is.infinite(10^308) #FALSE
is.infinite(10^309) #TRUE
#혹은
is.infinite(10^(306:310)) #FALSE FALSE FALSE  TRUE  TRUE


#NaN(Not a Number : 숫자가 아님, 계산결과를 정의할 수 없다)
Inf/Inf
Inf*0
log(-2)
NaN+3
is.nan(Inf*0) #TRUE

#NA(Not Available, 결측값)
k <- NA
k+2
sqrt(NA)



z <- 1:5
z
sum(z)
prod(z)  #벡터에 있는 모든 요소들 곱하는 것
min(z) #1, 최소값
max(z) #5, 최대값
mean(z) #3, 평균
median(z) #3, 중위값
var(z) #2.5, 분산
sd(z) #1.581139, 표준편차
range(z) #1 5, 범위

z <- c(z,NA)
z
sum(z) #NA
range(z) #NA NA
median(z) #NA


# NA는 제거하고 나머지에 대해 수행해라
sum(z, na.rm=TRUE) #15
na.omit(z)
sum(na.omit(z)) #15


# 누적합 함수 : cumsum
traffic.death <- c(10,20,30,20)
cumsum(traffic.death) #10 30 60 80
#한계
traffic.death <- c(10,20,NA,30,20)
cumsum(traffic.death) #10 30 NA NA NA


# 두 원소 간의 차 : diff
traffic.death <- c(10,20,30,20)
diff(traffic.death) #10  10 -10
#한계
traffic.death <- c(10,20,NA,30,20)
diff(traffic.death) #10 NA NA -10 


1:10
diff(1:10)
diff(1:10, lag=3) #3칸 떨어진 원소간의 차를 구함
#4-1 = 3, 5-2 = 3, ..., 10-7 = 3



# 집합
p <- 1:10
q <- 6:15

#합집합
union(p,q)
#교집합
intersect(p,q)
#차집합
setdiff(p,q) #1 2 3 4 5
setdiff(q,p) #11 12 13 14 15
#두 집합이 동일한지 확인
setequal(p,q) #FALSE


# is.element() : 첫번째 인수에 오는 값이
# 두번째 벡터의 원소인지 테스트
is.element(3, 1:5) # TRUE
is.element(6, 1:5) #FALSE
is.element(4:7, 1:5) #TRUE  TRUE FALSE FALSE


# 인덱스
num <-0:30
num
num[5] #4
num[5:10] #4 5 6 7 8 9
num[c(2,5,10,27)] #1  4  9 26

prime <- c(2,3,5,7,11,13)
idx <- c(1,3,5)
prime[idx]

prime[-3] #3번 인덱스인 5가 사라지고 나머지가 출력

prime[-2:-4] #2번~4번 인덱스가 제외
prime[-(2:4)] #2번~4번 인덱스가 제외

prime <- c(2,3,5,7,11,13)
length(prime)
prime[1:(length(prime)-2)]

prime[-length(prime)]

prime[2] <- 30
prime

prime[c(3,4)] <- c(30,40)
prime


