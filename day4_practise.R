# 1.���� ������ ���� R ���� ��Ÿ���ÿ�.
# �� �ڷ� -0.2, 1, 2, 1.5, 2.2�� �ڷẤ�ͷ� x�� �����϶�.
x <- c(-0.2, 1, 2, 1.5, 2.2)
x

# �� "Kim", "Lee", "Park", "Lim"�� �ڷẤ�� name���� �����϶�. 
name <- c("Kim", "Lee", "Park", "Lim")
name

# �� 2���� 9������ �������͸� �����϶�.
n <- 2:9
n

# �� 0���� 10���� 0.5�� �����ϴ� �Ǽ� ���͸� �����϶�.
r <- seq(from=0, to=10, by=0.5)
r

# �� ���� 1,2,3�� 3�� �ݺ��ϴ� ���͸� �����϶�.
n.rep <- rep(1:3, times=3)
n.rep



 
# 2.x=c(2, -1, 3, 7, 0.5, 8)�� ����Ǿ��� ����.
# ���� ������ R ���� ���Ͻÿ�.
# �� 5��° ���Ҵ�?
x <- c(2, -1, 3, 7, 0.5, 8)
x[5]

# �� ù ��°���� 3��°������ ���Ҵ�?
x[1:3]

# �� 6, 2, 4��° ���Ҹ� ���ÿ� ã�ƶ�.
x[c(6,2,4)]

# �� 3��° ���Ҹ� ������ ������ ���Ҵ�?
x[-3]

# �� x�� ���� �� 0���� ū ���� ã�ƶ�.
x[x>0]

# �� ¦�� ���ҵ��� ã�ƶ�.
x[x%%2 == 0]

# �� x���� Ȧ�����Ҹ� ã�� �����϶�.
x <- c(2, -1, 3, 7, 0.5, 8)
x <- x[-which(x%%2 != 0)]
x




# 3.��Ű���� ����� ������ cats�� ���� 3���� ������ �����Ǿ� �ִ�.
library(MASS) # MASS��Ű���� �ε�
cats.h <- head(cats)    # cats�������������� �� �� ����

# -���� �ڷ�(cats)�� �ڷ��� ���� ���Ͻÿ�
nrow(cats) * ncol(cats)
length(cats)

# -������ �����Կ� ������ ����(Bwt�� Hwt)�� ��հ� ǥ�������� ���϶�.
# cats.h�� ���, ǥ������
Bwt.m <- mean(cat.h[["Bwt"]])
Bwt.m
Bwt.sd <- sd(cat.h[["Bwt"]])
Bwt.sd

Hwt.m <- mean(cat.h[["Hwt"]])
Hwt.m
Hwt.sd <- sd(cat.h[["Hwt"]])
Hwt.sd

# cats �ڷ� ��ü�� ���, ǥ������
Bwt.m <- mean(cats[["Bwt"]])
Bwt.m
Bwt.sd <- sd(cats[["Bwt"]])
Bwt.sd

Hwt.m <- mean(cats[["Hwt"]])
Hwt.m
Hwt.sd <- sd(cats[["Hwt"]])
Hwt.sd


library(MASS)
cats
with(cats, {
  print(mean(Bwt))
  print(mean(Hwt))
  print(mean(Bwt))
  print(mean(Hwt))
})

colMeans(cats[2:3], na.rm = TRUE)

# -������ �ϼ��� �����Կ� ������ ������ ��հ� ǥ�������� ���� ���϶�.
# 1) ������������ cats���� �ϼ��� �����Ͽ� ���� ����
cats.F <- subset(cats, Sex == "F")
cats.M <- subset(cats, Sex == "M")

# 2) ��� matrix�� ����
Bwt.m <- c(mean(cats.F[["Bwt"]]), mean(cats.M[["Bwt"]]))
Bwt.sd <- c(sd(cats.F[["Bwt"]]), sd(cats.M[["Bwt"]]))
Hwt.m <- c(mean(cats.F[["Hwt"]]), mean(cats.M[["Hwt"]]))
Hwt.sd <- c(sd(cats.F[["Hwt"]]), sd(cats.M[["Hwt"]]))

cats.mtx <- rbind(Bwt.m, Bwt.sd, Hwt.m, Hwt.sd)
colnames(cats.mtx) <- c("F","M")
cats.mtx

