

# curve()
# curve(함수 또는 표현식, 시작점, 끝점)

curve(sin, 0, 2*pi)


## cars 데이터의 선형회귀 -> 신뢰구간 출력 ##

# 1. 선형회귀
# 1) lm()
# lm( , ) 종속변수(y)~독립변수(x)
# 절편      기울기       <- 이런식으로 결과출력

m <- lm(dist~speed, cars)
m

# 2) abline()
# m에서 얻은 절편과 기울기로 그래프 그림

plot(cars)
abline(m)

# 2. 신뢰구간
# 1) predict() : 회귀모델예측값과 신뢰구간 출력

p <- predict(m, interval = "confidence")
p
# fit : 회귀모델로 적합된 값
# lwr : 신뢰구간의 하한
# upr : 신뢰구간의 상한

#       fit        lwr       upr
# 1  -1.849460 -12.329543  8.630624

# -1.849460은 cars의 첫번째 데이터 speed 4에 
# 대한 dist 예측값이다.


# 2) polygon()
# polygon(x, y, col = rgb(r색상, g색상, b색상, 투명도))

tail(cars$speed,1) #25
rev(cars$speed)  #[1] 25 24 24 24 24 23 22 20 ... 이런식으로 speed 값을 뒤집은 순서로 만든것

x <- c(cars$speed, tail(cars$speed,1), rev(cars$speed), cars$speed[1])
y <- c(p[,"lwr"], tail(p[,"upr"],1), rev(p[,"upr"]), p[,"lwr"][1])

polygon(x,y,col = rgb(.7, .7, .7, .2))
dev.off()


# 데이터값 점 옆에 표현하고 싶을 때 : pos=

plot(cars, cex=0.5)
text(cars$speed, cars$dist, pos=1, cex = .5)  # 점 아래
text(cars$speed, cars$dist, pos=2, cex = .5)  # 점 왼쪽
text(cars$speed, cars$dist, pos=3, cex = .5)  # 점 위에
dev.off()


# 내가 찍은 점들의 값을 알고 싶을 때
# identify()

plot(cars, cex = 0.5)
identify(cars$speed, cars$dist)
dev.off()



## iris 데이터 표현해보기 ##

# 1. 산점도로 표현하기

plot(iris$Sepal.Width, iris$Sepal.Length,
     cex = .5,
     pch = 20,
     xlab = "width",
     ylab = "length")

points(iris$Petal.Width, iris$Petal.Length,
       cex = .5,
       pch = "+",
       col = "#ff0000")

legend("topright", 
       legend = c("Sepal","Petal"),
       pch = c(20, 43),
       cex = .8,
       col = c("black", "red"),
       bg = "gray")

dev.off()



# 2. boxplot으로 표현하기

boxstats <- boxplot(iris$Sepal.Width)
boxstats

# $stats
#      [,1]
# [1,]  2.2   #lower whisker
# [2,]  2.8   #whisker
# [3,]  3.0   #median
# [4,]  3.3   #whisker
# [5,]  4.0   #upper whisker

# $out
# [1] 4.4 4.1 4.2 2.0    #out liner

# 만약, boxplot 가로로 눞히고 싶다면 horizontal=T
boxplot(iris$Sepal.Width, horizontal = TRUE)

dev.off()



# 3. 히스토그램으로 그리기
# hist()

hist(iris$Sepal.Length)

# 막대 구간설정 : breaks =
# defualt 값 : breaks="Sturges"
# Sturges = log2(n)+1, n은 자료의 개수
# 현재 iris는 150개의 데이터 있음
# log2(150)+1 = 8이므로 막대그래프가 8개가 그려지도록 구간이 나눠짐


hist(iris$Sepal.Length, freq = F)
# freq=F : 히스토그램의 면적을 다 더하면 1이되도록 y가 수정됨

x <- hist(iris$Sepal.Length, freq = F)
x

# $breaks    # 구간 단위
# [1] 4.0 4.5 5.0 5.5 6.0 6.5 7.0 7.5 8.0
# $counts    # 구간별 자료 개수
# [1]  5 27 27 30 31 18  6  6

dev.off()


# 4. 밀도 그래프

plot(density(iris$Sepal.Width))


hist(iris$Sepal.Width, freq=F)
lines(density(iris$Sepal.Width))


dev.off()



# 5. 막대그래프
# barplot()

barplot(tapply(iris$Sepal.Width, iris$Species, mean))

dev.off()


# 6. 데이터 비율 : pie 그래프

####  참고사항 : cut()  ####
cut(1:10, c(0,5,10))
# 구간을 2개로 나눔 : (0,5], (5,10]

cut(1:10, breaks = 3)
# 구간을 3개로 나눔 : (0.991,4] (4,7] (7,10]

############################

cut(iris$Sepal.Width, breaks = 10)

table(cut(iris$Sepal.Width, breaks = 10))
pie(table(cut(iris$Sepal.Width, breaks = 10)), 
    cex=.7)

dev.off()




## ggplot2 <- 시각화 할 때 많이 쓰임

library(ggplot2) #grammar of graphics의 약자;gg

# 1층 배경
# 2층 그래프(막대, 선, ...)
# 3층 범위, 색상 등 설정

ggplot(data = mtcars,
       aes(x=wt, y=mpg))

ggplot(data = mtcars,
       aes(x=wt, y=mpg))+
    geom_point()

ggplot(data = mtcars,
       aes(x=wt, y=mpg))+
    geom_point()+
    labs(title = "mytitle",
         x="weight",
         y="mpg")

# 주의사항 : data= 자리에는 data.frame 형식이 들어간다

dev.off()




mtcars$gear  #vector 타입
mtcars$gear <- factor(mtcars$gear,
                      levels = c(3,4,5),
                      labels = c("3 gears","4 gears","5 gears"))

mtcars$cyl <- factor(mtcars$cyl,
                      levels = c(4,6,8),
                      labels = c("4 cylinders","6 cylinders","8 cylinders"))

ggplot(data = mtcars,
       aes(x=mpg))+
    geom_histogram()+
    facet_grid(cyl ~ .)


ggplot(data = mtcars,
       aes(x=mpg))+
    geom_histogram()+
    facet_grid(cyl ~ .)+
    labs(title = "cyl vs mpg")


ggplot(data = mtcars,
       aes(x=cyl, y=mpg))+
    geom_boxplot()+
    labs(x="cyl", y="mpg")



ggplot(data = mtcars,
       aes(x=mpg, fill=cyl))+
    geom_density()+
    labs(x="mpg")

