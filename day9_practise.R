train <- read.csv("day7_practise/train.csv", na.strings = "")
train

# 1. Survived 열 요약

summary(train$Survived)

# - 생존자/사망자 전체 비율

# 방법1
survivor.ratio <- sum(train$Survived) / nrow(train)
survivor.ratio
death.ratio <- sum(!train$Survived) / nrow(train)
death.ratio

# 방법2
table(train$Survived) / nrow(train)


# - 성별에 따른 생존자/사망자 수

xtabs(~Sex+Survived, train)




# 2. Pclass 열 요약

summary(train$Pclass)

# - 등실 비율

# 방법1
table(train$Pclass) / nrow(train)

# 방법2
xtabs(~Pclass, train) / nrow(train)


# - 등실에 따른 생존자/사망자 비율

prop.table(xtabs(~Pclass+Survived, train))




# 3. Age 열
# - 나이대를 구분한 후, 각 나이대별 생존율

train$age.cut <- cut(train$Age,
               breaks = c(0,10,20,30,40,50,max(train$Age)+1),
               right = F)
prop.table(xtabs(~age.cut+Survived, train), 2)[,2]



# 4. Fare 열
# - 운임을 전체 5개 구간으로 분리한 후, 각 구간별 생존율

train$fare.cut <- cut(train$Fare, breaks = 5)
prop.table(xtabs(~fare.cut+Survived, train), 2)[,2]




# 5. Name 열 
# - 호칭을 제외한 이름에서 자음과 모음의 비율

name.words <- strsplit(tolower(gsub(", .*[.]", "", train$Name)), "")

# 모음
vowel <- lapply(name.words, 
                grep, 
                pattern = "[a,e,i,o,u]", 
                value = T)
vowel <- lapply(vowel, length)
train$vowel <- unlist(vowel)

# 자음
consonant <- lapply(name.words,
                    grep,
                    pattern = "[^a,e,i,o,u]",
                    value = T)
consonant <- lapply(consonant, length)
train$consonant <- unlist(consonant)

proportions(colSums(train[c("vowel","consonant")]))


# - 성별에 따른 자음과 모음의 비율

ratio <- with(train, 
              rbind(consonant=tapply(consonant, Sex, sum),
                    vowel=tapply(vowel,Sex, sum)))
ratio
prop.table(ratio, 2)


# 6. Embarked 열
# - 각 승선 항구별 생존율

prop.table(xtabs(~Embarked+Survived, train), 2)[,2]

# 7. 캐글 가입
# 완료!