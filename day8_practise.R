# 1. mtcars데이터 weight열 추가, 
# 무게가 중위수보다 큰 자동차는 heavy,
# 그렇지 않은 자동차는 light를 저장
# - 각 종류별 데이터 건수 출력, 비율

data(mtcars)

cars.med <- median(mtcars$wt)
mtcars$weight <- ifelse(mtcars$wt > cars.med, "heavy", "light")
mtcars

table(mtcars$weight)
summary(mtcars)

table(mtcars$weight) / nrow(mtcars)

# 2. mtcars 데이터셋 열들이 왼쪽에서 오른쪽으로 오름차순으로 배치되도록 작성

mtcars[do.call(order, mtcars),]

# 의도는 이름의 오름차순으로 배열해보라는 말이었음

mtcars[order(names(mtcars))]



# 3. iris데이터에서 70% 데이터를 무작위 표본추출

data(iris)
set.seed(1)
idx <- sample(1:nrow(iris), nrow(iris)*0.7)
iris[idx,]




# 4. ggplot2 패키지에는 미국 동북중부 437개 지역의 인구통계 정보를 담은 
# midwest라는 데이터가 포함되어 있음. 
# midwest 데이터를 사용하여,
# 불러오기 : midwest<-as.data.frame(ggplot2::midwest)

ggplot2::midwest
midwest <- as.data.frame(ggplot2::midwest)

# - ggplot2 의 midwest 데이터를 데이터 프레임 형태로 불러와서
# 데이터의 특성을 파악

str(midwest)
summary(midwest)
head(midwest)
tail(midwest)
View(midwest)
dim(midwest)

# - poptotal(전체 인구)을 total 로, 
# popasian(아시아 인구)을 asian 으로 변수명을 수정

library(dplyr)
midwest <- rename(midwest, total=poptotal)
midwest <- rename(midwest, asian=popasian)
names(midwest)

# - total, asian 변수를 이용해 
# '전체 인구 대비 아시아 인구 백분율' 파생변수 생성
# 특성공학(feature engineering) : 파생변수 생성

midwest$asian.perc <- (midwest$asian / midwest$total) * 100
midwest

hist(midwest$asian.perc)

# - 아시아 인구 백분율 전체 평균을 구하고, 
# 평균을 초과하면 "large", 
# 그 외에는 "small"을 부여하는 파생변수 생성

asian.perc.m <- mean(midwest$asian.perc)
midwest$size <- ifelse(midwest$asian.perc>asian.perc.m, "large", "small")
midwest

# - "large"와 "small"에 해당하는 지역이 얼마나 되는지 빈도수를 출력

table(midwest$size)



# 5. 타이타닉 데이터 분석
# -타이타닉 데이터 불러오기

train <- read.csv("day7_practise/train.csv", na.strings = "")
str(train)

# - 생존자 수, 사망자 수 출력

num.survivor <- sum(train$Survived==1)
num.survivor

num.death <- sum(train$Survived==0)
num.death

# 다른 방법

sum(train$Survived)
sum(!train$Survived)

# - pclass, embarked 별 승객수 출력(비율)

pclass.table <- as.data.frame(table(train$Pclass))
colnames(pclass.table) <- c("pclass","num")
pclass.table$ratio <- round((pclass.table$num / nrow(train)), digits = 3)
pclass.table

embarked.table <- as.data.frame(table(train$Embarked))
colnames(embarked.table) <- c("embarked","num")
embarked.table$ratio <- round((embarked.table$num/nrow(train)), digits = 3)
embarked.table


# 다른 방법

sum(ifelse(train$Pclass==1, proportions(train$Survived),0))
sum(ifelse(train$Pclass==2, proportions(train$Survived),0))
sum(ifelse(train$Pclass==3, proportions(train$Survived),0))


# prop.table()

mydata <- matrix(sample(100,15), ncol=3)
colnames(mydata) <- LETTERS[seq(1,3)]
mydata
rownames(mydata) <- sprintf("s-%d", seq(5))
mydata

prop.table(mydata)
sum(prop.table(mydata))  #1
library(dplyr)
prop.table(mydata) %>% sum  #1



# 행 기준으로 비율 구한 것

prop.table(mydata, 1)

# 열 기준으로 비율 구한 것

prop.table(mydata, 2)


rowSums(prop.table(mydata, 1))
prop.table(mydata, 1) %>% rowSums

colSums(prop.table(mydata, 2))
prop.table(mydata, 2) %>% colSums



