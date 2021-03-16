# 1. for문으로 다음과 같이 월 이름을 출력
# The month of January
# ...
# The month of December

paste("The month of", month.name)



# 2. 짝수이면 TRUE, 홀수이면 FALSE를 출력하는 함수 작성.
# 다음 벡터로 테스트하시오.

myfunc <- function(x){
  return(x%%2==0)
}
myfunc(-5:5)


# 3. 짝수 개수를 세는 함수 작성.
# 다음 벡터로 테스트하시오.

myfunc2 <- function(x){
  return(sum(x%%2==0))
}
myfunc2(-5:5)



# 4. 주어진 숫자가 원주율보다 크면 TRUE, 
# 아니면 FALSE를 출력하는 함수 작성.
# 3과 1:5 벡터에 대해 테스트하시오

myfunc3 <- function(x){
  return(x>pi)
}
myfunc3(3)
myfunc3(1:5)



# 5. 주어진 그림과 같은 데이터프레임을 생성하여
# df_midterm에 저장하시오

english <- c(90,80,60,70)
math <- c(50,60,100,20)
class <- c(1,1,2,2)
df_midterm <- data.frame(english, math, class)
df_midterm

# - 각 과목별 평균을 구하시오.

apply(df_midterm[,-3], 2, mean)

# - 각 번호별 평균을 구하시오.

apply(df_midterm[1:4,-3], 1, mean)


# 6. 2~99까지 수에 대해

n2 <- 2:99
n2

# - 3의 배수에 해당하는 수의 합계를 구하시오.

sum(n2[n2%%3==0])

# - 3의 배수에 해당하는 수의 개수를 구하시오.

sum(n2%%3==0)



# 7. 임의의 수 n을 전달받아, n!을 출력하는 함수를 완성하시오.
# (n>=2, 5!=5*4*3*2*1)

fun.fac <- function(x){
  if(x>=2){
    prod(x:1)
  }
}

fun.fac(1) #1
fun.fac(2) #2
fun.fac(5) #120(=5*4*3*2*1)

# factorial 구하는 함수도 있다

factorial(4)



 
# 8. 반복문을 이용하여 구구단을 출력하시오

# for문으로 풀기

for(i in 2:9)
    print(i * 1:9)

# while문으로 풀기

i <- 2
while(i<=9){
  print(i*1:9)
  i <- i+1
}

# repeat문으로 풀기

i <- 2
repeat{if(i>9)break
  else{
    print(i*1:9)
    i <- i+1
  }
}

 
# 9. 반복문을 활용하여 출력하시오
#    *
#   ***
#  *****
# *******


# while문으로 풀기

i <- 1
while(i<=9){
  blk <- (7-i)/2
  x <- paste(rep("*", each=i), collapse = "")
  y <- paste(rep(" ", each=blk), collapse = "")
  print(paste(y, x, sep = ""))
  i <- i+2
}

# for문으로 풀기

for(i in seq(from=1, to=7, by=2)){
  star <- paste(rep("*", times=i), collapse = "")
  blank <- paste(rep(" ", times=(7-i)/2), collapse = "")
  print(paste(blank, star))
}



#   10.  타이타닉 데이터 전처리
# - train.csv 파일 읽을 때 "" 는 na로 처리하시오.

train <- read.csv("day7_practise/train.csv", header = TRUE, na.strings = "")
train

# - Surived 컬럼의 타입을 확인하시오.

mode(train$Survived)  #numeric
str(train$Survived)  #int

# - Survived 컬럼의 타입을 factor 타입으로 바꾸어 저장하시오

train$Survived <- as.factor(train$Survived)
str(train$Survived)  #Factor


