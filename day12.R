# graphics 패키지 : 고수준 그래픽 함수, 저수준 그래픽 함수
# 고수준 그래픽 함수 : 완전한 하나의 그래프 생성
# ex) plot(), boxplot(), hist(), crve(), ...
# 저수준 그래픽 함수 : 독자적으로 그래프 생성 불가능
#                      완성된 그래프에 요소를 첨가하는 역할
# ex) points(), lines(), abline(), text(), polygon(), ...

faithful

plot(faithful) #산점도
# 분출시간(eruptions)이 길어질수록 대기시간(waiting) 또한 길어진다라는 관계 패턴이 보임

# 클러스터(cluster) : 집단
# 지금 plot(faithful)로 생성한 산점도에서는 집단이 크게 2개가 되는 것으로 보임

eruptions.long <- faithful %>% filter(eruptions>3)
eruptions.long

points(eruptions.long, col="red", pch=19)
# 원을 나타내는 pch가 19이다

# 그래프 창 닫기
dev.off()

# 만약 그래프가 닫힌 상태에서 저수준인 points 함수를 실행시키면 error가 나타난다


# 선형회귀 모델 : lm
# 작성방법 : lm(종속변수~독립변수, data= )

faithful.lm <- lm(waiting~eruptions, data=faithful)
# 분출시간(eruptions)에 따라 대기시간(waiting)의 변화가 어떠한지

faithful.lm

# y=wx+b
# w:기울기, b:y절편
# Coefficients:
#   (Intercept)    eruptions  
# 33.47        10.73 
# 절편         기울기
# waiting = 10.73*x+33.47

# fitted : 회귀 모델에서 예측값 추출

plot(faithful)
points(eruptions.long, col="red", pch=19)
fitted(faithful.lm)


# 회귀선
lines(x=faithful$eruptions,y=fitted(faithful.lm),col="blue")

abline(v=3, col="purple")
abline(h=mean(faithful$waiting),col="green")

# y=ax+b

faithful.lm

coef(faithful.lm)

coef(faithful.lm)[1]
coef(faithful.lm)[2]

abline(a=coef(faithful.lm)[1], b=coef(faithful.lm)[2], col="blue")
abline(faithful.lm, col="blue")



# plot(x) : x타입에 따라 시각화 결과가 달라짐
# x의 타입 : 벡터, 데이터 프레임, 팩터, 시계열, 테이블, 선형회귀 모델

#1 x타입 : 벡터인 경우

cars
str(cars)
cars$speed #벡터
cars$dist #벡터

# 벡터이므로 산점도 그래프로 출력됨
plot(cars$speed, cars$dist) #산점도
#혹은
plot(cars)


#2 x타입 : 팩터인 경우

ToothGrowth
str(ToothGrowth)
ToothGrowth$len #벡터(num)
ToothGrowth$supp #펙터
ToothGrowth$dose #벡터(num)

plot(ToothGrowth$supp, ToothGrowth$len)

# 첫번째 인수가 펙터이므로 boxplot으로 출력
# x축에 펙터 오고 y축에 len(벡터) 왔다


# https://towardsdatascience.com/understanding-boxplots-5e2df7bcbd51


str(iris)
plot(iris[,1:4])
# plot함수로 시각화 할 때, 변수가 2개를 초과하는 경우에는 
# 산점도 '행렬'로 생성



nhtemp
str(nhtemp) #Time-Series
plot(nhtemp)
# 시계열 그래프로 출력


UCBAdmissions
str(UCBAdmissions)  #table

# 성별과 허가여부에 따른 그래프 출력
plot(UCBAdmissions)
# 테이블 데이터는 모자이크 도표로 출력
# 모자이크 조각의 크기로 교차표의 상대적 빈도 확인


plot(faithful)
png("myplot.png")
png("myplot.png", width = 800, height = 400)
plot(faithful)
dev.off()

windows()
plot(faithful)
savePlot("imgplot.pdf", type="pdf")


windows()
plot(faithful)
savePlot("imgplot.png", type="png")


windows()
png("imgplot2.png", width=600, height=400)
plot(faithful)





# knn 사용 사례
# - 컴퓨터비전
# - 추천시스템(영화, 음악 등등)
# - 질병 분류, 유전자 데이터 패턴 인식

# 장점
# 쉽다, 훈련과정이 빠르다, 데이터 분포에 대한 가정을 하지 않는다

# 단점
# k값?, 분류작업이 느리다, 직관적이지 않다(데이터를 이해하기가 어렵다)

# https://ko.wikipedia.org/wiki/K-%EC%B5%9C%EA%B7%BC%EC%A0%91_%EC%9D%B4%EC%9B%83_%EC%95%8C%EA%B3%A0%EB%A6%AC%EC%A6%98





#https://archive.ics.uci.edu/ml/datasets.php


# 머신러닝 - knn 알고리즘을 이용한 암 분류기 제작

wbcd <- read.csv("wisc_bc_data.csv")
str(wbcd)


# id는 사용하지 않으므로 제거

wbcd <- wbcd[-1]
str(wbcd)
table(wbcd$diagnosis)

wbcd$diagnosis <- factor(wbcd$diagnosis, 
                         levels = c("B","M"), 
                         labels = c("Benign", "Malignant"))
str(wbcd)

round(prop.table(table(wbcd$diagnosis))*100,1)

summary(wbcd["radius_mean"])

summary(wbcd[c("radius_mean","area_mean","smoothness_mean")])

# 정규화작업(표준화와 달리 따로 함수가 존재하지 않음)

normalize <- function(x){
  return ((x-min(x))/(max(x)-min(x)))
}

normalize(c(10,20,30,40,50))

lapply(wbcd[2:31], normalize)  # 결과가 list형식으로 나옴

wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))
wbcd_n

wbcd_train <- wbcd_n[1:469,]
wbcd_test <- wbcd_n[470:559,]

wbcd_train_labels <- wbcd[1:469,1]
wbcd_train_labels
wbcd_test_labels <- wbcd[470:569,1]
wbcd_test_labels

# 모델 생성

library(class)
wbcd_test_pred <- knn(train=wbcd_train, 
                      test=wbcd_test,
                      cl=wbcd_train_labels,
                      k=21)

wbcd_test_pred #예측결과

wbcd_test_labels # 정답

# cross table
install.packages("gmodels")
library(gmodels)
CrossTable(x=wbcd_test_labels, y=wbcd_test_pred)




# 표준화

wbcd_z <- as.data.frame(scale(wbcd[-1]))
summary(wbcd_z$area_mean)

wbcd_train <- wbcd_n[1:469,]
wbcd_test <- wbcd_n[470:559,]

wbcd_test_pred <- knn(train=wbcd_train, 
                      test=wbcd_test,
                      cl=wbcd_train_labels,
                      k=21)

CrossTable(x=wbcd_test_labels,y=wbcd_test_pred)


# k값에 대해 변화를 주면서 가장 테스트 정확도가 높았을 때 k값?
# k : 1~25(2씩 증가)




k_res <- c()
for (i in seq(from=1,to=25,by=2)){
  wbcd_test_pred<-knn(train=wbcd_train,
                      test=wbcd_test,
                      cl=wbcd_train_labels,
                      k=i)
  k_res <- c(k_res, sum(wbcd_test_labels==wbcd_test_pred))
}

best_k <- which.max(k_res)*2-1
best_k









