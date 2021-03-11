# 정렬 : sort(), order()
# sort() : 데이터가 정렬된 결과
# order() : 데이터 크기의 색인을 출력

v1 <- c(20,10,50,40,30)
v2 <- c(300,200,100,700,600)
v3 <- c("a","b","b","a","b")
df <- data.frame(v1,v2,v3)
df

# sort()
# 오름차순
sort(v1)
# 내림차순
sort(v1,decreasing = TRUE)

# order()
# 오름차순 정렬했을 때, 색인 값을 추출
v1
order(v1)

v1[order(v1)]


# 차이점
# sort함수는 데이터 프레임에서는 사용못함
# order함수는 데이터 프레임 정렬에서 사용가능

df

# 오름차순
order(v1)
order(v2)
order(v3)

# 내림차순
order(-v2)

df[order(v1),]
v1

v1 <- c(20,10,50,40,20)
v2 <- c(300,200,100,700,600)
v3 <- c("a","b","b","a","b")
df <- data.frame(v1,v2,v3)
df

df[order(v1,-v2,v3),]



install.packages("plyr")
library(plyr)
arrange(df, v1)
arrange(df, v1, desc(v2), v3)




sort(letters, decreasing = TRUE)







# 텍스트마이닝(text mining)
# -> 베이지안(베이즈 이론 기반) 필터 이메일 분류기(햄/스팸)
# 하지만 성능은 좋지 않은 편


# nchar와 length 함수
x <- "We have a dream"
# 문자 길이(공백문자도 하나의 문자로 취급)
nchar(x)
# 문자 벡터의 벡터 길이(원소의 개수가 1개)
length(x) #1

y <- c("We", "have", "a", "dream")
length(y) #4

y[4]
nchar(y[4]) #5
length(y[4]) #1

nchar(y)  #2 4 1 5, 각 자료마다의 길이 출력


# 대소문자 변환
x <- "We have a dream"
# 소문자
tolower(x)
# 대문자
toupper(x)



# 텍스트 분리/합침
x <- "We have a dream"
# 분리 : strsplit
strsplit(x, split = " ")  # 공백으로 구분하겠다
class(strsplit(x, split = " "))
# 각각의 단어들로 구성된 벡터가 리스트에 저장된 형태로 출력

strsplit(x, split="")
# strsplit 결과가 리스트로 저장

# 리스트 -> 벡터 : unlist
unlist(strsplit(x, split = " "))


res <- strsplit(x, split = " ")[[1]]
res
res[4]


x1 <- "We have a dream"
x2 <- "How are you"
x3 <- "I am fine"

myword <- c(x1,x2,x3)
myword
length(myword)

strsplit(myword, split = " ")
# 하나의 문자 벡터를 클래스로 두고 그 아래에 해당 문자를 split한 결과 넣어놓음

strsplit(myword, " ")

strsplit(myword, " ")[[3]]

strsplit(myword, " ")[[3]][3]


# 대소문자 구분됨(what What WHAT WhaT ... 을 모두 다르게 생각)

said <- "WHAT IS ESSENTIAL is invisible to the Eye"
said.word <- strsplit(said, " ")

# unique() : 유일한 단어를 추출
unique(said.word)  #제대로 작동안하고 클래스 그대로 추출

unique(said.word[[1]])

unique(tolower(said.word[[1]]))





# 자연어 -> sql
# 우리 회사에서 직급이 대리인 사람의 이름을 모두 출력해라
# => SELECT name FROM company WHERE 직급 = '대리'




# 문자 결합 : paste()
paste("Everybody","wants","to","fly")

paste(c("Everybody","wants","to","fly"))
# 이경우는 안됨.
# c("Everybody","wants","to","fly")는 1개의 벡터이다.
# paste는 분리된 벡터를 결합하는 함수이다.
# 벡터의 원소들을 분리한 다음 결합하지 않으므로 주의한다.



said <- "WHAT IS ESSENTIAL is invisible to the Eye"

strsplit(said, " ")  #리스트 형태

res <- strsplit(said, " ")[[1]]
paste(res)  #벡터 1개가 들어갔으므로 마찬가지로 제대로 작동 안함


# 연결 기본값 : 공백문자자
paste("Everybody","wants","to","fly")
# 연결할 때 특별한 값 쓰고싶은 경우 : sep
paste("Everybody","wants","to","fly", sep="-")
paste("Everybody","wants","to","fly", sep="")

paste(pi, sqrt(pi))
# 텍스트가 아닌 경우에는 모두 텍스트로 변환한 다음 -> 결합 수행

