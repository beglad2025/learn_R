# 스크립트 : 명령어 집합
# 야드 -> 미터로 변환하는 명령어 집합

# transLength.R에 저장된 스크립트 내용
# x <- c(30,50,60)
# tlength <- round(x*0.9144,1)
# tlength
# result <- paste(tlength, "m", sep="")
# print(result)


# 위 내용을 그대로 ctrl+c 해서 새로운 script 생성해서 그곳에
# ctrl+v 한뒤, transLength.R 이라고 저장


# 이 파일 내에서 스크립트 transLength.R을 실행하고자 함

source("transLength.R")  #transLength.R 파일의 결과가 출력됨


# 내가 원하는 것
# : 야드의 정보가 바뀌어도(x내의 벡터값이 달라져도) 미터로의 
# 환산의 결과를 얻고 싶다
# 위의 transLength.R을 실행시킨 방식을 쓴다면 x내의 벡터값이
# 달라질 때마다 해당 스크립트를 수정해야할 것이다
# 이러한 번거로움을 극복하기 위해 사용되는 것이 '함수'이다



# 함수

# 함수 정의 방법 -> 메모리에 적재
# 함수 이름 <- function(x){
#   
# }

transLength <- function(x){
  tlength <- round(x*0.9144,1)
  res <- paste(tlength, "m", sep="")
  return(res)
}

# ls : list의 약자
# 메모리에 적재된 변수, 함수 등의 이름이 목록으로 출력됨

ls()

transLength(10)

y <- c(100,150,200)
transLength(y)

trans2 <- transLength
trans2(y)

trans2


# print 따로 명시 안해도 결과 출력됨

f1 <- function(x,y){x+y}
f1(1,3)

# 중괄호 빼도 정상적으로 진행됨
# 함수에서 실행할 문장이 1개인 경우에는 중괄호 생략 가능

f2 <- function(x,y) x+y
f2(2,5)


# 만약 x에 들어간게 숫자가 아닌 문자라면 진행안하는 함수

trans3 <- function(x){
  # x에 전달된 내용인 숫자가 아니면
  if(!is.numeric(x)){
    return("not a number")
  }
  tlength <- round(x*0.9144, 1)
  res <- paste(tlength, "m", sep="")
  return(res)
}

trans3(10)
trans3("10")


# QUIZ

transLength <- function(x,y){
  if(y=="feet"){
    tlength <- round(x*3,1)
    res <- paste(tlength, "ft", sep="")
    return(res)
  }
  if(y=="inch"){
    tlength <- round(x*36,1)
    res <- paste(tlength, "in", sep="")
    return(res)
  }
}

y <- c(100,150,200)
# 피트(feet), 인치(inch) 변환이 가능한 함수
# 1야드 = 3피트, 1야드, 36인치

transLength(y,"feet") #피트로 변환
transLength(y,"inch") #인치로 변환


# 강사님 방법

transLength <- function(x,mult=0.9144,unit="m"){
  tlength <- round(x*mult,1)
  res <- paste(tlength, unit, sep="")
  return(res)
}

y <- c(100,150,200)
transLength(y, mult=3, unit="ft") #피트로 변환
transLength(y, mult=36, unit="in") #인치로 변환

transLength(y)
transLength(x=y, mult=3, unit="ft")
transLength(y, 3, "ft")




transLength <- function(x,mult=0.9144,unit="m", ...){
  tlength <- round(x*mult, ...)
  res <- paste(tlength, unit, sep="")
  return(res)
}

y <- c(100,150,200)
transLength(y,digits=3)

round(3.56789)  # digits = 0이 디폴트 값으로 설정되어 있음
transLength(y)  # 따라서 ... 자리에 digits 없으면 디폴트 값으로 진행


# digits = 1을 기본값으로 주고 싶은 경우

transLength <- function(x,mult=0.9144,unit="m", d=1){
  tlength <- round(x*mult, digits=d)
  paste(tlength, unit, sep="")
}

y <- c(100,150,200)
transLength(y)


# 함수 자체를 인수처럼 취급할 수 있음

transLength <- function(x,mult=0.9144,unit="m", FUN=round, ...){
  tlength <- FUN(x*mult, ...)
  paste(tlength, unit, sep="")
}

y <- c(100,150,200)
transLength(y)


transLength(y, FUN=floor)
# floor : 원 데이터에 가까운 정수로 출력

transLength(y, FUN=signif, digits=3)



x <- pi
y <- 3
if(x>y)x
if(x>y){
  print(x)
}

if(x<y) x else y


# 조건문은 벡터 연산을 할 수 없다
# 조건문에 벡터가 포함되면 벡터의 요소 중 첫번째 요소만이 연산
# 아래에서 y가 5개지만, 첫번재 원소인 1만 x와 비교

