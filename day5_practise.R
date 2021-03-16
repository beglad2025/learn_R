# 1. Happy, Birthday, to, you�� ������ �ؽ�Ʈ ���� �����Ͻÿ�
txt <- c("Happy", "Birthday", "to", "you")

# -������ ���� 
length(txt)

# -���� ������ ��
sum(nchar(txt))



# 2. 1�� ���� ���͸� ��� �����Ͻÿ� ("Happy Birthday to you")
txt2 <- paste(txt, collapse = " ")

# - �ؽ�Ʈ ������ ����
length(txt2)
# - ���� ������ ���� ����Ͻÿ�
nchar(txt2)



# 3. patse�Լ��� LETTERS ��� ���͸� �̿��Ͽ� ���� ���� ���� �����Ͻÿ�
# - "A 1" "B 2" "C 3" "D 4" "E 5"
paste(LETTERS[1:5], 1:5, sep = " ")

# -" A1" "B2" "C3" "D4" "E5"
paste(LETTERS[1:5], 1:5, sep = "")


 
# 4. �ܾ� ������ �����ϰ�, ��� ��ǥ�� �������� �����Ͻÿ�.
txt3 <- c("Yesterday is history,", "That's, why we call it the present - from Kung")
txt3 <- gsub(pattern = ",|-", replacement = "", x=txt3)
txt3 <- strsplit(txt3, split = " ")
txt3



# 5. �ֹι�ȣ �� �ϰ� �ڸ� ���� *�� ��� ��ü�Ͻÿ�
socialnum <- c("110101-1234123", "950102-2121212")
new.socialnum <- gsub(pattern = "-\\d+", replacement = '-*******', x=socialnum)
new.socialnum

substring(socialnum, 8) <- "*******"
socialnum

# 6. paste�Լ��� month.abb�� �����Ͽ� "Jan_1-Feb_2- ... Dec_12"�� �����Ͻÿ�
paste(month.abb, "_", 1:12, sep = "", collapse = "-")



# 7. read.csv(file="samsung.csv")
samsung <- read.csv("005930.KS.csv", header = TRUE, sep = ",")
samsung

# 1) Open, High, Low, Close, Adj.Close, Volume ���� ����
samsung[, -1]

# 2) �� ���� ���� �ּҰ�, �ִ밪, ���, ǥ������ ���
apply(samsung[,-1], 2, min)
apply(samsung[,-1], 2, max)
apply(samsung[,-1], 2, mean)
apply(samsung[,-1], 2, sd)


# 3) �� ���� ���� ����ȭ / ǥ��ȭ
# ����ȭ
apply(samsung[,-1], 2, function(x){(x-min(x, na.rm = T))/(max(x, na.rm = T)-min(x, na.rm = T))})
# ǥ��ȭ
apply(samsung[,-1], 2, function(x){(x-mean(x, na.rm=T))/sd(x, na.rm = T)})

# 4) Low ���� High �� ������ ���� �ִ� ���� ���
# - High �� �ִ� ���� =  Max(High(n-1)-High(n))  here, n�� Ư������ �ǹ�
apply(samsung[,3:4], 2, function(x){max(x[1:nrow(samsung)-1]-x[2:nrow(samsung)])})