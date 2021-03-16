train <- read.csv("day7_practise/train.csv", na.strings = "")
train

# 1. Survived �� ���

summary(train$Survived)

# - ������/����� ��ü ����

# ���1
survivor.ratio <- sum(train$Survived) / nrow(train)
survivor.ratio
death.ratio <- sum(!train$Survived) / nrow(train)
death.ratio

# ���2
table(train$Survived) / nrow(train)


# - ������ ���� ������/����� ��

xtabs(~Sex+Survived, train)




# 2. Pclass �� ���

summary(train$Pclass)

# - ��� ����

# ���1
table(train$Pclass) / nrow(train)

# ���2
xtabs(~Pclass, train) / nrow(train)


# - ��ǿ� ���� ������/����� ����

prop.table(xtabs(~Pclass+Survived, train))




# 3. Age ��
# - ���̴븦 ������ ��, �� ���̴뺰 ������

train$age.cut <- cut(train$Age,
               breaks = c(0,10,20,30,40,50,max(train$Age)+1),
               right = F)
prop.table(xtabs(~age.cut+Survived, train), 2)[,2]



# 4. Fare ��
# - ������ ��ü 5�� �������� �и��� ��, �� ������ ������

train$fare.cut <- cut(train$Fare, breaks = 5)
prop.table(xtabs(~fare.cut+Survived, train), 2)[,2]




# 5. Name �� 
# - ȣĪ�� ������ �̸����� ������ ������ ����

name.words <- strsplit(tolower(gsub(", .*[.]", "", train$Name)), "")

# ����
vowel <- lapply(name.words, 
                grep, 
                pattern = "[a,e,i,o,u]", 
                value = T)
vowel <- lapply(vowel, length)
train$vowel <- unlist(vowel)

# ����
consonant <- lapply(name.words,
                    grep,
                    pattern = "[^a,e,i,o,u]",
                    value = T)
consonant <- lapply(consonant, length)
train$consonant <- unlist(consonant)

proportions(colSums(train[c("vowel","consonant")]))


# - ������ ���� ������ ������ ����

ratio <- with(train, 
              rbind(consonant=tapply(consonant, Sex, sum),
                    vowel=tapply(vowel,Sex, sum)))
ratio
prop.table(ratio, 2)


# 6. Embarked ��
# - �� �¼� �ױ��� ������

prop.table(xtabs(~Embarked+Survived, train), 2)[,2]

# 7. ĳ�� ����
# �Ϸ�!