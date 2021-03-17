# 3.각 문서간 코사인 유사도(6개) -> 최대값에 해당되는 문서쌍을 출력
# 코퍼스
# 문서1:먹고 싶은 사과
# 문서2:먹고 싶은 바나나
# 문서3:길고 노란 바나나 바나나
# 문서4:저는 과일이 좋아요

library(tm)


# 데이터 생성

d <- c("doc1","doc2","doc3","doc4")
text <- c("먹고 싶은 사과","먹고 싶은 바나나",
          "길고 노란 바나나 바나나","저는 과일이 좋아요")

fruit <- as.data.frame(cbind(d, text))
str(fruit)

fruitCorpus <- VCorpus(VectorSource(fruit$text))
fruitCorpus
lapply(fruitCorpus[1:4], as.character)

# $`1`
# [1] "먹고 싶은 사과"
# $`2`
# [1] "먹고 싶은 바나나"
# $`3`
# [1] "길고 노란 바나나 바나나"
# $`4`
# [1] "저는 과일이 좋아요"

# tf(d,t) 구하기 (DTM 활용)

fruitDtm <- DocumentTermMatrix(fruitCorpus, control = list(wordLengths=c(2, Inf)))
inspect(fruitDtm[,])

# Terms
# Docs 과일이 길고 노란 먹고 바나나 사과 싶은 저는 좋아요
# 1      0    0    0    1      0    1    1    0      0
# 2      0    0    0    1      1    0    1    0      0
# 3      0    1    1    0      2    0    0    0      0
# 4      1    0    0    0      0    0    0    1      1

fruitMatrix <- as.matrix(fruitDtm)
fruitDf <- as.data.frame(fruitMatrix)


# df(t) 구하기

df_t <- apply(fruitDf, 2, FUN = function(x){sum(x != 0)})
df_t

# 과일이   길고   노란   먹고 바나나   사과   싶은   저는 좋아요 
#   1      1      1      2      2      1      2      1      1 

# idf(d,t) 구하기

n <- nrow(fruitDf)
idf <- log(n / (1 + df_t))
idf

#   과일이      길고      노란      먹고    바나나      사과      싶은      저는    좋아요 
# 0.6931472 0.6931472 0.6931472 0.2876821 0.2876821 0.6931472 0.2876821 0.6931472 0.6931472 


# tfidf

tfidf <- fruitDf * idf
tfidf

#     과일이      길고      노란      먹고    바나나      사과      싶은      저는    좋아요
# 1 0.0000000 0.0000000 0.0000000 0.2876821 0.0000000 0.6931472 0.2876821 0.0000000 0.0000000
# 2 0.0000000 0.0000000 0.0000000 0.2876821 0.6931472 0.0000000 0.6931472 0.0000000 0.0000000
# 3 0.0000000 0.2876821 0.6931472 0.0000000 1.3862944 0.0000000 0.0000000 0.0000000 0.0000000
# 4 0.2876821 0.0000000 0.0000000 0.0000000 0.0000000 0.0000000 0.0000000 0.2876821 0.6931472

# tfidf로부터 코사인 유사도 구하기

len_d <- apply(tfidf, 1, FUN = function(x){sqrt(sum(x^2))})
len_d


fruitCos <- function(x,y){
  round((sum(tfidf[x,] * tfidf[y,])) / (len_d[x] * len_d[y]),3)
}

res <- NULL
for(i in 1:4){
  for(j in 1:4){
    res <- c(res, fruitCos(i,j))
  }
}
res

dim(res) <- c(4,4)
res <- as.data.frame(res)
colnames(res) <- d
rownames(res) <- d
res

#       doc1  doc2  doc3 doc4
# doc1 1.000 0.344 0.000    0
# doc2 0.344 1.000 0.597    0
# doc3 0.000 0.597 1.000    0
# doc4 0.000 0.000 0.000    1



# DTM 진행 직후에 코사인 유사도 구해보기

fruitDf

len_d <- apply(fruitDf, 1, FUN = function(x){sqrt(sum(x^2))})
len_d


fruitCos2 <- function(x,y){
  round((sum(fruitDf[x,] * fruitDf[y,])) / (len_d[x] * len_d[y]),3)
}

res2 <- NULL
for(i in 1:4){
  for(j in 1:4){
    res2 <- c(res2, fruitCos2(i,j))
  }
}
res2

dim(res2) <- c(4,4)
res2 <- as.data.frame(res2)
colnames(res2) <- d
rownames(res2) <- d
res2

#       doc1  doc2  doc3 doc4
# doc1 1.000 0.667 0.000    0
# doc2 0.667 1.000 0.471    0
# doc3 0.000 0.471 1.000    0
# doc4 0.000 0.000 0.000    1