paste("aaa",1+2,"bbb")
# 1+2의 결과 3이 문자열로 변경된 후 paste 함수 수행

heroes <- c("Batman", "Captain America", "Hulk")
colors <- c("Black", "Blue", "Green")
paste(colors,heroes)
# 벡터를 인수로 준 경우에는 요소간 결합

paste("type",1)

paste("type",1:5)
# c("type")이 길이가 1이었는데 길이 5로 변경된다음 paste 진행
# c("type","type","type","type","type")

paste(heroes, "wants")
paste(heroes, "wants", "to")

paste(c("Everybody","wants","to","fly"))

# paste함수 collapse 옵션
# : 텍스트 결험을 통해 생성된 텍스트들을 다시 하나로 연결하는 구분자 정의

paste(c("Everybody","wants","to","fly"), collapse = " ")





heroes <- c("Batman", "Captain America", "Hulk")
paste(c("Everybody","wants","to","fly"), collapse = " ")
# 위의 내용을 기반으로 
# Batman wants to fly, and Captain America wants to fly, and Hulk wants to fly
# 출력을 만들어보자.
paste(heroes, "wants", "to", "fly")
paste(heroes, "wants", "to", "fly", collapse = ", and ")

# 위의 내용을 기반으로 
# Batman-wants-to-fly;Captain America-wants-to-fly;Hulk-wants-to-fly
# 출력을 만들어보자.
paste(heroes, "wants", "to", "fly", sep="-", collapse = ";")



# outer : 두 집합에 대해 가능한 모든 순서쌍의 곱을 수행
# 카티전 곱
outer(c(1,2,3), c(3,2,1))

# outer + paste 함수를 결합해서 문자열 생성 가능
# outer 함수의 3번째 자리에 인수자리에 함수를 작성하여
# 모든 순서쌍에 대해 카티전곱이 아닌 다른 작업을 수행할수 있게됨

asia.countries <- c("Korea","China","India")
info <- c("GDP","Population","Area")
out <- outer(asia.countries, info, FUN = paste, sep="-") #행렬형식
out

# as.vector() : 행렬 -> 벡터형식
as.vector(out)

res <- outer(asia.countries, asia.countries, FUN = paste, sep="-")
res

# 행렬의 하삼각 추출 : lower.tri
lower.tri(res)

res[lower.tri(res)]

!lower.tri(res)  # !이 not의 의미이므로 거꾸로된 결과 나옴

res[!lower.tri(res)]



# substr : 텍스트의 특정부분 문자열 추출
substr("Data Analytics", 1, 4)
substr("Data Analytics", 6, 14)

# substring:텍스트의 특정부분 문자열 추출, 끝위치 생략
substring("Data Analytics", 6)
substring("Data Analytics", 6, 10)


myclass <- c("Data Analytics", "Data Mining", "Data Visualization")
myclass
substr(myclass, 1, 4)

substr(myclass, nchar(myclass)-5, nchar(myclass))




islands
class(islands)

landmasses <- names(islands)
landmasses

# grep
# New 문자열이 포함된 단어의 인덱스를 추출
index <- grep(pattern = "New", x=landmasses)
index
landmasses[index]

grep(pattern = "New", x=landmasses, value = TRUE)


# 문제
# 두 개 이상의 단어로 이루어진 대륙 또는 섬을 출력
grep(pattern = " ", x=landmasses, value = TRUE)
# 혹은 
landmasses[grep(pattern = " ", x=landmasses)]



# sub(), gsub() 함수 : 문자열 검색 -> 다른 문자열로 변경
# sub : 처음 문자열 1개만 다른 문자열 변경
# gsub : 일치하는 모든 문자열을 다른 문자열로 변경

txt <- "Data Anal is useful. Data Anal is interesting"
sub(pattern = "Data", replacement = "Business", x=txt)
gsub(pattern = "Data", replacement = "Business", x=txt)


x <- c("input.csv", "data.csv", "big.csv")
gsub(pattern = ".csv", replacement = "", x=x)


# finance.yahoo.com > samsung > history

df <- read.csv("005930.KS.csv", header = TRUE, sep = ",")
df


df2 <- read.csv("005930.KS.csv")
df2

# df와 df2가 동일한 결과를 보이고 있다.
# header = TRUE, sep = ","가 디폴트값이기 때문

# header = TRUE라고 주는 것은 열 이름이 없다는 의미!
df3 <- read.csv("005930.KS.csv", header = FALSE, sep = ",")
df3

class(df)  #dataframe 형태

