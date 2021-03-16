library(dplyr)

# 1.
# mpg 데이터를 이용해 분석 문제를 해결해 보세요.

library(ggplot2)
mpg

#혹은 ggplot2::mpg 라고해서 가져올 수도 있음

# • Q1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다.
# displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 
# 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 알아보세요.

mpg %>%
  group_by(displ<=4) %>% 
  summarise(hwy_mean=mean(hwy)) %>% 
  arrange(desc(hwy_mean)) %>% 
  head(1)


# • Q2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 합니다. 
# "audi"와 "toyota" 중 어느 manufacturer(자동차 제조 회사)의 
# cty(도시 연비)가 평균적으로 더 높은지 알아보세요.

mpg %>%
  filter(manufacturer %in% c("audi","toyota")) %>% 
  group_by(manufacturer) %>%
  summarise(cty_mean=mean(cty)) %>%
  arrange(desc(cty_mean)) %>% 
  head(1)

# 다른 방법

audi <- mpg %>% filter(manufacturer=="audi")
toyota <- mpg %>% filter(manufacturer=="toyota")
mean(audi$cty)
mean(toyota$cty)


# • Q3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 합니다. 이 회사들의
# 자동차를 추출한 뒤 hwy 전체 평균을 구해보세요.

mpg %>% 
  filter(manufacturer %in% c("chevrolet", "ford", "honda")) %>% 
  summarise(hwy_total_mean=mean(hwy))


 
# 2. mpg 데이터를 이용해서 분석 문제를 해결해보세요.

# • Q1. mpg 데이터는 11 개 변수로 구성되어 있습니다.
# 이 중 일부만 추출해서 분석에 활용하려고 합니다.
# mpg 데이터에서 class(자동차 종류), cty(도시 연비) 변수를 추출해
# 새로운 데이터를 만드세요.
# 새로 만든 데이터의 일부를 출력해서 두 변수로만 구성되어 있는지 확인하세요.

new.mpg <- mpg %>% 
            select(class, cty)

new.mpg %>% head


# • Q2. 자동차 종류에 따라 도시 연비가 다른지 알아보려고 합니다.
# 앞에서 추출한 데이터를 이용해서 class(자동차 종류)가 "suv"인 자동차와
# "compact"인 자동차 중 어떤 자동차의 cty(도시 연비)가 더
# 높은지 알아보세요

new.mpg %>% 
  filter(class %in% c("suv","compact")) %>% 
  group_by(class) %>% 
  summarise(cty_mean=mean(cty)) %>% 
  arrange(desc(cty_mean)) %>% 
  head(1)

 
# 3. mpg 데이터를 이용해서 분석 문제를 해결해보세요.
# • "audi"에서 생산한 자동차 중에
# 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 합니다. 
# "audi"에서 생산한 자동차 중 
# hwy가 1~5위에 해당하는 자동차의 데이터를 출력하세요.

mpg %>% 
  filter(manufacturer=="audi") %>% 
  arrange(desc(hwy)) %>% 
  head(5)



# 4. mpg 데이터를 이용해서 분석 문제를 해결해보세요.
# mpg 데이터는 연비를 나타내는 변수가 hwy(고속도로 연비),
# cty(도시 연비) 두 종류로 분리되어 있습니다. 
# 두 변수를 각각 활용하는 대신 하나의 통합 연비 변수를 만들어 분석하려고 합니다.

# • Q1. mpg 데이터 복사본을 만들고, 
# cty 와 hwy 를 더한 '합산 연비 변수'를 추가하세요.

copy.mpg <- mpg
copy.mpg <- copy.mpg %>%
              mutate(total_effic=cty+hwy)
copy.mpg

# • Q2. 앞에서 만든 '합산 연비 변수'를 2 로 나눠 '평균 연비 변수'를 추가세요.

copy.mpg <- copy.mpg %>%
              mutate(total_effic_mean=total_effic/2)
copy.mpg


# • Q3. '평균 연비 변수'가 가장 높은 자동차 3 종의 데이터를 출력하세요.

copy.mpg %>% 
  arrange(desc(total_effic_mean)) %>% 
  head(3)

# • Q4. 1~3 번 문제를 해결할 수 있는 하나로 연결된 dplyr 구문을 만들어 출력하세요. 데이터는 복사본 대신
# mpg 원본을 이용하세요.

mpg %>% 
  mutate(total_effic=cty+hwy,
         total_effic_mean=total_effic/2) %>% 
  arrange(desc(total_effic_mean)) %>% 
  head(3)



# 5. mpg 데이터를 이용해서 분석 문제를 해결해 보세요.

data(mpg)
mpg

# • Q1. mpg 데이터의 class 는 "suv", "compact" 등 자동차를 특징에 따라
# 일곱 종류로 분류한 변수입니다. 
# 어떤 차종의 연비가 높은지 비교해보려고 합니다.
# class 별 cty 평균을 구해보세요.

