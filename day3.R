# 배열?
# 행렬의 일반화된 데이터 형식, 차원을 속성으로 갖는 벡터
# 벡터(1차원), 행렬(2차원) 모두 배열이라고 할 수 있음

# dim함수로 배열 생성
a <- 1:24
dim(a) <- c(3,4,2)  #3차원(2개의 면(테이블), 3행4열)
a

# array 함수 : 다차원 배열 생성
ary <- array(1:24, c(3,4,2))
ary

# 데이터 추출
ary[1,3,2]  #2번째 면의 1행2열에 있는 자료, 벡터 형태로 출력
ary[1,,]  #모든 면에서 1행에 있는 자료
ary[,1,]  #모든 면에서 1열에 있는 자료
ary[,1,2]  #2번째 면에 있는 1열의 값, 벡터 형태로 출력

# 벡터가 아니라 2차원 행렬로 출력하고자 할 때
ary[,1,2,drop=FALSE]




# 리스트
# 벡터와 행렬은 원소의 데이터 타입이 모두 같아야 함
# 리스트는 다양한 데이터 타입을 저장할 수 있음(벡터,행렬,배열과의 가장 큰 차이점)
lst <- list(0.6,0.9,0.5)
lst
# [[1]]은 원소의 위치(인덱스)
# [1] 0.6은 원소의 값
# 리스트에는 스칼라, 벡터(숫자/문자), 행렬, 함수 저장 가능

lst <- list(1.5,"apple",c(2,3,4),matrix(1:6,ncol = 3),mean)
lst

lst <- list()
lst
lst[[1]] <- 1.5
lst[[2]] <- "apple"
lst[[3]] <- c(2,3,4)
lst[[4]] <- matrix(1:6,ncol=3)
lst[[5]] <- mean
lst


# 이름 만들기
lst <- list(0.6,0.9,0.5)
lst
names(lst) <- c("n1","n2","n3")
lst
# 이름을 주면 [[1]] 형식이 $이름 형식으로 변경됨

lst$n1

lst
# lst 내에 이름들을 알고 싶다
names(lst)
# lst에 저장된 내용의 개수
length(lst)


# lst[[n]] <-> lst[n]
# lst[[n]] : lst 리스트의 n번째 원소가 선택
# 원소의 저장 형식을 그대로 가지고 출력

# lst[n] : lst 리스트의 n번째 원소가 선택
# 원소가 리스트 형식으로 출력

product <- list("a001","mouse",30000)
product
product[[3]] #[1] 30000, 벡터 형식 그대로 출력됨
product[3]
# [[1]]
# [1] 30000
# 하나의 원소를 가지고 있는 리스트 형식으로 출력

# 타입확인
class(product[[3]])  #numeric(숫자 벡터)
class(product[3])  #list

product[[3]]*0.9
product[3]*0.9  # error

# 여러개 참조할 때
# 참조 결과는 리스트
product[c(1,2)]


# 불린 참조
product[c(TRUE,FALSE,TRUE)]


# 제외
product[1]
product[-1]


# 이름 참조
product <- list("a001","mouse",30000)
product
product <- list(id="a001",name="mouse",price=30000)
product

# 방법1
product$name

# 방법2
product[["name"]]

# 2개 이상의 원소 참조
# 출력결과는 리스트
product[c("name","price")]

# 이름을 만약 잘못 쓴 경우
product[["name"]]
product[["nn"]]  #없는 이름으로 접근하면 NULL

product[[2]]
product[[4]]  #error : 첨자의 허용범위 벗어남



lst <- list(one=1,two=2,three=list(a=3.1, b=3.2))
lst
# 3번째 원소 추출(추출 결과 또한 리스트)
lst$three
lst[["three"]]
# 3번째 원소 안에 1번째 원소 추출(추출 결과는 벡터)
lst$three$a
lst[["three"]][["a"]]
# 3번째 원소 안에 1번째 원소 추출(추출 결과는 리스트)
lst[["three"]]["a"]



# 리스트 조작 : [[]], $ 기호 사용하여 요소 접근
product <- list(id="a001",name="mouse",price=30000)
product
# 방법1
product[[3]] <- 50000
product
# 방법2
product[["price"]] <- 50000
product
# 방법3
product$price <- 50000
product

