# 1. Happy, Birthday, to, you로 구성된 텍스트 벡터 생성하시오
txt <- c("Happy", "Birthday", "to", "you")

# -벡터의 길이 
length(txt)

# -문자 개수의 합
sum(nchar(txt))



# 2. 1번 문제 벡터를 모두 연결하시오 ("Happy Birthday to you")
txt2 <- paste(txt, collapse = " ")

# - 텍스트 벡터의 길이
length(txt2)
# - 문자 개수의 합을 출력하시오
nchar(txt2)



# 3. patse함수와 LETTERS 상수 벡터를 이용하여 다음 문자 벡터 생성하시오
# - "A 1" "B 2" "C 3" "D 4" "E 5"
paste(LETTERS[1:5], 1:5, sep = " ")

# -" A1" "B2" "C3" "D4" "E5"
paste(LETTERS[1:5], 1:5, sep = "")


 
# 4. 단어 단위로 분할하고, 모든 쉼표와 하이픈은 제거하시오.
txt3 <- c("Yesterday is history,", "That's, why we call it the present - from Kung")
txt3 <- gsub(pattern = ",", replacement = "", x=txt3)
txt3 <- gsub(pattern = " -", replacement = "", x=txt3)
txt3 <- strsplit(txt3, split = " ")
txt3



# 5. 주민번호 뒤 일곱 자리 수를 *로 모두 대체하시오
socialnum <- c("110101-1234123", "950102-2121212")
socialnum <- unlist(strsplit(socialnum, split = "-"))
socialnum[c(2,4)] <- "*******"
new.socialnum <- c(paste(socialnum[1:2], collapse = "-"), paste(socialnum[3:4], collapse = "-"))
new.socialnum



# 6. paste함수와 month.abb를 결합하여 "Jan_1-Feb_2- ... Dec_12"를 생성하시오
paste(month.abb, "_", 1:12, sep = "", collapse = "-")



# 7. read.csv(file="samsung.csv")
samsung <- read.csv("005930.KS.csv", header = TRUE, sep = ",")
samsung

# 1) Open, High, Low, Close, Adj.Close, Volume 열을 추출
ss.open <- samsung$Open
ss.open
ss.high <- samsung$High
ss.high
ss.low <- samsung$Low
ss.low
ss.close <- samsung$Close
ss.close
ss.adj.close <- samsung$Adj.Close
ss.adj.close
ss.volume <- samsung$Volume
ss.volume

# 2) 각 열에 대해 최소값, 최대값, 평균, 표준편차 출력
apply(samsung[,-1], 2, function(x){min(x, na.rm = T)})
apply(samsung[,-1], 2, function(x){max(x, na.rm = T)})
apply(samsung[,-1], 2, function(x){mean(x)})
apply(samsung[,-1], 2, function(x){sd(x)})


# 3) 각 열에 대해 정규화 / 표준화
# 정규화
apply(samsung[,-1], 2, function(x){(x-min(x, na.rm = T))/(max(x, na.rm = T)-min(x, na.rm = T))})
# 표준화
apply(samsung[,-1], 2, function(x){(x-mean(x, na.rm=T))/sd(x, na.rm = T)})

# 4) Low 열과 High 열 각각에 대해 최대 낙차 출력
# - High 열 최대 낙차 =  Max(High(n-1)-High(n))  here, n은 특정일을 의미
apply(samsung[,3:4], 2, function(x){max(x[1:nrow(samsung)-1]-x[2:nrow(samsung)])})