mpg %>% 
  group_by(class) %>% 
  summarise(class_cty_mean=mean(cty))


# • Q2. 앞 문제의 출력 결과는 class 값 알파벳 순으로 정렬되어 있습니다.
# 어떤 차종의 도시 연비가 높은지 쉽게 알아볼 수 있도록 
# cty 평균이 높은 순으로 정렬해 출력하세요.

mpg %>% 
  group_by(class) %>% 
  summarise(class_cty_mean=mean(cty)) %>% 
  arrange(desc(class_cty_mean))

# • Q3. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려고 합니다.
# hwy 평균이 가장 높은 회사 세 곳을 출력하세요.

mpg %>% 
  group_by(manufacturer) %>% 
  summarise(hwy_mean=mean(hwy)) %>% 
  arrange(desc(hwy_mean)) %>% 
  head(3)


# • Q4. 어떤 회사에서 "compact"(경차) 차종을 
# 가장 많이 생산하는지 알아보려고 합니다. 각 회사별
# "compact" 차종 수를 내림차순으로 정렬해 출력하세요.

mpg %>% 
  filter(class=="compact") %>% 
  group_by(manufacturer) %>% 
  summarise(compact_num=n()) %>% 
  arrange(desc(compact_num))



# 6. mpg 데이터를 이용해서 분석 문제를 해결해 보세요.
# mpg 데이터의 fl 변수는 자동차에 사용하는 연료(fuel)를 의미합니다.
# 아래는 자동차 연료별 가격을 나타낸 표입니다.
# fl 연료 종류 가격(갤런당 USD)
# c CNG 2.35
# d diesel 2.38
# e ethanol E85 2.11
# p premium 2.76
# r regular 2.22
# 우선 이 정보를 이용해서 연료와 가격으로 구성된 데이터 프레임을 만들어 보세요.
# fuel # 출력
# 
# ##   fl price_fl
# ## 1 c   2.35
# ## 2 d   2.38
# ## 3 e   2.11
# ## 4 p   2.76
# ## 5 r    2.22

price <- data.frame(fl=c("c","d","e","p","r"),
                    price_fl=c(2.35,2.38,2.11,2.76,2.22))

# • Q1. mpg 데이터에는 연료 종류를 나타낸 fl 변수는 있지만
# 연료 가격을 나타낸 변수는 없습니다.
# 위에서 만든 fuel 데이터를 이용해서 
# mpg 데이터에 price_fl(연료 가격) 변수를 추가하세요.

mpg <- left_join(mpg, price, by="fl")


# • Q2. 연료 가격 변수가 잘 추가됐는지 확인하기 위해서 
# model, fl, price_fl 변수를 추출해 앞부분 5 행을
# 출력해 보세요.

mpg %>% 
  select(model, fl, price_fl) %>% 
  head(5)

 
# 7. 미국 동북중부 437개 지역의 인구통계 정보를 담고 있는 midwest 데이터를 사용해
# 데이터 분석 문제를 해결해 보세요. midwest는 ggplot2 패키지에 들어 있습니다.

library(ggplot2)
midwest

# • 문제 1. popadults 는 해당 지역의 성인 인구, poptotal 은 전체 인구를 나타냅니다.
# midwest 데이터에 '전체 인구 대비 미성년 인구 백분율' 변수를 추가하세요.


midwest <- midwest %>% 
            mutate(perc_teen=(poptotal-popadults)*100/poptotal)


# • 문제 2. 미성년 인구 백분율이 가장 높은 상위 5 개 county(지역)의 
# 미성년 인구 백분율을 출력하세요.
  
midwest %>%
  group_by(county) %>% 
  arrange(perc_teen) %>%
  select(perc_teen) %>% 
  head(5)



# • 문제 3. 분류표의 기준에 따라 미성년 비율 등급 변수를 추가하고,
# 각 등급에 몇 개의 지역이 있는지 알아보세요.
# 분류 기준
# large 40% 이상
# middle 30% ~ 40% 미만
# small 30% 미만

midwest %>% 
  mutate(scale=ifelse(perc_teen>=40,
                      "large",
                      ifelse(perc_teen<30, "small", "middle"))) %>% 
  group_by(scale) %>% 
  summarise(scale_num=n())


# • 문제4. popasian은 해당 지역의 아시아인 인구를 나타냅니다.
# '전체 인구 대비 아시아인 인구 백분율' 변수를 추가하고, 
# 하위 10개 지역의 state(주), county(지역명), 아시아인 인구 백분율을 출력하세요

midwest %>% 
  mutate(perc_asian=popasian*100/poptotal) %>% 
  arrange(perc_asian) %>% 
  select(state, county, perc_asian) %>% 
  head(10)
