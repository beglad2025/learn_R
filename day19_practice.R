# 1. cars 데이터에서 임의의 속도가 입력되었을 때,
# 예상되는 제동거리를 출력하는 회귀모델 작성

data("cars")
cars

# 속도와 제동거리

plot(cars$speed, cars$dist,
     xlab="속도",
     ylab="제동거리",
     main="속도에 따른 제동거리")

cars_model <- lm(dist ~ speed, cars)
cars_model
summary(cars_model)
# (Intercept)        speed  
#     -17.579        3.932
# Multiple R-squared:  0.6511

abline(cars_model$coefficients, col="red")


# (속도)^2 와 제동거리

cars$speed_sqr <- (cars$speed)^2
cars$speed_sqr

dev.off()
plot(cars$speed_sqr, cars$dist,
     xlab="(속도)^2",
     ylab="제동거리",
     main="(속도)^2에 따른 제동거리")

cars_model2 <- lm(dist ~ speed_sqr, cars)
cars_model2
summary(cars_model2)
# (Intercept)    speed_sqr  
#     8.860        0.129  
# Multiple R-squared:  0.6659
# R-squared 증가(정확도 증가)

abline(cars_model2$coefficients, col = "red")


# 예측: 속도 80일 때, 제동거리
cars_dist <- function(x){
  predict(cars_model2, data.frame(speed_sqr=x))
}

cars_dist(80)  
#  cars_model   cars_model2
#   297.0136      19.17754


# 2. marketing 데이터에서 (70:30의 비율, 트레이닝/테스트)
# 유튜브, 페이스북, 신문, 데이터가 입력되었을 때, 
# 예상되는 sales?
# 시각화(꺽은선 그래프, 실제값과 예측값을 다른 색상으로 시각화)

marketing
str(marketing)

plot(marketing$sales, (marketing$youtube)^2)
plot(marketing$sales, log(marketing$facebook))
plot(marketing$sales, log(marketing$newspaper))

set.seed(0318)
test_idx <- sample(1:nrow(marketing), nrow(marketing)*0.3)
train <- marketing[-test_idx,]
test <- marketing[test_idx,-4]
testLabels <- marketing[test_idx,4]

# R-squared를 기준으로 비교하였다

# 경우1
marketing_model <- lm(sales ~ youtube+facebook+newspaper, train)
marketing_model
summary(marketing_model)
# (Intercept)      youtube     facebook    newspaper  
#   3.3895560    0.0455636    0.1898665    0.0002188  
# Multiple R-squared:  0.8905
# Adjusted R-squared:  0.8881

# 경우2
marketing_model <- lm(sales ~ log(youtube)+facebook+newspaper, train)
marketing_model
summary(marketing_model)
# (Intercept)  log(youtube)      facebook     newspaper  
# -12.037969      4.766736       0.209464     -0.001286   
# Multiple R-squared:  0.9054
# Adjusted R-squared:  0.9033

# 경우3
marketing_model <- lm(sales ~ log(youtube)+facebook+log(newspaper), train)
marketing_model
summary(marketing_model)
# (Intercept)    log(youtube)        facebook  log(newspaper)  
# -11.5659          4.7823             0.2116         -0.1984  
# Multiple R-squared:  0.9062
# Adjusted R-squared:  0.9041

str(test)  #data.frame
testPred <- predict(marketing_model, test)

dev.off()
plot(1:nrow(test), testLabels,
     cex = .8, type = "o", col = "red", pch=20,
     main = "실제값과 예측값 비교",
     xlab = "",
     ylab = "sales")
lines(1:nrow(test), testPred,
      cex = .8,type = "o", col = "blue", pch=43)
legend("topright", 
       legend = c("Labels","Pred"),
       pch = c(20, 43),
       cex = .8,
       col = c("red", "blue"))