x <- pi
y <- 1:5
if(x<y)x else y

# 조건문에 벡터를 포함하고자 한다면 ifelse()함수 사용
# ifelse(조건, 참, 거짓)

t <- c(TRUE, FALSE, TRUE, FALSE, TRUE)
y <- 1:5
n <- 0
ifelse(t, y, n)

# ifelse 함수는 벡터 연산이 가능

x <- pi
y <- 1:5
ifelse(x>y, x, y)


# switch 함수 : 첫번째 인수로 주어진 값에 따라 두번째 인수에
# 지정된 코드가 실행됨



center <- function(x, type){
  switch(type,
         mean = mean(x),
         median = median(x),
         trimmed = mean(x, trim = 0.1),
         "choose one of mean, median, and trimmed"
         )
}

x <- c(2,3,5,7,11,13,17)
center(x, "mean")
center(x, "median")
center(x, "trimmed")  #trimmed : 절사평균

# 절사평균
# 산술평균(mean)이 outlier(이상치)에 민감하게 반응하는 것을
# 보정해서 평균을 낸 것

# other은 center함수에서 정의해놓지 않았음 따라서
# "choose one of mean, median, and trimmed"가 출력됨

center(x, "other")




i <- 5
repeat{if(i>25)break
  else{
    print(i)
    i <- i+5
  }
  }


i <- 5
while(i<=25){
  print(i)
  i <- i+5
}

# for문
# for(변수 in 리스트) 반복명령문

for(i in seq(from=5, to=25, by=5))  print(i)

# 반복문 작성시 참고사항
# 1) 실행결과는 루프 안에서는 출력되지 않는다

for(i in seq(from=5, to=25, by=5)) i

# 위와 같이 작성된 경우, 아무것도 출력되지 않는다
# 만약 i를 출력하고 싶다면

for(i in seq(from=5, to=25, by=5))  print(i)

# 위처럼 print 함수 써야한다

# 2) for문이 종료된 이후에도 변수는 사라지지 않는다

i <- 1
for(i in seq(from=5, to=25, by=5)) i
print(i)

# 가장 마지막에 i에 할당된 25가 저장되어 있음





# 데이터 전처리 : 분석목적에 적합한 형태로 만드는 것
# 수집되어 전처리 되어야 할 대상 데이터를 R에서 어떤 자료구조로 표현?
# 자료구조 
# : 하나의 차원 -> 벡터
# : 두 개 이상의 차원 -> 행렬(배열), 리스트, 데이터 프레임 등

# 행렬/배열은 동일한 데이터 유형으로 구성
# 데이터프레임, 리스트는 숫자와 문자가 섞여있는 데이터 유형으로 구성



# mode : 데이터 유형(숫자, 문자, 논리, 리스트, 함수, ...)
mode("Batman")
mode(c("Batman", "Superman", "Somun"))
mode(factor("High", "Med", "Low"))
mode(as.Date("2021-03-02"))
mode(5>2)
list(1.2, "apple", c(3,4))
mode(list(1.2, "apple", c(3,4)))
mode(mean)


d <- as.Date("2021-03-02")
d+1
as.integer(d)  #188688 (일), 1970.1.1을 기준으로 현재까지 경과한 날
length(d)


as.numeric(1.618) #1.618
mode(1.618)
as.integer(1.618) #1
as.character(1.618) #"1.618"
as.numeric("test") #NA : 변환이 불가능한 경우 NA 출력
as.numeric("1.234") #1.234 : 변환 가능
mode(as.numeric("1.234"))  #numeric

# 벡터도 변환이 가능할까? -> 가능하다

as.numeric(c("-1", "1.5", "3.14"))

# "test"가 포함되어 있으면 어떻게 될까?

as.numeric(c("-1", "1.5", "3.14", "test")) #NA

mode(10:20)
as.character(10:20)
as.numeric(as.character(10:20))

# 논리값도 숫자로 바꿀 수 있을까? -> 가능

as.numeric(TRUE) #1
as.numeric(FALSE) #0

sum(c(TRUE, FALSE, TRUE))

# c(1,3,5,7,9) 벡터에서 4보다 큰 수는 총 몇개인가?
sum(c(1,3,5,7,9)>4) #3


# 리스트 -> 분석 모델에서 요구하는 타입이 데이터프레임 => 타입 변환
x
as.data.frame(x)

# 벡터에서 다른 타입으로 변환
vec <- 1:6
vec


# 벡터 -> 리스트 변환
# as.list() vs list()
# 벡터의 각각의 원소가 리스트의 원소로 변환됨

as.list(vec)

# 벡터 전체가 하나의 원소를 갖는 리스트로 변환

list(vec)


# 벡터 -> 행렬 변환
# cbind() vs as.matrix() vs rbind()

vec <- 1:6
vec
cbind(vec)
as.matrix(vec)

