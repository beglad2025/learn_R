read.csv(file = "day6/product.csv")

read.csv("day6/product-with-no-header.csv", header = FALSE)

p <- read.csv("day6/product.csv", stringsAsFactors = FALSE)
p
str(p)

p <- read.csv("day6/product.csv", as.is=TRUE)
p

# as.is=TRUE는 stringAsFactors=FALSE와 같음

p <- read.table("day6/product.txt", header = TRUE)
p
str(p)

# read.table은 header가 있는 경우에 꼭 말해줘야함
# read.csv 기본적으로 첫번째 줄이 header이라고 인식


read.table("product-colon.txt", sep = ":", header = TRUE)


# product-missing.txt 파일의 경우
# keyboard의 가격이 없어서 .으로 작성한 상태
# NA : 데이터가 누락(결측값)
# "이 값은 점(.)이 아니라 NA야 라고 말해줘야 함

read.table("product-missing.txt", header = TRUE, na.strings = c("누락","몰라"))
# name에 있는 NA는 <NA>이고 price는 NA로 출력되어 있다
# 이는 name에 있는 NA가 문자의 NA이기 때문이다


# product-comment.txt
# 맨 윗줄에 #이 있는 상태
# read.table()는 #으로 시작하는 라인은 주석문으로 간주하고 무시함

read.table("product-comment.txt", header = TRUE)


# brand-eval.csv 파일

read.table("brand-eval.csv", header = TRUE)

# 원래 5개의 colume으로 만들어져야 하는데
# 그냥 하나의 colume으로 다 이어져서 나옴

brand.eval <- read.table("brand-eval.csv", header = TRUE, sep = ",", row.names = "id")
str(brand.eval)
brand.eval
# after service라고 저장했지만 자동적으로 after.service로 변환되어 출력한다


brand.eval <- read.table("day6/brand-eval.csv", 
                         header = TRUE, 
                         sep = ",", 
                         row.names = "id",
                         colClasses = c("character","character","numeric","numeric","numeric"))

brand.eval
str(brand.eval)


# 엑셀 데이터 읽기
install.packages("openxlsx")
library(openxlsx)
read.xlsx("product.xlsx", sheet = 1)

url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
iris.uci <- read.csv(url, header = FALSE)
iris.uci


# 빈번하게 사용하는 자료의 경우, 위처럼 url 불러오는 것보다
# 다운로드 받아서 저장해놓는 것이 나을 것이다.
download.file(url=url, destfile = "myIris.csv")



url <- "http://seanlahman.com/files/database/baseballdatabank-master_2016-03-02.zip"
local.copy <- "baseball.zip"
download.file(url, local.copy)

bs <- read.csv(unzip(zipfile = local.copy, "baseballdatabank-master/core/Salaries.csv"))
head(bs)