library(dplyr)

# 1.
# mpg 데이터를 이용해 분석 문제를 해결해 보세요.

library(ggplot2)
mpg

#혹은 ggplot2::mpg 라고해서 가져올 수도 있음

# • Q1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다.
# displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 
# 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 알아보세요.

mpg %>%
  group_by(displ<=4) %>% 
  summarise(hwy_mean=mean(hwy)) %>% 
  arrange(desc(hwy_mean)) %>% 
  head(1)


# • Q2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 합니다. 
# "audi"와 "toyota" 중 어느 manufacturer(자동차 제조 회사)의 
# cty(도시 연비)가 평균적으로 더 높은지 알아보세요.

mpg %>%
  filter(manufacturer %in% c("audi","toyota")) %>% 
  group_by(manufacturer) %>%
  summarise(cty_mean=mean(cty)) %>%
  arrange(desc(cty_mean)) %>% 
  head(1)

# 다른 방법

audi <- mpg %>% filter(manufacturer=="audi")
toyota <- mpg %>% filter(manufacturer=="toyota")
mean(audi$cty)
mean(toyota$cty)


# • Q3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 합니다. 이 회사들의
# 자동차를 추출한 뒤 hwy 전체 평균을 구해보세요.

mpg %>% 
  filter(manufacturer %in% c("chevrolet", "ford", "honda")) %>% 
  summarise(hwy_total_mean=mean(hwy))


 
# 2. mpg 데이터를 이용해서 분석 문제를 해결해보세요.

# • Q1. mpg 데이터는 11 개 변수로 구성되어 있습니다.
# 이 중 일부만 추출해서 분석에 활용하려고 합니다.
# mpg 데이터에서 class(자동차 종류), cty(도시 연비) 변수를 추출해
# 새로운 데이터를 만드세요.
# 새로 만든 데이터의 일부를 출력해서 두 변수로만 구성되어 있는지 확인하세요.

new.mpg <- mpg %>% 
            select(class, cty)

new.mpg %>% head


# • Q2. 자동차 종류에 따라 도시 연비가 다른지 알아보려고 합니다.
# 앞에서 추출한 데이터를 이용해서 class(자동차 종류)가 "suv"인 자동차와
# "compact"인 자동차 중 어떤 자동차의 cty(도시 연비)가 더
# 높은지 알아보세요

new.mpg %>% 
  filter(class %in% c("suv","compact")) %>% 
  group_by(class) %>% 
  summarise(cty_mean=mean(cty)) %>% 
  arrange(desc(cty_mean)) %>% 
  head(1)

 
# 3. mpg 데이터를 이용해서 분석 문제를 해결해보세요.
# • "audi"에서 생산한 자동차 중에
# 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 합니다. 
# "audi"에서 생산한 자동차 중 
# hwy가 1~5위에 해당하는 자동차의 데이터를 출력하세요.

mpg %>% 
  filter(manufacturer=="audi") %>% 
  arrange(desc(hwy)) %>% 
  head(5)



# 4. mpg 데이터를 이용해서 분석 문제를 해결해보세요.
# mpg 데이터는 연비를 나타내는 변수가 hwy(고속도로 연비),
# cty(도시 연비) 두 종류로 분리되어 있습니다. 
# 두 변수를 각각 활용하는 대신 하나의 통합 연비 변수를 만들어 분석하려고 합니다.

# • Q1. mpg 데이터 복사본을 만들고, 
# cty 와 hwy 를 더한 '합산 연비 변수'를 추가하세요.

copy.mpg <- mpg
copy.mpg <- copy.mpg %>%
              mutate(total_effic=cty+hwy)
copy.mpg

# • Q2. 앞에서 만든 '합산 연비 변수'를 2 로 나눠 '평균 연비 변수'를 추가세요.

copy.mpg <- copy.mpg %>%
              mutate(total_effic_mean=total_effic/2)
copy.mpg


# • Q3. '평균 연비 변수'가 가장 높은 자동차 3 종의 데이터를 출력하세요.

copy.mpg %>% 
  arrange(desc(total_effic_mean)) %>% 
  head(3)

# • Q4. 1~3 번 문제를 해결할 수 있는 하나로 연결된 dplyr 구문을 만들어 출력하세요. 데이터는 복사본 대신
# mpg 원본을 이용하세요.

mpg %>% 
  mutate(total_effic=cty+hwy,
         total_effic_mean=total_effic/2) %>% 
  arrange(desc(total_effic_mean)) %>% 
  head(3)



# 5. mpg 데이터를 이용해서 분석 문제를 해결해 보세요.

data(mpg)
mpg

# • Q1. mpg 데이터의 class 는 "suv", "compact" 등 자동차를 특징에 따라
# 일곱 종류로 분류한 변수입니다. 
# 어떤 차종의 연비가 높은지 비교해보려고 합니다.
# class 별 cty 평균을 구해보세요.