# proportions()

proportions(train$Survived)
proportions(train$Embarked)

table(train$Survived)
proportions(train$Survived)


# - Name에서 호칭 종류 출력, 호칭 종류 별 승객수 출력

train$Name
name.words <- unlist(strsplit(train$Name, split = " "))
name.words <- grep("^[[:alpha:]][[:alpha:]]+[.]$", name.words, value = TRUE)
name.words
table(name.words)


# 다른 방법
lst <- unlist(strsplit(train$Name, split=" "))
lst
grep(".{2,}\\.$", lst, value=T)


# - 호칭을 아래와 같이 변경하여 name2열에 추가
# * "Mlle", "Ms", "Lady", "Dona" 는 "Miss"로 변경
# * "Mme"는  "Mrs"로 변경
# * "Capt", "Col", "Major", "Dr", "Rev", "Don",  
# "Sir", "the Countess", "Jonkheer"는 "Officer"로 변경
# * "Mr", "Mrs", "Miss"는 그대로
# * 나머지 호칭은 "Others"

name.words <- gsub(pattern = "Mlle|Ms|Lady|Dona", 
                   replacement = "Miss",
                   x = name.words)
name.words <- gsub(pattern = "Mme",
                   replacement = "Mrs",
                   x = name.words)
name.words <- gsub(pattern = "Capt|Col|Major|Dr|Rev|Don|Sir|Countess|Jonkheer",
                   replacement = "Officer",
                   x = name.words)
name.words <- gsub(pattern = "Master",
                   replacement = "Others",
                   x = name.words)
train$name2 <- name.words
train



# -name2 열을 factor로(5가지 범주) 변환

train$name2 <- factor(train$name2)
str(train)

# -name2열의 호칭별 인원수 출력

table(train$name2)

# -호칭 정보를 바탕으로 나이(Age) 결측값 대체(호칭 별 나이의 평균값)

ageMr.m <- round(mean(na.omit(train$Age[train$name2=="Mr."])), digits = 0)
ageMiss.m <- round(mean(na.omit(train$Age[train$name2=="Miss."])), digits = 0)
ageMrs.m <- round(mean(na.omit(train$Age[train$name2=="Mrs."])), digits = 0)
ageOfficer.m <- round(mean(na.omit(train$Age[train$name2=="Officer."])), digits = 0)
ageOthers.m <- round(mean(na.omit(train$Age[train$name2=="Others."])), digits = 0)

train$Age[train$name2=="Mr." & is.na(train$Age)] <- ageMr.m
train$Age[train$name2=="Miss." & is.na(train$Age)] <- ageMiss.m
train$Age[train$name2=="Mrs." & is.na(train$Age)] <- ageMrs.m
train$Age[train$name2=="Officer." & is.na(train$Age)] <- ageOfficer.m
train$Age[train$name2=="Others." & is.na(train$Age)] <- ageOthers.m
train$Age


lev <- levels(factor(train$name2))
for(i in 1:length(lev)){
  mean.age <- mean(train$Age[train$name2==lev[i]],na.rm=T)
  train$Age[train$name2==lev[i]&is.na(train$Age)] <- mean.age
}


# -age열의 구간별 인원수 출력
# 10대 미만, 10대, 20대, 30대, 40대, 50대 이상

sum(train$Age<10)
sum(train$Age>=10 & train$Age<20)
sum(train$Age>=20 & train$Age<30)
sum(train$Age>=30 & train$Age<40)
sum(train$Age>=40 & train$Age<50)
sum(train$Age>=50)

# cut 함수로도 사용 가능

age.cut <- cut(train$Age,
               breaks = c(0,10,20,30,40,50,max(train$Age)+1),
               right = F)
table(age.cut)



# - cabin 컬럼의 1번째 글자 출력(NA는 제외)

train.cabin <- unlist(strsplit(na.omit(train$Cabin), split = ""))
train.cabin.f <- grep(pattern = "[[:alpha:]]", train.cabin, value = TRUE)
table(train.cabin.f)


# 다른 방법
substr(train$Cabin,1,1)
na.omit(substr(train$Cabin,1,1))




# - fare열 값에 대해 최대/최소/평균/표준편차 출력

max(train$Fare)
min(train$Fare)
mean(train$Fare)
sd(train$Fare)


# - sibsp + parch를 더하여 새롭게 family열에 저장

train$family <- train$SibSp + train$Parch
train[c("SibSp","Parch","family")]