# 4. ���� d1, d2�� ������ ���� �� �� ������ �����ϱ� ����
# �ڵ带 �ۼ��ϰ� ���� ���Ͻÿ�.
d1 <- 1:50
d2 <- 51:100
# d1, d2�� ���� ����Ͻÿ�.
d1
d2

# d2�� ����(������ ����)�� ���̽ÿ�.
length(d2)

# d1+d2, d2-d1, d1*d2, d2/d1�� ������ ����� ����Ͻÿ�.
d1+d2
d2-d1
d1*d2
d2/d1

# d1, d2�� ������ ���� ���� ����Ͻÿ�.
sum(d1)
sum(d2)

# d1, d2�� �ִ� ��� ������ ���� ����Ͻÿ�.
sum(c(d1,d2))

# d2���� ���� ū ���� ���� ���� ���� ����Ͻÿ�.
max(d2)
min(d2)

# d2�� d1�� ������ ��հ��� ���� ���ϰ� �� ����� ���̸� ����Ͻÿ�.
d2.m <- mean(d2)
d1.m <- mean(d1)
abs(d2.m-d1.m)

# 5.������ ���� ���� v1�� ������ ����
# �� ������ �����ϱ� ���� �ڵ带 �ۼ��ϰ� ���� ���Ͻÿ�
# (������ Ǯ�� ���� v1�� ������ ����Ǳ⵵ �ϴµ�,
# ��� ������ ������ v1�� ������� �Ͽ� �ذ� �� ��).
v1<- 30:100
# v1���� 60���� ���� ���� ��� ����Ͻÿ�.
v1[v1<60]

# v1���� 70���� ���� ���� �� ������ ����Ͻÿ�.
length(v1[v1<70])

# v1���� 65���� ū ������ ���� ����Ͻÿ�.
sum(v1[v1>65])

# v1���� 60���� ũ�� 73���� ���� ���� ��� ����Ͻÿ�.
v1[60<v1 & v1<73]
subset(v1, subset = (v1>60 & v1<73))

# v1���� 65���� �۰ų� 80���� ū ���� ��� ����Ͻÿ�.
v1[v1<65 | v1>80]

# v1���� 7�� �������� �� �������� 3�� ���� ��� ����Ͻÿ�.
v1[v1%%7 == 3]

# v1���� 7�� ������� ���� 0���� �����Ͻÿ�.
v1<- 30:100
v1[v1%%7 == 0] <- 0
v1

# v1���� ¦���� ��� ���� ���� ����Ͻÿ�.
v1<- 30:100
sum(v1[v1%%2 ==0])

# v1���� Ȧ���̰ų� 80���� ū ���� ��� ����Ͻÿ�.
v1[v1%%2 != 0 | v1>80]

# v1���� 3�� 5�� ������� ����Ͻÿ�.
v1[v1%%3==0 & v1%%5==0]

# v1���� ¦���� ���ؼ��� 2�� ���Ͽ� �����Ͻÿ�.
v1<- 30:100
v1[v1%%2==0] <- v1[v1%%2==0]*2
v1

# v1���� 7�� ������� ������ �� v1�� ������ ����Ͻÿ�.
v1 <- 30:100
v1 <- v1[-which(v1%%7 == 0)]
v1

# 6. iris�����Ϳ���
# Sepal.Length Sepal.Width Petal.Length Petal.Width ���� ���� 
# (4.0, 3.0, 1.5, 0.15)�϶� ����Ǵ� ��(setosa, verisicolor, virginica)�� ����Ͻÿ�
# (4.0, 3.0, 1.5, 0.15)�� ���� ��Ŭ����� �Ÿ��� ����� �����͸� 9�� ã�Ƴ���
# 9���� �����Ϳ� ���� ���� �󵵼��� ������� ����
# ex) setosa:6, veri:2, vir:1 => setosa ����
iris
x <- c(4.0-min(iris$Sepal.Length)/(max(iris$Sepal.Length) - min(iris$Sepal.Length)), 
       3.0- min(iris$Sepal.Width) / (max(iris$Sepal.Width) - min(iris$Sepal.Width)), 
       1.5- min(iris$Petal.Length) / (max(iris$Petal.Length) - min(iris$Petal.Length)), 
       0.15 - min(iris$Petal.Width) / (max(iris$Petal.Width) - min(iris$Petal.Width)))
x

