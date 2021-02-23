# 1. 변수 x에 1~10까지 값 할당, y에 3~1까지 값 할당
# - letters 상수벡터를 이용하여 x에 알파벳 소문자 이름 부여
# - x+y를 수행하고 결과를 설명
x <- c(1:10)
y <- c(3:1)
names(x) <- letters[x]
x + y


# 2.숫자 2,5,3을 원소로 갖는 벡터 생성한 후 rep함수를 이용하여
# 다음 벡터를 생성

# - 2,5,3,2,5,3,2,5,3,2,5,3,2,5,3
n <- c(2,5,3)
rep(n, times=5)

# - 2,5,3,2,5,3,2,5,3,2
rep(n, length.out=10)

# - 2,2,5,5,5,5,5,3,3,3



# 3.주사위를 7번 던져서 나온 3,2,5,1,5,6,5의 값을 
# 1)여섯 개의 레벨을 갖는 팩터로 저장하시오.
dice <- c(3,2,5,1,5,6,5)
dice.f <- factor(dice, levels = c(1:6))
dice.f

# 2)각 레벨에 one, two, ... six로 이름 부여하시오.
# 방법1
levels(dice.f) <- c("one","two","three","four","five","six")
levels(dice.f)

# 방법2
dice.o <- factor(dice, levels = c(1:6), labels = c("one","two","three","four","five","six"), ordered = TRUE)
dice.o

# 3)레벨별 발생 빈도를 출력하시오.
table(dice.o)



# 4. 1~12까지의 숫자 벡터로 3*4행렬 생성하고 변수에 저장하시오.
# 알파벳 소문자 상수 벡터 letters를 이용하여 행과 열이름을 각각 지정하시오.
mtx <- matrix(1:12, 3, 4, dimnames = list(letters[c(1:3)],letters[c(1:4)]))
mtx

# 5. 4번에서 생성한 행렬로부터 1번째와 3번째 열을 추출하여
# 부분행렬을 생성하고, 2번째와 4번째 열을 추출하여 부분행렬을
# 생성하고, 이들을 열의 방향으로 결합한 새로운 행렬을 생성하시오.
c13 <- mtx[,c(1,3)]
c24 <- mtx[,c(2,4)]
newMtx <- cbind(c13,c24)
newMtx


# 6. 4번과 5번문제에서 생성한 두 행렬에 대해 +, -, *, /, %*% 연산을
# 수행하시오
mtx + newMtx
mtx - newMtx
mtx * newMtx
mtx / newMtx

# %*%의 경우, 적합한 인자들이 아니라는 error가 나타남
# 따라서 아래와 같이 수정과정을 거쳐 진행함.
mtx %*% t(newMtx)



# 7. 1~9999까지 정수로 9개의 열을 갖는 행렬을 생성하시오.
# 마지막 세 개 행과 마지막 두 개 열로 구성된 3*2 부분행렬을 만드시오.

m <- matrix(1:9999,ncol=9)
m[(nrow(m)-2):nrow(m),8:9]