# cbind와 as.matrix의 차이는 행의 이름을 vec으로 주느냐(cbind)
# 그냥 숫자 인덱스로 주느냐(rbind)의 차이이다

rbind(vec)


matrix(vec, 2, 3)

# 벡터를 하나의 열로 구성된 데이터프레임으로 변환
# vector -> matrix -> df

as.data.frame(rbind(vec))

rbind(vec)
mode(rbind(vec))
class(rbind(vec))


# 행렬 구조를 벡터, 리스트, 데이터프레임으로 변환
# as.vector(), as.list(), as.data.frame()



# 3행 2열(1~6) 행렬 => 벡터, 리스트, 데이터프레임

mat <- matrix(1:6, nrow = 3, ncol = 2)
as.vector(mat)
as.list(mat)
as.data.frame(mat)


# 리스트 -> 다른 구조
# unlist() : 리스트 -> 벡터
# 리스트 요소에 이름이 있는 경우에는 이름을 갖는 벡터로 변환

lst <- list(odd=c(1,3,5), even=c(2,4,6))
lst

unlist(lst)

# as.vector함수로 작성해도 아무 변화 없음

as.vector(lst) #여전히 리스트

identical(lst, as.vector(lst)) #TRUE

lst2 <- list(odd=c(1,3,5), even=c("two", "four", "six"))
lst2

unlist(lst2)

# 리스트 -> 행렬 : unlist -> 벡터를 행렬로 변환

lst <- list(odd=c(1,3,5), even=c(2,4,6))
lstvec <- unlist(lst)
matrix(lstvec, 3, 2)


# dimnames인수 : 리스트의 원소 이름을 행렬의 행 또는 열 이름으로 사용
matrix(unlist(lst), 3, 2, dimnames = list(NULL, names(lst)))


# 주의 사항 :리스트에 matrix 함수, as.matrix를 그대로 적용하면
# 행렬로 변환 안됨
# matrix(lst)
# as.matrix(lst)


# as.data.frame 함수 : 리스트 -> 데이터 프레임으로 변환
# 숫자와 문자가 섞여있으면, 숫자 -> 숫자벡터로 문자->문자벡터로 변환됨

lst <- list(odd=c(1,3,5), even=c(2,4,6))
lstdf <- as.data.frame(lst)
str(lstdf)

lst2 <- list(odd=c(1,3,5), even=c("two", "four", "six"))
lstdf2 <- as.data.frame(lst2)
str(lstdf2)




# 데이터 프레임 -> 다른 구조로 변환
# 데이터 프레임 인덱싱 : 열로부터 백터를 생성
# 데이터 프레임 행 -> 데이터 프레임으로 출력


df1 <- data.frame(odd=c(1,3,5), even=c(2,4,6))
df1
df1[1,]

str(df1[1,])  # 행 추출 -> 데이터 프레임


df1[,1]
str(df1[,1])  # 열 추출 -> 벡터로 나옴


# 콤마 없이 추출 -> 열 추출
# 데이터 프레임으로 추출됨

df1[1]
df1[2]

# 이중 대괄호 추출 -> 열 추출
# 벡터 형태로 추출

df1[[1]]
df1[[2]]


# 데이터 프레임 전체를 벡터로 변환
# 단, 데이터 프레임이 하나의 행 또는 열로 구성된 경우에만 가능

# 데이터프레임 -> 행렬 -> as.vector를 이용하여 벡터로 변환
df2 <- data.frame(odd=c(1,3,5), even=c(2,4,6))
df2

as.vector(df2)  # 아무변화 없음

#1) 데이터프레임 -> 행렬

as.matrix(df2)

#2) 행렬 -> 벡터

as.vector(as.matrix(df2))


df3 <- data.frame(odd=c(1,3,5), even=c("two", "four", "six"))
as.vector(as.matrix(df3))


# as.list() : 데이터프레임 -> 리스트
# 숫자 -> 숫자벡터, 문자->문자(이전버전에선느 펙터)로 변환

df4 <- data.frame(odd=c(1,3,5), even=c(2,4,6))
as.list(df4)
str(as.list(df4))


df5 <- data.frame(odd=c(1,3,5), even=c("two", "four", "six"))
as.list(df5)
str(as.list(df5))

# 이전 버전까지는 Levels : four six two와 같이 팩터로 변환됨
# 그러나 지금 버전은 문자 벡터로 출력됨




# as.matrix() : 데이터프레임 -> 행렬
# 모두 숫자로 구성 -> 숫자 행렬
# 모두 문자로 구성 -> 문자 행렬

df6 <- data.frame(odd=c(1,3,5), even=c(2,4,6))
as.matrix(df6)


df7 <- data.frame(odd=c(1,3,5), even=c("two", "four", "six"))
as.matrix(df7)
