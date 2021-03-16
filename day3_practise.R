# 1. 다음 리스트에서 A를 a로 변경하시오
lst <- list(c(3,5,7),c("A","B","C"))
lst[[2]] <- letters[1:3]
lst



# 2. 다음 리스트는 중간고사 및 기말고사 점수이다. 
# 중간고사 평균, 기말고사 평균, 전체 평균을 계산하시오
lst <- list(math=list(95,90),eng=list(80,90),kor=list(85,80))
lst

mid.test <- (lst$math[[1]] + lst$eng[[1]] + lst$kor[[1]]) / 3
mid.test
last.test <- (lst$math[[2]] + lst$eng[[2]] + lst$kor[[2]]) / 3
last.test
all.test <- (mid.test + last.test) / 2
all.test



# 3. 다음은 1월~12월까지 월평균 기온이다.
temp.lst <- list(-2.4, 0.4, 5.7, 12.5, 17.8, 22.2, 24.9, 25.7, 21.2, 14.8, 7.2, 0.4)
# 1) 월 이름(Jan~Dec)을 지정한 리스트를 만드시오.
names(temp.lst) <- month.abb
temp.lst

# 2) 0도 미만인 월을 추출하시오
names(temp.lst[temp.lst<0])

# 3) 연평균 기온보다 작은 월을 추출하시오.
avrg <- mean(unlist(temp.lst))
names(temp.lst[temp.lst<avrg])

# 4) 연평균 기온보다 큰 월을 리스트에서 제거하시오.
temp.lst[temp.lst>avrg] <- NULL
temp.lst


# 4. 리스트 list(a=1, b=2)와 벡터 pi를 결합하여 새로운 리스트를 생성하고,
# 생성한 리스트에서 pi를 추출하시오.
# 1) 새로운 리스트 생성
lst <- list(a=1, b=2)
lst[3] <- list(pi)
lst
# 2) 새로운 리스트에서 pi 추출
lst[[3]]

# 다른 방법1
lst <- list(a=1, b=2)
lst['c'] <- pi
lst
# 다른 방법2
lst <- list(a=1, b=2)
lst$d <- pi
lst

# 5. 1. 행렬 X가 다음과 같이 정의되도록 R로 작성하라.
#    c1 c2 c3
# r1  1  4  7
# r2  2  5  8
# r3  3  6  9
# ① matrix() 함수를 이용하라.
mtx <- matrix(1:9, 3, 3, dimnames = list(c("r1","r2","r3"), c("c1","c2","c3")))

# ② cbind()와 rbind() 함수를 이용하라.
# 1) cbind()
mtx2 <- cbind(c1=1:3,c2=4:6,c3=7:9)
rownames(mtx2) <- c("r1","r2","r3")
mtx2
# 2) rbind()
mtx3 <- rbind(r1=c(1,4,7),r2=c(2,5,8),r3=c(3,6,9))
colnames(mtx3) <- c("c1","c2","c3")
mtx3

# ③ dim() 함수를 이용하라.
v <- 1:9
dim(v) <- c(3,3)
v
rownames(v) <- c("r1","r2","r3")
colnames(v) <- c("c1","c2","c3")
v

# 6. 앞 문제의 행렬 X에 대해 다음을 알아내는 방법을 R로 답하라.
# ① 행과 열의 개수
nrow(mtx)
ncol(mtx)

# ② 행벡터 및 열벡터의 이름
df.mtx <- as.data.frame(mtx)
rownames(df.mtx)
colnames(df.mtx)

# ③ 원소의 개수
length(mtx)




# 7. 다음 두 행렬 A, B에 대해 물음에 답하라.
a <- matrix(c(1,4,1,0,1,2), 2, byrow=T)
b <- rbind(c(1,0,1),c(-1,1,-1))
a
b

# ① A+B, A-B, B*A, B/A
a+b
a-b
b*a
b/a

# ② 행렬 A의 2행 벡터를 c(1,2,1)로 치환하라.
a[2,] <- c(1,2,1)
a

# ③ 행렬 B의 1열 벡터와 2열 벡터를 교환하라.
b[,c(1,2)] <- b[,c(2,1)]
b

