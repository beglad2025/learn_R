#1

exam <- read.csv("csv_exam.csv", na.strings = "")
exam

#2 exam에서 class가 1인 자료들만 추출( %>% 사용)

library(dplyr)
exam %>% filter(class==1)

#3 exam에서 class가 1이 아닌 자료들만 추출( %>% 사용)

exam %>% filter(class!=1)

#4 수학점수가 50점을 초과한 데이터만 추출

exam %>% filter(math>50)

#5 수학점수가 50점을 초과하면서 1반인 데이터만 추출

exam %>% filter(math>50 & class==1)

#6 수학점수가 90점 이상이거나 영어점수가 90점 이상이 데이터 추출

exam %>% filter(math>=90 | english>=90)

#7 1반 2반 3반 자료만 추출

exam %>% filter(class==1|class==2|class==3)
#또는
exam %>% filter(class %in% c(1:3))

#8 1반과 2반의 데이터를 각각 class1,class2에 넣는다

class1 <- exam %>% filter(class==1)
class2 <- exam %>% filter(class==2)

#9 1반과 2반의 수학점수 평균을 각각 구하라

mean(class1$math)
mean(class2$math)

#10 class가 1반인 행만 추출한 다음 english 열 추출

exam %>% filter(class==1) %>% select(english)

#11 id열과 math열 추출, 앞부분 6개만 추출

exam %>% select(id, math) %>% head()

#12 math 오름차순 정렬

exam %>% arrange(math)

#13 math 내림차순 정렬

exam %>% arrange(desc(math))

#14 수학, 영어, 과학점수를 모두 더하여 total 변수 추가 및 출력 

exam$total <- rowSums(exam[,3:5])
exam$total

exam %>% mutate(total=math+english+science)

#15 science가 60점 이상이면 pass, 미만이면 fail -> test열에 추가

exam %>% 
  mutate(test=ifelse(science>=60, "pass", "fail"))

#16 total열을 기준으로 오름차순 정렬하여 출력

exam %>% 
  mutate(total=math+english+science) %>% 
  arrange(total)

#17 그룹단위 요약
# exam에서 반별 수학점수 평균 출력

exam %>% 
  group_by(class) %>% 
  summarise(Math_mean=mean(math))

#18 그룹단위 요약
# exam에서 반별 수학점수 합계, 평균, 중위수, 학생수 출력

exam %>% 
  group_by(class) %>% 
  summarise(Math_total=sum(math),
            Math_mean=mean(math),
            Math_median=median(math),
            stud_num=n())




library(ggplot2)
mpg

#1
# 회사별(manufacturer), 구동방식별(drv) 그룹화
# cty 평균 출력

mpg %>% 
  group_by(manufacturer, drv)

# 이론 : 제조사 15개 * 구동방식 3가지 = 45개 그룹
# 실제 : 22개 그룹


mpg %>% 
  group_by(manufacturer, drv) %>% 
  summarise(Mean_city=mean(cty))


#2
# manufacturer별로 그룹화
# 위 그룹단위로 suv를 추출
# cty와 hwy의 평균을 구하여 tot라는 새로운 열을 추가

mpg %>% 
  group_by(manufacturer) %>% 
  filter(class=="suv") %>% 
  mutate(tot=(cty+hwy)/2) %>% 
  summarise(mean_tot=mean(tot)) %>%   #그룹별 통합 연비의 평균 출력
  arrange(desc(mean_tot))





# 중간고사 데이터 생성
test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterm = c(60, 80, 70, 90, 85))
# 기말고사 데이터 생성
test2 <- data.frame(id = c(1, 2, 3, 4, 5),
                    final = c(70, 83, 65, 95, 80))


#1 위 두 데이터를 id를 기준으로 합쳐라

total <- left_join(test1, test2, by="id")
total




name <- data.frame(class = c(1, 2, 3, 4, 5),
                   teacher = c("kim", "lee", "park", "choi", "jung"))


#2 앞에서 썼었던 exam파일과 name을 합쳐보자

examNew <- left_join(name, exam, by="class")





# 학생 1~5 번 시험 데이터 생성
group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(60, 80, 70, 90, 85))
# 학생 6~10 번 시험 데이터 생성
group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))


#3 group_a와 group_b를 옆이 아니라 아래에 합치고 싶다

group_all <- bind_rows(group_a, group_b)
group_all