# 값을 1개 할당할 때는 [[]], [] 모두 가능
# 방법1
product[3] <- 30000
product
# 방법2
product["price"] <- 30000
product

# 하나의 원소에 여러 개의 값을 할당할 때는 [[]],[] 는 다름
product <- list(id="a001",name="mouse",price=30000)
# [[]]는 할당 데이터가 벡터 형식
# []는 할당하고자 하는 값을 리스트 형식으로 변환해야 함

product[[3]]<-c(40000,50000)
product

product[3] <- c(20000,30000)
# error
product[3] <- list(c(20000,30000))
product


# 두 개 이상의 원소 값들을 동시 변경할 때는 []를 사용
product[1:3] <- list("a02","monitor",99999)
product


# 자료 추가
product[[4]] <- c("domestic","export")
product

product$madein <- c("Korea","India")
product

product[["madein2"]] <- c("USA","China")
product

product["madein3"] <- list(c("UK","France"))
product


# 리스트에 여러개 원소를 한번에 추가
# 리스트 구조로 저장
# 타입이 모두 같은 경우는 벡터 구조로 저장해도 가능
product[8:10] <- list(0.1,0.2,0.3)
product

product[8:10] <- list(0.1,0.2,"0.3")
product

product[11:13] <- c(0.1,0.2,0.3)
product

product[11:13] <- c(0.1,0.2,"0.3")
product
# 추가하는 값들이 문자 형태로 변환되어 저장됨
# 타입이 다르기 때문
# 따라서 list로 추가해야 원하는 타입으로 값이 저장될 수 있음

n <- c("one","two","three")
v <- c(100,200,300)
mylist <- list()
mylist[n] <- v
mylist



# NULL 할당 : 리스트에서 원소 제거
mylist[["two"]] <- NULL
mylist

mylist[c("one","three")] <- NULL
mylist


# 조건에 따른 원소 제거
n <- c("one","two","three")
v <- c(100,200,300)
mylist <- list()
mylist[n] <- v
mylist

mylist[mylist<200] <- NULL
mylist



# 리스트와 리스트의 결합(벡터와 같음)
w1 <- list("a","b","c")
w2 <- list("d","e","f")
c(w1,w2)


# R의 수치연산 관련 함수 대부분은 벡터 자료구조를 사용
mydata <- list(1.5,2.0,3.5,4.5)
mean(mydata)
# 만약 리스트로 저장된 데이터를 연산하려면, 벡터로 변환
# unlist : 리스트 -> 벡터
mean(unlist(mydata))

max(mydata)
max(unlist(mydata))
min(unlist(mydata))





# 데이터프레임
# 행렬과 공통점 : 행과 열로 구성, 2차원 구조
# 행렬과 차이점
# 행렬은 모든 데이터 타입이 일치해야함
# 데이터프레임은 서로 다른 데이터 타입을 가질 수 있음(리스트와 같음)
# 데이터프레임은 2차원 구조, 리스트는 1차원 구조

# 데이터프레임이란
# 동일한 길이의 벡터로 이루어진 리스트를 구성요소로 하는 데이터 구조
# 보통 데이터프래임 형식으로 데이터를 받는 것이지, 
# 우리가 데이터프래임을 생성하는 일은 별로 없음

# data.frame() : 벡터로부터 데이터프레임 생성
v1 <- c("a1","a2","a3")
v2 <- c(10,20,30)
v3 <- c("x","y")
data.frame(v1,v2)

data.frame(v1,v2,v3)
# error
#v3가 동일한 길이의 벡터가 아니므로

v3 <- c("x","y","z")
df <- data.frame(v1,v2,v3)
str(df)
#observation의 약자 -> obs
#3 variables = 3 features



# 이미지 데이터
#    x1  x2  ...  x10000
# 0  0   20  ...   255
#    0   20  ...   255
#    0   20  ...   255
#    ...
# 99 0   20  ...   255
# 
# 
# 100(obs 혹은 instance 혹은 object라고도 표현할 수 있겠다)장의 이미지
# 각 이미지 데이터의 차원은? 10000차원, feature가 10000개 있음
# 각각의 이미지가 10000차원 공간의 (0,20,...,255) 위치에 점으로 표시됨
# 유클리디안 거리 또는 코사인 유사도 동의 알고리즘 기반 처리 계산을 통해
# 유사한 데이터를 찾아낼 수 있음

