# 1. mpg 데이터를 이용해서 분석 문제를 해결해 보세요.
mpg <- as.data.frame(ggplot2::mpg)
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA

str(mpg)

# Q1. drv(구동방식)별로 hwy(고속도로 연비) 평균이 어떻게 다른지 
# 알아보려고 합니다. 분석을 하기 전에 우선 두 변수에 결측치가 있는지 
# 확인해야 합니다. drv 변수와 hwy 변수에 결측치가 몇 개 있는지
# 알아보세요.

library(Amelia)
missmap(mpg, col = c('red','grey'))  #hwy에 결측값 존재

sum(is.na(mpg$hwy))  #5


# Q2. filter()를 이용해 hwy 변수의 결측치를 제외하고, 
# 어떤 구동방식의 hwy 평균이 높은지 알아보세요. 
# 하나의 dplyr 구문으로 만들어야 합니다.

library(dplyr)
mpg %>% 
  filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(mean(hwy))

#    drv     `mean(hwy)`
# * <chr>       <dbl>
# 1   4         19.2
# 2   f         28.2
# 3   r          21  

# f(front-wheel drive) > r(rear wheel drive) > 4(4wd) 순으로 높다



# 2. mpg 데이터를 이용해서 분석 문제를 해결해 보세요.
mpg <- as.data.frame(ggplot2::mpg) # mpg 데이터 불러오기
mpg[c(10, 14, 58, 93), "drv"] <- "k" # drv 이상치 할당
mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42) # cty 이상치 할당


# Q1. drv 에 이상치가 있는지 확인하세요. 
# 이상치를 결측 처리한 다음 이상치가 사라졌는지 확인하세요.
# 결측 처리 할 때는 %in% 기호를 활용하세요.

sum(!mpg$drv %in% c("f","r","4",NA))  #4, 이상치가 4개 있음
mpg$drv <- ifelse(mpg$drv %in% c("f","r","4"), mpg$drv, NA)

sum(!mpg$drv %in% c("f","r","4",NA))  #0, 이상치 없음


# Q2. 상자 그림을 이용해서 cty 에 이상치가 있는지 확인하세요.
# 상자 그림의 통계치를 이용해 정상 범위를 벗어난 값을 결측 처리한 후
# 다시 상자 그림을 만들어 이상치가 사라졌는지 확인하세요.

box.cty <- boxplot(mpg$cty)
length(box.cty$out)  #9, 정상범위 벗어난 값 개수
dev.off()

box.cty$stats  #9~26 사이가 정상범위
mpg$cty <- ifelse(mpg$cty>=9 & mpg$cty<=26, mpg$cty, NA)

box.cty <- boxplot(mpg$cty)
length(box.cty$out)  #0
dev.off()

# Q3. 두 변수의 이상치를 결측처리 했으니 이제 분석할 차례입니다.
# 이상치를 제외한 다음 drv 별로 cty 평균이 어떻게 다른지 알아보세요. 
# 하나의 dplyr 구문으로 만들어야 합니다.

missmap(mpg, col = c('red','grey')) #cty와 drv에만 NA 존재

mpg %>% 
  filter(!(is.na(drv)|is.na(cty))) %>% 
  group_by(drv) %>% 
  summarise(mean(cty))

#    drv   `mean(cty)`
# * <chr>       <dbl>
# 1   4         14.2
# 2   f         19.5
# 3   r         14.0



# 3. kmeans를 이용하여 iris 데이터를 3개 그룹으로 나누어보세요

str(iris)
features <- iris[,-5] 

# 표준화

features_z <- as.data.frame(lapply(features, scale))
features_z

# 군집화

set.seed(0311)
iris_clusters <- kmeans(features_z,3)
iris_clusters

iris_clusters$size
# [1] 50 53 47

iris_clusters$centers
# Sepal.Length Sepal.Width Petal.Length Petal.Width
# 1  -1.01119138  0.85041372   -1.3006301  -1.2507035
# 2  -0.05005221 -0.88042696    0.3465767   0.2805873
# 3   1.13217737  0.08812645    0.9928284   1.0141287

iris_clusters$cluster
# [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# [37] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 3 3 3 2 2 2 3 2 2 2 2 2 2 2 2 3 2 2 2 2 3 2
# [73] 2 2 2 3 3 3 2 2 2 2 2 2 2 3 3 2 2 2 2 2 2 2 2 2 2 2 2 2 3 2 3 3 3 3 2 3
# [109] 3 3 3 3 3 2 2 3 3 3 3 2 3 2 3 2 3 3 2 3 3 3 3 3 3 2 2 3 3 3 2 3 3 3 2 3
# [145] 3 3 2 3 3 2

iris_clusters$withinss
# [1] 47.35062 44.08754 47.45019

iris_clusters$tot.withinss
# 138.8884

