#1

exam <- read.csv("csv_exam.csv", na.strings = "")
exam

#2 exam���� class�� 1�� �ڷ�鸸 ����( %>% ���)

library(dplyr)
exam %>% filter(class==1)

#3 exam���� class�� 1�� �ƴ� �ڷ�鸸 ����( %>% ���)

exam %>% filter(class!=1)

#4 ���������� 50���� �ʰ��� �����͸� ����

exam %>% filter(math>50)

#5 ���������� 50���� �ʰ��ϸ鼭 1���� �����͸� ����

exam %>% filter(math>50 & class==1)

#6 ���������� 90�� �̻��̰ų� ���������� 90�� �̻��� ������ ����

exam %>% filter(math>=90 | english>=90)

#7 1�� 2�� 3�� �ڷḸ ����

exam %>% filter(class==1|class==2|class==3)
#�Ǵ�
exam %>% filter(class %in% c(1:3))

#8 1�ݰ� 2���� �����͸� ���� class1,class2�� �ִ´�

class1 <- exam %>% filter(class==1)
class2 <- exam %>% filter(class==2)

#9 1�ݰ� 2���� �������� ����� ���� ���϶�

mean(class1$math)
mean(class2$math)

#10 class�� 1���� �ุ ������ ���� english �� ����

exam %>% filter(class==1) %>% select(english)

#11 id���� math�� ����, �պκ� 6���� ����

exam %>% select(id, math) %>% head()

#12 math �������� ����

exam %>% arrange(math)

#13 math �������� ����

exam %>% arrange(desc(math))

#14 ����, ����, ���������� ��� ���Ͽ� total ���� �߰� �� ��� 

exam$total <- rowSums(exam[,3:5])
exam$total

exam %>% mutate(total=math+english+science)

#15 science�� 60�� �̻��̸� pass, �̸��̸� fail -> test���� �߰�

exam %>% 
  mutate(test=ifelse(science>=60, "pass", "fail"))

#16 total���� �������� �������� �����Ͽ� ���

exam %>% 
  mutate(total=math+english+science) %>% 
  arrange(total)

#17 �׷���� ���
# exam���� �ݺ� �������� ��� ���

exam %>% 
  group_by(class) %>% 
  summarise(Math_mean=mean(math))

#18 �׷���� ���
# exam���� �ݺ� �������� �հ�, ���, ������, �л��� ���

exam %>% 
  group_by(class) %>% 
  summarise(Math_total=sum(math),
            Math_mean=mean(math),
            Math_median=median(math),
            stud_num=n())




library(ggplot2)
mpg

#1
# ȸ�纰(manufacturer), ������ĺ�(drv) �׷�ȭ
# cty ��� ���

mpg %>% 
  group_by(manufacturer, drv)

# �̷� : ������ 15�� * ������� 3���� = 45�� �׷�
# ���� : 22�� �׷�


mpg %>% 
  group_by(manufacturer, drv) %>% 
  summarise(Mean_city=mean(cty))


#2
# manufacturer���� �׷�ȭ
# �� �׷������ suv�� ����
# cty�� hwy�� ����� ���Ͽ� tot��� ���ο� ���� �߰�

mpg %>% 
  group_by(manufacturer) %>% 
  filter(class=="suv") %>% 
  mutate(tot=(cty+hwy)/2) %>% 
  summarise(mean_tot=mean(tot)) %>%   #�׷캰 ���� ������ ��� ���
  arrange(desc(mean_tot))





# �߰����� ������ ����
test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterm = c(60, 80, 70, 90, 85))
# �⸻���� ������ ����
test2 <- data.frame(id = c(1, 2, 3, 4, 5),
                    final = c(70, 83, 65, 95, 80))


#1 �� �� �����͸� id�� �������� ���Ķ�

total <- left_join(test1, test2, by="id")
total




name <- data.frame(class = c(1, 2, 3, 4, 5),
                   teacher = c("kim", "lee", "park", "choi", "jung"))


#2 �տ��� ����� exam���ϰ� name�� ���ĺ���

examNew <- left_join(name, exam, by="class")





# �л� 1~5 �� ���� ������ ����
group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(60, 80, 70, 90, 85))
# �л� 6~10 �� ���� ������ ����
group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))


#3 group_a�� group_b�� ���� �ƴ϶� �Ʒ��� ��ġ�� �ʹ�

group_all <- bind_rows(group_a, group_b)
group_all