df
str(df)


# 행 이름으로 특정 벡터를 지정
data.frame(row.names = v1, v2, v3)

p <- data.frame(id=v1,name=v2,price=v3)
str(p)

v1 <- c("a1","a2","a3")
v2 <- c(10,20,30)
v3 <- c("x","y","z")
df <- data.frame(v1,v2,v3)
df
p <- data.frame(id=v1, price=v2, name=v3)
p
str(p)

# stringsAsFactors(데이터를 factor 형태로서 string을 읽겠습니까?)
# 벡터 -> 데이터프레임 생성할 때 데이터 타입을 팩터로 지정
# stringsAsFactors=FALSE
# 팩터 형태로 문자열을 읽지 않겠다.
# 즉, 문자열로 읽겠다.
# stringsAsFactors=TRUE
# 팩터로 문자열을 읽겠다.
# 즉, 문자열을 팩터로 읽겠다.

p <- data.frame(id=v1, price=v2, name=v3, stringsAsFactors = TRUE)
str(p)

# 원래는 문자열에 해당하던 id열과 name 열이
# factor로 변해있는 것을 알 수 있다.
# 내가 원하는 특정 구역만을 선택할 수 있는 것이 아니라
# 전체 다 적용된다는 점을 잊지말자


# as.data.frame 함수 : 행렬, 리스트로부터 데이터프레임 생성
mat <- matrix(c(1,2,3,4,5,6), ncol=2)
mat
class(mat)
# 행렬 -> 데이터 프레임
num <- as.data.frame(mat)
num
class(num)

colnames(num) #열 이름 알고 싶을 때
colnames(num) <- c("d1","d2")
num


v1 <- c("a1","a2","a3")
v2 <- c(10,20,30)
v3 <- c("x","y","z")
lst <- list(v1,v2,v3)
lst
p<-as.data.frame(lst)
colnames(p) <- c("id","name","price")
p


# length 함수
# 행렬에서는 전체 데이터의 개수가 출력(전체 원소의 개수)
# 데이터프레임에서는 열의 개수가 출력
length(p)  #3출력, 열의 개수 : 3

ncol(p)  #3출력, 열의개수 : 3

nrow(p)  #3출력, 행의개수 : 3



# 데이터프레임에서의 인덱싱

# datesets 패키지 : R 설치시 기본적으로 내장되어 있는 데이터셋
state.abb
state.name
state.region
state.area  #면적(평방마일) 정보

str(state.abb)
str(state.name)
str(state.region)
str(state.area)

us.state <- data.frame(state.abb, state.name, state.region, state.area)
us.state

str(us.state)

# state.name 열 추출

# [[]] or []를 사용하여 열 추출
# [[]] : 열 하나를 벡터 or 팩터로 출력
# [] : 데이터프레임이 추출, 하나 또는 여러 개의 열을 추출

us.state[[2]]
str(us.state[[2]])  #벡터로 출력

us.state[2]
str(us.state[2])  #데이터프레임으로 출력

us.state[c(2,3)]
str(us.state[c(2,3)])

# 행렬 인덱싱 사용 가능
us.state[,2]
us.state[,2, drop=FALSE]

# 행렬에서는 drop=FALSE 적용시, 출력 결과의 타입이 행렬
# 데이터프레임에서는 drop=FALSE 적용시, 출력 결과의 타입이 데이터 프레임

us.state[,c(2,4)]

us.state[["state.name"]]
us.state$state.name
us.state[,"state.name"]

us.state[c("state.name","state.area")]  #리스트 인덱싱 방식
us.state[,c("state.name","state.area")]  #행렬 인덱싱 방식


id <- c("a1","a2","a3")
price <- c(10,20,30)
name <- c("x","y","z")

product <- data.frame(id,name,price)
product
str(product)

# rbind : 데이터프레임에 행추가
product <- rbind(product, c("a4","40","k"))
product

# 제거
product <- product[-4,]
product

# 다시 정상적인 값 넣기
product <- rbind(product, c("a4","k",40))
product

# 여러 행 추가
new.rows <- data.frame(id=c("a5","a6"),
           name=c("a","b"),
           price=c(50,60))
new.rows

product <- rbind(product, new.rows)
product

str(product)
product$price <- as.numeric(product$price)
str(product)