iris_clusters$betweenss
# 457.1116

iris$Species
iris$Species <- sapply(iris$Species, switch, 
                       "setosa"=1, "versicolor"=2, "virginica"=3)

# 정확도

sum(iris$Species==iris_clusters$cluster) / length(iris$Species) #0.8333333




# 4. snsdata의 결측값을 적절하게 대체하여 kmeans를 적용해보세요

# 1) 결측값 존재하는 열 확인

teens <- read.csv("snsdata.csv")
str(teens)
missmap(teens, col=c("red","gray")) #gender, age열에 결측값 존재
dev.off()

# 2) age열 결측값 처리

# 2-1) 정상범위 외의 값을 가지는 데이터들 삭제

summary(teens$age)  #min과 max의 값이 이상함
box.age <- boxplot(teens$age)
length(box.age$out)  #361, 정상범위 넘어간 개수
box.age$stats  #13.396~21.158이 정상범위

new.teens <- teens %>% 
              filter((age>=13.396 & age<=21.158) | is.na(age))


# 2-2) 같은 졸업연도를 가진 age의 중위수와 평균의 평균으로 결측값 넣기

aggregate(data=new.teens, age~gradyear, mean, na.rm=T)
#    gradyear  age
# 1     2006 18.66807
# 2     2007 17.71148
# 3     2008 16.78087
# 4     2009 15.82594

aggregate(data=new.teens, age~gradyear, median, na.rm=T)
#    gradyear  age
# 1     2006 18.6750
# 2     2007 17.6905
# 3     2008 16.7340
# 4     2009 15.7860

ave_age <- ave(new.teens$age, new.teens$gradyear, 
               FUN = function(x){(mean(x, na.rm=T)+median(x, na.rm=T))/2})
new.teens$age <- ifelse(is.na(new.teens$age), ave_age, new.teens$age)

summary(new.teens$age)  #더 이상 결측값 없음


# 3) gender열 결측값 처리

str(new.teens)
table(new.teens$gender, useNA = "ifany")  #NA 2692

# 연령과 관심사를 통해 gender을 유추해보자(knn)

st.data <- as.data.frame(scale(new.teens[,-c(1:2)]))

na.idx <- which(is.na(new.teens$gender))
na.data <- st.data[na.idx,]  #gender가 NA인 데이터
train <- st.data[-na.idx,]  #gender가 NA아닌 데이터

# train 데이터를 통한 모델링

set.seed(123)
nrow(train)*0.7  #18862.9
tr_idx <- sample(1:nrow(train), 18863)
train_tr <- train[tr_idx,]
train_te <- train[-tr_idx,]

labels <- as.character(new.teens[-na.idx,2])
train_labels <- labels[tr_idx]
test_labels <- labels[-tr_idx]

library(class)
train_te_pred <- knn(train = train_tr,
                     test = train_te,
                     cl = train_labels,
                     k=23)

sum(train_te_pred==test_labels) / length(test_labels)  #정확도 0.8197674

# k=21        k=23       k=24       k=25       k=27      
# 0.8186541   0.8197674  0.8185304  0.81952    0.8198911


# na.data에 모델 적용

na.data_pred <- knn(train = train_tr,
                    test = na.data,
                    cl = train_labels,
                    k=23)

new.teens$gender[na.idx] <- as.character(na.data_pred)
new.teens$gender[na.idx]

table(new.teens$gender, useNA = "ifany")

#   F     M 
# 24446  5193 



# 4) kmeans 적용

# gender 원인핫코딩(연속형 자료로 볼 수 없으므로)

level <- unique(new.teens[[2]]) #"M" "F"
for(j in level){
  new <- paste("gender", j, sep = ".")
  new.teens[new] <- ifelse(new.teens[[2]]==j,1,0)
}


str(new.teens)
features <- new.teens[,-c(1:2)] 
str(features)


# 표준화

features_z <- as.data.frame(lapply(features, scale))
str(features_z)

# 군집화

set.seed(210311)
teens_clusters <- kmeans(features_z,5)
teens_clusters

teens_clusters$size
# [1]   843  1165 17350  5012  5269
teens_clusters$centers
teens_clusters$cluster

teens_clusters$withinss
# [1]  58210.79 211292.66 260625.94 130787.87 358568.34
teens_clusters$tot.withinss  #1019486

teens_clusters$betweenss #166034.4


=======
# 1. mpg 데이터를 이용해서 분석 문제를 해결해 보세요.
mpg <- as.data.frame(ggplot2::mpg)
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA

str(mpg)

# Q1. drv(구동방식)별로 hwy(고속도로 연비) 평균이 어떻게 다른지 
# 알아보려고 합니다. 분석을 하기 전에 우선 두 변수에 결측치가 있는지 
# 확인해야 합니다. drv 변수와 hwy 변수에 결측치가 몇 개 있는지
# 알아보세요.

