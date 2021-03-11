# 스크립트 : 명령어 집합
# 야드 -> 미터로 변환하는 명령어 집합
x <- c(30,50,60)
tlength <- round(x*0.9144,1)
tlength
result <- paste(tlength, "m", sep="")
print(result)