# ����ȭ �۾�(normalization) : (������ �ڷᰪ - �ּҰ�) / (�ִ밪 - �ּҰ�)
iris$Sepal.Length <- (iris$Sepal.Length - min(iris$Sepal.Length)) / (max(iris$Sepal.Length) - min(iris$Sepal.Length))
iris$Sepal.Width <- (iris$Sepal.Width - min(iris$Sepal.Width)) / (max(iris$Sepal.Width) - min(iris$Sepal.Width))
iris$Petal.Length <- (iris$Petal.Length - min(iris$Petal.Length)) / (max(iris$Petal.Length) - min(iris$Petal.Length))
iris$Petal.Width <- (iris$Petal.Width - min(iris$Petal.Width)) / (max(iris$Petal.Width) - min(iris$Petal.Width))
iris

iris.euclid <- within(iris, euclid <- sqrt(rowSums((iris[,-5] - x)^2)))
iris.euclid

key<-sort(iris.euclid$euclid)[1:10]
key
summary(iris.euclid$Species[iris.euclid$euclid<=key])



# �ٸ� ���(������ ǥ��ȭ/����ȭ ���� ��ġ�� �ʾҴٴ� ���� ����)

data(iris)
iris
ex <- c(4.0, 3.0, 1.5, 0.15)
temp <- t(iris[1:4])
temp

iris$distance <- sqrt(colSums((temp-ex)^2))
table(head(iris[order(iris$distance),],9)$Species)


# �߰� ������Ʈ
# ǥ��ȭ(���0 ǥ������1)�� ����ȭ
# ǥ��ȭ=(�� �� data - �� �� ���) / �� �� ǥ������
# ����ȭ=(�� �� data - �� �� �ּҰ�) / (�� �� �ִ밪 - �� �� �ּҰ�)

data(iris)
iris
ex <- c(4.0, 3.0, 1.5, 0.15)
iris <- rbind(iris,ex)
tail(iris)

misl <- mean(iris$Sepal.Length)
misw <- mean(iris$Sepal.Width)
mipl <- mean(iris$Petal.Length)
mipw <- mean(iris$Petal.Width)

sdsl <- sd(iris$Sepal.Length)
sdsw <- sd(iris$Sepal.Width)
sdpl <- sd(iris$Petal.Length)
sdpw <- sd(iris$Petal.Width)

tempIris <- t(iris[1:4])
tempIris

siris <- (tempIris - c(misl,misw,mipl,mipw)) / c(sdsl,sdsw,sdpl,sdpw)

s.ex <- (ex - c(misl,misw,mipl,mipw)) / c(sdsl,sdsw,sdpl,sdpw)
s.ex

data(iris)
iris
iris[,1]
scale(iris[,1])
# �� �����͸��� ǥ��ȭ�� ��� ������ �Ʒ��� ������ ���� ����
# attr(,"scaled:center")
# [1] 5.843333  # ���
# attr(,"scaled:scale")
# [1] 0.8280661  # ǥ������


data(iris)
iris

(iris[,1] - mean(iris[,1])) / sd(iris[,1])



head((iris[,1] - mean(iris[,1])) / sd(iris[,1]))
head(scale(iris[,1]))

class(head((iris[,1] - mean(iris[,1])) / sd(iris[,1])))
# [1] "numeric"
class(head(scale(iris[,1])))
# [1] "matrix" "array" 



# ����ȭ
(iris[,1] - min(iris[,1])) / (max(iris[,1])-min(iris[,1]))



# iris�� 1��° ���� ���� ǥ��ȭ
(iris[,1] - mean(iris[,1])) / sd(iris[,1])
(iris[,2] - mean(iris[,2])) / sd(iris[,2])
# �̷������� ����ϴ°� �ʹ� ����� ������?��

scale(iris[,1])


cbind(iris,scale=scale(iris[,-5]))


# apply �Լ�
# apply(������, ��(1)/��(2), �Լ�)
apply(iris[,-5], 2, scale)  # �������� ����ؾ��ϹǷ� 2

apply(iris[,-5], 2, function(x){(x-mean(x))/sd(x)})
# Ȥ�� NA�� �ִٸ� �����ϰ� �������ּ���!
siris <- apply(iris[,-5], 2, function(x){(x-mean(x, na.rm=T))/sd(x, na.rm = T)})





# ����ȭ
apply(iris[,-5], 2, function(x){(x-min(x, na.rm = T))/(max(x, na.rm = T)-min(x, na.rm = T))})


cbind(iris, s)