library(Amelia)
missmap(mpg, col = c('red','grey'))  #hwy에 결측값 존재

sum(is.na(mpg$hwy))  #5


# Q2. filter()를 이용해 hwy 변수의 결측치를 제외하고, 
# 어떤 구동방식의 hwy 평균이 높은지 알아보세요. 
# 하나의 dplyr 구문으로 만들어야 합니다.

library(dplyr)
mpg %>% 
  filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(mean(hwy))

#    drv     `mean(hwy)`
# * <chr>       <dbl>
# 1   4         19.2
# 2   f         28.2
# 3   r          21  

# f(front-wheel drive) > r(rear wheel drive) > 4(4wd) 순으로 높다



# 2. mpg 데이터를 이용해서 분석 문제를 해결해 보세요.
mpg <- as.data.frame(ggplot2::mpg) # mpg 데이터 불러오기
mpg[c(10, 14, 58, 93), "drv"] <- "k" # drv 이상치 할당
mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42) # cty 이상치 할당


# Q1. drv 에 이상치가 있는지 확인하세요. 
# 이상치를 결측 처리한 다음 이상치가 사라졌는지 확인하세요.
# 결측 처리 할 때는 %in% 기호를 활용하세요.

sum(!mpg$drv %in% c("f","r","4",NA))  #4, 이상치가 4개 있음
mpg$drv <- ifelse(mpg$drv %in% c("f","r","4"), mpg$drv, NA)

sum(!mpg$drv %in% c("f","r","4",NA))  #0, 이상치 없음


# Q2. 상자 그림을 이용해서 cty 에 이상치가 있는지 확인하세요.
# 상자 그림의 통계치를 이용해 정상 범위를 벗어난 값을 결측 처리한 후
# 다시 상자 그림을 만들어 이상치가 사라졌는지 확인하세요.

box.cty <- boxplot(mpg$cty)
length(box.cty$out)  #9, 정상범위 벗어난 값 개수
dev.off()

box.cty$stats  #9~26 사이가 정상범위
mpg$cty <- ifelse(mpg$cty>=9 & mpg$cty<=26, mpg$cty, NA)

box.cty <- boxplot(mpg$cty)
length(box.cty$out)  #0
dev.off()

# Q3. 두 변수의 이상치를 결측처리 했으니 이제 분석할 차례입니다.
# 이상치를 제외한 다음 drv 별로 cty 평균이 어떻게 다른지 알아보세요. 
# 하나의 dplyr 구문으로 만들어야 합니다.

missmap(mpg, col = c('red','grey')) #cty와 drv에만 NA 존재

mpg %>% 
  filter(!(is.na(drv)|is.na(cty))) %>% 
  group_by(drv) %>% 
  summarise(mean(cty))

#    drv   `mean(cty)`
# * <chr>       <dbl>
# 1   4         14.2
# 2   f         19.5
# 3   r         14.0



# 3. kmeans를 이용하여 iris 데이터를 3개 그룹으로 나누어보세요

str(iris)
features <- iris[,-5] 

# 표준화

features_z <- as.data.frame(lapply(features, scale))
features_z

# 군집화

set.seed(0311)
iris_clusters <- kmeans(features_z,3)
iris_clusters

iris_clusters$size
# [1] 50 53 47

iris_clusters$centers
# Sepal.Length Sepal.Width Petal.Length Petal.Width
# 1  -1.01119138  0.85041372   -1.3006301  -1.2507035
# 2  -0.05005221 -0.88042696    0.3465767   0.2805873
# 3   1.13217737  0.08812645    0.9928284   1.0141287

iris_clusters$cluster
# [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# [37] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 3 3 3 2 2 2 3 2 2 2 2 2 2 2 2 3 2 2 2 2 3 2
# [73] 2 2 2 3 3 3 2 2 2 2 2 2 2 3 3 2 2 2 2 2 2 2 2 2 2 2 2 2 3 2 3 3 3 3 2 3
# [109] 3 3 3 3 3 2 2 3 3 3 3 2 3 2 3 2 3 3 2 3 3 3 3 3 3 2 2 3 3 3 2 3 3 3 2 3
# [145] 3 3 2 3 3 2

iris_clusters$withinss
# [1] 47.35062 44.08754 47.45019

iris_clusters$tot.withinss
# 138.8884

iris_clusters$betweenss
# 457.1116

iris$Species
iris$Species <- sapply(iris$Species, switch, 
                       "setosa"=1, "versicolor"=2, "virginica"=3)

# 정확도

sum(iris$Species==iris_clusters$cluster) / length(iris$Species) #0.8333333




# 4. snsdata의 결측값을 적절하게 대체하여 kmeans를 적용해보세요

# 1) 결측값 존재하는 열 확인

