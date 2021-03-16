smsCorpus <- VCorpus(VectorSource(smsraw$text))

# 1. 수치 데이터 추출/제거

str(smsCorpus)

# 추출

str_extract_all(smsCorpus$content, "[[:digit:]]{1,}")

# 제거

smsCorpus[[4]]$content
# "complimentary 4 STAR Ibiza Holiday or ￡10,000 cash needs your URGENT collection. 09066364349 NOW from Landline not to lose out! Box434SK38WP150PPM18+"

smsCorpus <- tm_map(smsCorpus, removeNumbers)
smsCorpus[[4]]$content
# "complimentary  STAR Ibiza Holiday or ￡, cash needs your URGENT collection.  NOW from Landline not to lose out! BoxSKWPPPM+"


stopwords()  #소문자 형태
# 따라서 정확한 제거를 위해 대소문자 통일을 먼저 진행했다

# 3. 대소문자 통일

smsCorpus <- tm_map(smsCorpus, content_transformer(tolower))
smsCorpus[[4]]$content
# "complimentary  star ibiza holiday or ￡, cash needs your urgent collection.  now from landline not to lose out! boxskwpppm+"


# 2. 불용어 제거

smsCorpus <- tm_map(smsCorpus, removeWords, stopwords())
smsCorpus[[4]]$content
# "complimentary  star ibiza holiday  ￡, cash needs  urgent collection.  now  landline   lose ! boxskwpppm+"


# 4. 특수문자 제거

smsCorpus <- tm_map(smsCorpus, removePunctuation)
smsCorpus[[4]]$content
# "complimentary  star ibiza holiday  ￡ cash needs  urgent collection  now  landline   lose  boxskwpppm"

# 5. 단어 길이가 2 미만인 것을 제거

smsCorpus[[4]]$content
# "complimentary  star ibiza holiday  ￡ cash needs  urgent collection  now  landline   lose  boxskwpppm"
smsCorpus[[6]]$content
# "aiya  discuss later lar pick u     "

smsCorpus <- tm_map(smsCorpus, removeWords, "[[:alpha:]]{1}")

smsCorpus[[4]]$content
# "complimentary  star ibiza holiday  ￡ cash needs  urgent collection  now  landline   lose  boxskwpppm"
smsCorpus[[6]]$content
# "aiya  discuss later lar pick      "


# 6. 전체 단어 중에서 가장 많이 등장한 단어? 내림차순 정렬 10개 추출

# 1) space 정리

remspace <- function(x){
  str_replace_all(x, "[[:space:]]{1,}", " ")
}

smsCorpus <- tm_map(smsCorpus, content_transformer(remspace))
smsCorpus[[4]]$content
# "complimentary star ibiza holiday ￡ cash needs urgent collection now landline lose boxskwpppm"
smsCorpus[[6]]$content
# [1] "aiya discuss later lar pick "

# 2) 공백 기준으로 나누기(단어 단위로 나눔)

word <- lapply(smsCorpus, FUN = function(x){str_split(x, " ")})

# 3) 가장 많이 등장한 단어 내림차순 정렬

head(sort(table(unlist(word)), decreasing = T), 10)

#      call  now  can   ur  get will just   go   ￡ 
# 3701  580  482  405  389  388  382  368  288  285

# 문제는 ￡가 단어가 아니라는 점이다.
# 이를 제거하고 다시 진행해야 한다.

# 1) ￡ 제거

rempunct <- function(x){
  str_replace_all(x, "[[:space:]]{1}￡[[:space:]]{1}", " ")
}

smsCorpus_new <- tm_map(smsCorpus, content_transformer(rempunct))
smsCorpus_new[[4]]$content

word <- lapply(smsCorpus_new, FUN = function(x){str_split(x, " ")})
head(sort(table(unlist(word)), decreasing = T), 10)

#      call  now  can   ur  get will just   go   ok 
# 3701  580  482  405  389  388  382  368  288  279 