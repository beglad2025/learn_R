# 코퍼스(corpus) : 특정 도메인에 관련된 단어 집합, 언어 모델 생성
# 언어 모델은 코퍼스로부터 생성된 모델(분류,예측)
# ex) 아~ 나 이 영화 봤는데, 졸려서 혼났어. => 언어모델 => 부정
# ex) 뉴스 기사 중 '손흥민 선수가 골을 넣었습니다' => 언어모델 => 스포츠뉴스
# ex) 유가가 급등하였습니다... => 언어모델 => 오늘/내일 주가(환율...) 예측


# 문자열 대체 : grep,

# grep 함수
# fixed 성질
# 기본값 : fixed=false
# : pattern에 작성된 식을 정규표현식으로 해석
# fixed=TRUE
# : pattern에 작성된 값을 문자열로 취급하게 된다


# 정규표현식이 포함된 문자열 추출
words <- c("at","bat","cat","cheap","cheese","click","hat","chase","check","chick")
grep("che", words, value=TRUE)
grep("at", words, value=TRUE)
# c 또는 h가 포함된 문자열 검색
grep("[ch]", words, value=TRUE)
# ch 또는 at가 포함된 문자열 검색
grep("ch|at", words, value = TRUE)

# ch + e 또는 i + ck
grep("ch(e|i)ck", words, value = TRUE)

# ? => ? 앞의 문자가 0번 또는 1번 나타나는 패턴(최소 1번)
# * => * 앞의 문자가 0번 이상 반복되는 패턴(최소 0번)
# + => + 앞의 문자가 1번 이상 반복되는 패턴(최소 1번)


words <- c("at","bat","cat","cheap","check", "cheese","chick",
           "hat","chase", "chaenomeles", "chasse")
grep("chas?e", words, value = TRUE)
grep("chas*e", words, value = TRUE)
grep("chas+e", words, value = TRUE)

# chase, cheese
grep("ch(a*|e*)se", words, value = TRUE)
# c로 시작
grep("^c", words, value = TRUE)
# t로 끝
grep("t$", words, value = TRUE)


# . : 모든 문자
# .* : 모든 문자가 0개 이상

# c로  시작하고 t로 끝나는 모든 문자열 검색
grep("^c.*t$", words, value = TRUE)

# at앞에 아무 문자도 없거나 h 또는 c로 시작하는 문자열 검색
grep("^[hc]?at", words, value = TRUE)



words2 <- c("12 Dec", "OK", "http://", "<TITLE>Time?</TITLE>","12345", "Hi there")

# [[:alnum:]] : 알파벳+숫자
# [[:digit:]] : 숫자
# [[:punct:]] : 문장부호, 특수문자
# [[:space:]] : 공백
# [[:alpha:]] :  알파벳


grep("[[:alnum:]]", words2, value = TRUE)
grep("\\w", words2, value = TRUE)

grep("[[:alpha:]]", words2, value = TRUE)

grep("[[:digit:]]", words2, value = TRUE)
grep("\\d", words2, value = TRUE)

grep("[[:punct:]]", words2, value = TRUE)

grep("[[:space:]]", words2, value = TRUE)
grep("\\s", words2, value = TRUE)

# help창에 regex를 입력하면 정규표현식에 대해 더 알 수 있다





# 날짜 데이터
Sys.Date()
date()
Sys.time()

class(Sys.Date())  #"Date"

class("2021-02-26")  #"character"


# as.Date() : 문자열 -> 날짜 변환
class(as.Date("2021-02-26"))

as.Date("02/26/2021") #error : 기본형식이 아니기 때문
# 기본형식 : 년도4자리-월2자리-일2자리
# 기본형식이 아닌 경우에는 format 지정해야함
as.Date("02/26/2021", format="%m/%d/%Y")


d <- as.Date("2021-02-26")
format(d, format="%m/%d/%Y")
class(format(d, format="%m/%d/%Y"))  #"character"


today <- Sys.Date()
today
format(today, format="%Y/%m/%d %A")  #%A는 요일

# 특정일의 요일이 알고 싶을 때때
weekdays(as.Date("2021-02-27"))

d <- as.Date("2021-02-27")
d-1
d+1:10

weekdays(d+1:10)


# seq : 연속된 날짜 생성
s <- as.Date("2021-02-26")
e <- as.Date("2021-04-01")
seq(from=s, to=e, by=1)
seq(s,e,1)

seq(from=s, by=1, length.out=10)

seq(from=s, by=7, length.out=9)
seq(from=s, by="7 days", length.out=9)
seq(from=s, by="week", length.out=9)

seq(from=s, by="month", length.out=9)
seq(from=s, by="2 month", length.out=9)

seq(from=s, by="year", length.out=9)
seq(from=s, by="2 year", length.out=9)

seq(from=as.Date("2021-01-30"), by="month", length.out=5)
# 2월에 대한 별도 처리가 필요하다
# 2월은 28일 혹은 29일까지 밖에 없어서 위와 같이 명령할 경우
# 2021-03-02가 출력되기 때문이다.


s <- as.Date("2021-02-26")
qrt <- seq(from=s, by="3 months", length.out=4)
qrt

months(qrt)  # 월에 대한 정보보
quarters(qrt)  # 분기에 대한 정보


# 입력
product <- data.frame()
product

product <- edit(product)  #fix(product)와 같은 문장
product
str(product)


write.csv(product, file = "myproduct.csv", row.names = FALSE)
# 행번호 없애고 싶은 경우 row.names=FALSE

# myproduct파일에서 내용을 드래그 하고 ctrl + c 하면
# 클립보드라는 임시저장소에 들어간다.
# readClipboard() : 클립보드에 있는 내용 가져오기
p <- readClipboard()
p
# myproduct 파일에서 작성된 모든 내용을 드래그 해서 가져오면
# \tname 이런식으로 \t가 포함되어 나온다

p <- read.table(file="clipboard", sep="\t", header = TRUE)
p
# 이렇게 하면 dataframe 형식으로 가져올 수 있다
class(p)




