# 1. 시험 점수 변수 만들고 출력하기
# 다섯 명의 학생이 시험을 봤습니다.
# 학생 다섯 명의 시험 점수를 담고 있는 변수를 만들어 출력해 보세요. 각
# 학생의 시험 점수는 다음과 같습니다.

score <- c(A=80, B=60, C=70, D=50, E=90)
score



# 2. 전체 평균 구하기
# 앞 문제에서 만든 변수를 이용해서 이 학생들의 전체 평균 점수를 구해보세요.

mean(score)



# 3. 전체 평균 변수 만들고 출력하기
# 전체 평균 점수를 담고 있는 새 변수를 만들어 출력해 보세요.
# 앞 문제를 풀 때 사용한 코드를 응용하면 됩니다.

mean.score <- mean(score)
mean.score


# 4. data.frame()과 c()를 조합해서 표의 내용을 데이터 프레임으로 만들어 출력해보세요.
# 제품 가격 판매량
# 사과 1800 24
# 딸기 1500 38
# 수박 3000 13

제품 <- c("사과", "딸기", "수박")
가격 <- c(1800, 1500, 3000)
판매량 <- c(24, 38, 13)
fruit <- data.frame(제품, 가격, 판매량)
fruit



# 5. 앞에서 만든 데이터 프레임을 이용해서
# 과일 가격 평균, 판매량 평균을 구해보세요
apply(fruit[,-1], 2, mean)




# 6. mpg 데이터의 변수명은 긴 단어를 짧게 줄인 축약어로 되어있습니다. 
# cty 변수는 도시 연비, hwy 변수는고속도로 연비를 의미합니다. 
# 변수명을 이해하기 쉬운 단어로 바꾸려고 합니다. 
# mpg 데이터를 이용해서 아래 문제를 해결해 보세요.

# • Q1. ggplot2 패키지의 mpg 데이터를 사용할 수 있도록
# 불러온 뒤 복사본을 만드세요.

library(ggplot2)
mpg.copy <- as.data.frame(mpg)
mpg.copy

# • Q2. 복사본 데이터를 이용해서 cty는 city로,
# hwy는 highway로 변수명을 수정하세요.

# 방법1
names(mpg.copy)[names(mpg.copy)=="cty"] <- "city"
names(mpg.copy)[names(mpg.copy)=="hwy"] <- "highway"
names(mpg.copy)

# 방법2
library(dplyr)
mpg.copy <- rename(mpg.copy, city=cty)
mpg.copy <- rename(mpg.copy, highway=hwy)
names(mpg.copy)


# • Q3 자동차 배기량에 따라 고속도로 연비가 다른지 알아보자
# - displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중
# 어떤 자동차의 hwy(연비)가 평균적으로 높은가?

comp.displ <- c(mean(mpg.copy$highway[mpg.copy$displ <= 4]), 
               mean(mpg.copy$highway[mpg.copy$displ >= 5]))
names(comp.displ) <- c("배기량 4이하", "배기량 5이상")
names(comp.displ)[comp.displ==max(comp.displ)]



# • Q5. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보자. 
# -"audi"와 "toyota" 중 어느 manufacturer의 cty가
# 평균적으로 높은지 알아 보자.

comp.mnf <- c(mean(mpg.copy$city[mpg.copy$manufacturer=="audi"]),
              mean(mpg.copy$city[mpg.copy$manufacturer=="toyota"]))
names(comp.mnf) <- c("audi", "toyota")
names(comp.mnf)[comp.mnf==max(comp.mnf)]




# • Q6. 자동차 종류에 따라 도시 연비가 다른지 알아보자. 
# - class가 "suv"인 자동차와 "compact"인 자동차 중 
# 어떤 자동차의 cty가 더 높은지 알아보자.

comp.clss <- c(mean(mpg.copy$city[mpg.copy$class=="suv"]),
               mean(mpg.copy$city[mpg.copy$class=="compact"]))
names(comp.clss) <- c("suv", "compact")
names(comp.clss)[comp.clss==max(comp.clss)]




# 7. ggplot2 패키지에는 미국 동북중부 437개 지역의 인구통계 
# 정보를 담은 midwest라는 데이터가 포함되어있습니다.
# midwest 데이터를 사용해 데이터 분석 문제를 해결해보세요.

# • 문제 1. ggplot2 의 midwest 데이터를 데이터 프레임 형태로 
# 불러와서 데이터의 특성을 파악하세요.

midwest.copy <- as.data.frame(midwest)
str(midwest.copy)


# • 문제 2. poptotal(전체 인구)을 total 로, 
# popasian(아시아 인구)을 asian 으로 변수명을 수정하세요.

library(dplyr)
midwest.copy <- rename(midwest.copy, total=poptotal)
midwest.copy <- rename(midwest.copy, asian=popasian)
names(midwest.copy)


# • 문제 3. 아시아 인구 백분율 전체 평균을 구하고, 
# 평균을 초과하면 "large", 그 외에는 "small"을 부여하는
# 파생변수를 만들어 보세요

popul.per <- midwest.copy$asian / midwest.copy$total
mean.asian <- mean(popul.per)

midwest.copy$popul.per <- "large"
midwest.copy$popul.per[popul.per <= mean.asian] <- "small"
midwest.copy


 
# 8. 햄릿 데이터 파일을 읽은 후 다음 작업을 진행하시오.

hamlet <- readLines("Hamlet.txt")
hamlet

# • 문제 1. ******로 시작하고 ******로 끝나는 문자열 추출

grep("^[*]{6}.+[*]{6}", hamlet, value=TRUE)


# • 문제 2. 대문자로 시작되는 단어들만 추출 
# -> 단어별 빈도수 출력

hamlet.words <- unlist(strsplit(hamlet, " "))
upper.words <- grep("^[[:upper:]]", hamlet.words, value = TRUE)
upper.words <- gsub(pattern = "[[:punct:]]", replacement = "", x=upper.words)
upper.words <- factor(upper.words)
table(upper.words)

# • 문제 3. 대괄호([ 또는 ])로 묶여있는 문자열 출력

bracket <- grep("^[[,(].*[],)]$", hamlet.words, value = TRUE)
bracket

# • 문제 4. 모든 단어를 소문자로 변환 
# -> 가장 빈도수가 높은 단어 50개 출력

lower.words <- tolower(hamlet.words)
lower.words <- grep("^[[:alpha:]]+$", lower.words, value=TRUE)
sort(table(lower.words), decreasing = TRUE)[1:50]


# • 문제 5. Ham. ->Hamlet. 으로 치환

new.words <- gsub(pattern = "Ham.", replacement = "Hamlet.", x=hamlet)
new.words


# • 문제 6. Scene 으로 시작되는 문자열 출력

grep("^(Scene)", hamlet, value = TRUE)


# 9. 2021년 2월 27일부터 7일간 월, 일, 요일을 출력
# "토-0227" "일-0228" ...install.packages("ggplot2")

date <- as.Date("2021-02-27")
week <- seq(from=date, by=1, length.out=7)
day <- format(week, format="%A-%m%d")
day