mpg %>% 
  group_by(class) %>% 
  summarise(class_cty_mean=mean(cty))


# • Q2. 앞 문제의 출력 결과는 class 값 알파벳 순으로 정렬되어 있습니다.
# 어떤 차종의 도시 연비가 높은지 쉽게 알아볼 수 있도록 
# cty 평균이 높은 순으로 정렬해 출력하세요.

mpg %>% 
  group_by(class) %>% 
  summarise(class_cty_mean=mean(cty)) %>% 
  arrange(desc(class_cty_mean))

# • Q3. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려고 합니다.
# hwy 평균이 가장 높은 회사 세 곳을 출력하세요.

mpg %>% 
  group_by(manufacturer) %>% 
  summarise(hwy_mean=mean(hwy)) %>% 
  arrange(desc(hwy_mean)) %>% 
  head(3)


# • Q4. 어떤 회사에서 "compact"(경차) 차종을 
# 가장 많이 생산하는지 알아보려고 합니다. 각 회사별
# "compact" 차종 수를 내림차순으로 정렬해 출력하세요.

mpg %>% 
  filter(class=="compact") %>% 
  group_by(manufacturer) %>% 
  summarise(compact_num=n()) %>% 
  arrange(desc(compact_num))



# 6. mpg 데이터를 이용해서 분석 문제를 해결해 보세요.
# mpg 데이터의 fl 변수는 자동차에 사용하는 연료(fuel)를 의미합니다.
# 아래는 자동차 연료별 가격을 나타낸 표입니다.
# fl 연료 종류 가격(갤런당 USD)
# c CNG 2.35
# d diesel 2.38
# e ethanol E85 2.11
# p premium 2.76
# r regular 2.22
# 우선 이 정보를 이용해서 연료와 가격으로 구성된 데이터 프레임을 만들어 보세요.
# fuel # 출력
# 
# ##   fl price_fl
# ## 1 c   2.35
# ## 2 d   2.38
# ## 3 e   2.11
# ## 4 p   2.76
# ## 5 r    2.22

price <- data.frame(fl=c("c","d","e","p","r"),
                    price_fl=c(2.35,2.38,2.11,2.76,2.22))

# • Q1. mpg 데이터에는 연료 종류를 나타낸 fl 변수는 있지만
# 연료 가격을 나타낸 변수는 없습니다.
# 위에서 만든 fuel 데이터를 이용해서 
# mpg 데이터에 price_fl(연료 가격) 변수를 추가하세요.

mpg <- left_join(mpg, price, by="fl")


# • Q2. 연료 가격 변수가 잘 추가됐는지 확인하기 위해서 
# model, fl, price_fl 변수를 추출해 앞부분 5 행을
# 출력해 보세요.

mpg %>% 
  select(model, fl, price_fl) %>% 
  head(5)

 
# 7. 미국 동북중부 437개 지역의 인구통계 정보를 담고 있는 midwest 데이터를 사용해
# 데이터 분석 문제를 해결해 보세요. midwest는 ggplot2 패키지에 들어 있습니다.

library(ggplot2)
midwest

# • 문제 1. popadults 는 해당 지역의 성인 인구, poptotal 은 전체 인구를 나타냅니다.
# midwest 데이터에 '전체 인구 대비 미성년 인구 백분율' 변수를 추가하세요.


midwest <- midwest %>% 
            mutate(perc_teen=(poptotal-popadults)*100/poptotal)


# • 문제 2. 미성년 인구 백분율이 가장 높은 상위 5 개 county(지역)의 
# 미성년 인구 백분율을 출력하세요.
  
midwest %>%
  group_by(county) %>% 
  arrange(perc_teen) %>%
  select(perc_teen) %>% 
  head(5)



# • 문제 3. 분류표의 기준에 따라 미성년 비율 등급 변수를 추가하고,
# 각 등급에 몇 개의 지역이 있는지 알아보세요.
# 분류 기준
# large 40% 이상
# middle 30% ~ 40% 미만
# small 30% 미만

midwest %>% 
  mutate(scale=ifelse(perc_teen>=40,
                      "large",
                      ifelse(perc_teen<30, "small", "middle"))) %>% 
  group_by(scale) %>% 
  summarise(scale_num=n())


# • 문제4. popasian은 해당 지역의 아시아인 인구를 나타냅니다.
# '전체 인구 대비 아시아인 인구 백분율' 변수를 추가하고, 
# 하위 10개 지역의 state(주), county(지역명), 아시아인 인구 백분율을 출력하세요

midwest %>% 
  mutate(perc_asian=popasian*100/poptotal) %>% 
  arrange(perc_asian) %>% 
  select(state, county, perc_asian) %>% 
  head(10)