teens <- read.csv("snsdata.csv")
str(teens)
missmap(teens, col=c("red","gray")) #gender, age열에 결측값 존재
dev.off()

# 2) age열 결측값 처리

# 2-1) 정상범위 외의 값을 가지는 데이터들 삭제

summary(teens$age)  #min과 max의 값이 이상함
box.age <- boxplot(teens$age)
length(box.age$out)  #361, 정상범위 넘어간 개수
box.age$stats  #13.396~21.158이 정상범위

library(dplyr)
new.teens <- teens %>% 
              filter((age>=13.396 & age<=21.158) | is.na(age))


# 2-2) 같은 졸업연도를 가진 age의 중위수와 평균의 평균으로 결측값 넣기

aggregate(data=new.teens, age~gradyear, mean, na.rm=T)
#    gradyear  age
# 1     2006 18.66807
# 2     2007 17.71148
# 3     2008 16.78087
# 4     2009 15.82594

aggregate(data=new.teens, age~gradyear, median, na.rm=T)
#    gradyear  age
# 1     2006 18.6750
# 2     2007 17.6905
# 3     2008 16.7340
# 4     2009 15.7860

ave_age <- ave(new.teens$age, new.teens$gradyear, 
               FUN = function(x){(mean(x, na.rm=T)+median(x, na.rm=T))/2})
new.teens$age <- ifelse(is.na(new.teens$age), ave_age, new.teens$age)

summary(new.teens$age)  #더 이상 결측값 없음


# 3) gender열 결측값 처리

str(new.teens)
table(new.teens$gender, useNA = "ifany")  #NA 2692

# 연령과 관심사를 통해 gender을 유추해보자(knn)

st.data <- as.data.frame(scale(new.teens[,-c(1:2)]))

na.idx <- which(is.na(new.teens$gender))
na.data <- st.data[na.idx,]  #gender가 NA인 데이터
train <- st.data[-na.idx,]  #gender가 NA아닌 데이터

# train 데이터를 통한 모델링

set.seed(123)
nrow(train)*0.7  #18862.9
tr_idx <- sample(1:nrow(train), 18863)
train_tr <- train[tr_idx,]
train_te <- train[-tr_idx,]

labels <- as.character(new.teens[-na.idx,2])
train_labels <- labels[tr_idx]
test_labels <- labels[-tr_idx]

library(class)
train_te_pred <- knn(train = train_tr,
                     test = train_te,
                     cl = train_labels,
                     k=23)

sum(train_te_pred==test_labels) / length(test_labels)  #정확도 0.8197674

# k=21        k=23       k=24       k=25       k=27      
# 0.8186541   0.8197674  0.8185304  0.81952    0.8198911


# na.data에 모델 적용

na.data_pred <- knn(train = train_tr,
                    test = na.data,
                    cl = train_labels,
                    k=23)

new.teens$gender[na.idx] <- as.character(na.data_pred)
new.teens$gender[na.idx]

table(new.teens$gender, useNA = "ifany")

#   F     M 
# 24446  5193 



# 4) kmeans 적용

# gender 원핫인코딩(연속형 자료로 볼 수 없으므로)

level <- unique(new.teens[[2]]) #"M" "F"
for(j in level){
  new <- paste("gender", j, sep = ".")
  new.teens[new] <- ifelse(new.teens[[2]]==j,1,0)
}


str(new.teens)
features <- new.teens[,-c(1:2)] 
str(features)


# 표준화

features_z <- as.data.frame(lapply(features, scale))
str(features_z)

# 군집화

set.seed(210311)
teens_clusters <- kmeans(features_z,5)
teens_clusters

teens_clusters$size
# [1]   843  1165 17350  5012  5269
teens_clusters$centers
teens_clusters$cluster

teens_clusters$withinss
# [1]  58210.79 211292.66 260625.94 130787.87 358568.34
teens_clusters$tot.withinss  #1019486

teens_clusters$betweenss #166034.4




######

# k 정하기

# sqrt(n/2), n:데이터 건수

nrow(teens)
sqrt(nrow(new.teens) / 2)
#121.7354, 121보다 작은 수로 k값 설정


# elbow 포인트 찾기

visual <- NULL
for(i in 2:10) {
  set.seed(0312)
  result <- kmeans(features_z, i)
  visual[i] <- result$tot.withinss
}
plot(visual[-1], type="l", ylab="", xlab="", main="cluster의 개수에 따른 내부분산")
abline(v=7,col="red")

set.seed(0312)
teens_clusters <- kmeans(features_z,7)
teens_clusters

teens_clusters$size
# [1] 16720  5266   931   840  4962   443   477
teens_clusters$centers
teens_clusters$cluster

teens_clusters$withinss
# [1] 221267.24 319242.39 172073.54  56647.95 109375.52  31055.73  62090.46
teens_clusters$tot.withinss  #971752.8

teens_clusters$betweenss  #213767.2