# ④ 행렬 A의 2행을 제거하라.
a <- a[-2,]
a

# ⑤ 행렬 B에서 1보다 작은 원소를 0으로 치환하라.
b[b<1] <- 0
b



# 8. 행렬과 배열(array)의 차이점을 말하고, 3×2×3 배열의 예를 하나 만들어보아라.

# 행렬과 배열의 차이점은 배열은 행렬과 달리 차원을 속성값으로 가진다는 것이다
array(1:18, c(3,2,3))



# 9. 다음과 같은 번호(ID), 성명(name), 성적(score)를 성분으로 하는 리스트가 있다.
# 물음에 답하라.
L <- list(ID=c(1,2,3),
          name=c('Kim', 'Lee', 'Park'),
          score=c(80, 95, 75))
L
# ① length(L)은 얼마이며, 이것은 무엇을 의미하는가?
length(L)  #리스트의 최대 인덱스 즉, 리스트 내용의 개수

# ② 이름 성적 75을 80으로 수정하라.
L[["score"]][[3]] <- 80
L

# ③ L$name=='Park'의 결과를 쓰고, 무엇을 의미하는지 설명하라.

# 결과 : [1] FALSE FALSE  TRUE
# L 리스트에 이름이 "name"인 요소들이 'Park'인지 참거짓을 묻는 명령을 내림
# 결과적으로 'Park'인 세번째 자료만 TRUE고 나머지는 FALSE


# ④ L$score[L$name=='Park']의 결과를 쓰고, 문장이 무엇을 의미하는지 설명하라.

# 결과 : [1] 80
# L 리스트에 이름이 "name"인 요소에서 값이 'Park'인 자료의 "score" 값을 출력하라

# ⑤ 1번 학생의 이름과 성적을 알아내는 문장을 만들어 보아라.
L$name[L$ID == 1]
L$score[L$ID == 1]
 



# 10. 다음의 표를 데이터프레임으로 작성해 보아라.
# id	age	sex 	height	weight
# 1	21	'남'	175	80
# 2	22	'여'	165	55
# 3	31	'여'	155	45
# 4	40	'여'	160	50

id <- 1:4
age <- c(21,22,31,40)
sex <- c("남","여","여","여")
height <- c(175,165,155,160)
weight <- c(80,55,45,50)
data.frame(id,age,sex,height,weight)

# 11. 다음 데이터를(자료구조는 자유선택) 저장한 후, 유클리디안 거리를 활용하여 
# 손흥민과 가장 유사하게 평점을 준(거리가 가까운) 사람의 이름과 거리를 
# 출력하시오.
# critics={
# 'BTS':{'밀정':5, '경이로운소문':4, '국제시장':1.5},
# '손흥민':{'밀정':4,'경이로운소문':5, '국제시장':2},
# '레드벨벳':{'밀정':2.5, '경이로운소문':2, '국제시장':1},
# '트와이스':{'밀정':3.5, '경이로운소문':4, '국제시장':5}
# }

# 방법1
BTS <- c(5,4,1.5)
Son <- c(4,5,2)
Red <- c(2.5,2,1)
Twc <- c(3.5,4,5)
data <- data.frame(BTS,Red,Twc)
data
rownames(data) <- c("밀정","경이로운소문","국제시장")
data

res <- sqrt(colSums((data-Son)^2))
res

min(res)

# 방법2
data <- rbind(BTS,Son,Red,Twc)
data

data.euclid <- dist(data, method = "euclidean")
data.euclid

min(data.euclid)

# 방법3
BTS <- c(5,4,1.5)
Son <- c(4,5,2)
Red <- c(2.5,2,1)
Twc <- c(3.5,4,5)
sqrt(sum((Son - BTS)^2))

# 만약, 평점 범위가 다음과 같다면?
# 0~5 : 밀정과 경이로운 소문
# 0~100 : 국제시장
# 크게 다른 경우에는 표준화 또는 정규화 작업을 해줘서
# rescaling 한다!


# 각 영화별로 정규화 작업 수행
# 정규화 : 0 <= (각각의 평점 - 최소값) / (최대값 - 최소값) <= 1






