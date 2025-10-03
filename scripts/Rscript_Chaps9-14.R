#####################
####  chapter 9  ####
#####################
### 9.4
set.seed(1)
e<-rnorm(n=50, mean=0, sd=1)
#set.seed(1)
x<-rnorm(n=50, mean=15, sd=5)
y<-20+2*x+5*e
#
DF<-data.frame(e, x, y)
names(DF)<-c("誤差項", "最高気温", "売上")
head(DF)
#
### 
install.packages("tidyverse")
library(ggplot2)
#
ggplot(data=DF, aes(x=x, y=y))+geom_point()
#
ggplot(data=DF, aes(x=e))+geom_histogram(bins=10)
#

#####################
#### chapter 10  ####
#####################
### 10.1 
condo <- read.csv("condo.csv", header=TRUE)
condo_res <-subset(condo, condo$zoning=="住居地域")
# condo_resは住居地域に絞ったデータ
row.names(condo_res)<-1:nrow(condo_res)
# condo_resの各行の名称を観測値番号と一致させる
str(condo_res) # condo_resの内容を確認
#
library(ggplot2)
g <- ggplot(condo_res, aes(x = price, y = after_stat(density)))+
  geom_histogram(position = "identity", binwidth=10)+
  geom_density(alpha=0.5, fill = "gray", show.legend = F)+
  xlab("取引価格 (price)")+ylab("確率密度")+
  scale_x_continuous(limits=c(-10,110))
g
#
summary(condo_res$price)
#
ggplot(condo_res, aes(y=price)) + 
  theme(axis.text.x = element_blank())+
  ylab("取引価格 (price)")+
  geom_boxplot(fill = "pink")
#
summary(condo_res[c(2:4)])
library(GGally)
ggpairs(condo_res[, -c(5, 6)], aes(fill=""))
### 10.1
model_10_1 <- lm(price~fspace, data=condo_res)
summary(model_10_1)
#
yhat <- predict(model_10_1)
# yhatは各xにおける回帰直線の予測値
df <- cbind(condo_res, yhat)
g <- ggplot(data=df, aes(x = fspace, y = price))+
  geom_point()+
  geom_point(aes(x=fspace, y=yhat), color="red", size=4)+
  geom_line(aes(x=fspace, y=yhat))+
  xlab("面積 (fspace)")+ylab("取引価格 (price)")
g
#
mean(condo_res$price); mean(yhat)
#
zansa <- resid(model_10_1)
mean(zansa)
cor(zansa, yhat)
#
model_10_2 <- lm(price~fspace+age+distance, data=condo_res)
#
summary(model_10_2)
#
model_10_3 <- lm(price~fspace+age+distance+structure, data=condo_res)
summary(model_10_3) 	
#
model_10_4 <- lm(log(price)~log(fspace)+log(age+0.5)+log(distance), data=condo_res)
summary(model_10_4)
#
#####################
#### chapter 11  ####
#####################
### 11.1
condo<-read.csv("condo.csv", header=TRUE)
model_11_1 <- lm(price~fspace+age+distance+structure+zoning, data=condo)
summary(model_11_1)
#
install.packages("MuMIn")
library(MuMIn)
options(na.action = "na.fail")
dredge(model_11_1, rank="AIC")
# rank="AIC"はAICの小さい順から結果を出力するオプションです．
#
dredge(model_11_1, rank="BIC")
#
model_11_2<- lm(price~fspace+age+distance+zoning, data=condo)
summary(model_11_2)
### 11.2
H=hatvalues(model_11_2)
summary(H)
condo[H==max(H),]
library(ggplot2)
df<-data.frame(condo, H)
g<-ggplot(df, aes(x=as.numeric(row.names(df)), y=H))+
   labs(x="観測値番号", y="ハット値")+geom_point()+
   geom_abline(intercept=mean(H)*1:2, slope=0, color=c("blue", "red"))
g
#
install.packages("car")
library(car)
influencePlot(model_11_2, xlab="ハット値", ylab="ステューデント化残差", fill=FALSE)
### 11.3
t150 <- rep(1,nrow(condo))*(rownames(condo)==150)
model_11_3 <- lm(price~fspace+age+distance+zoning+t150, data=condo)
summary(model_11_3)
###
model_11_4 <- lm(log(price)~log(fspace)+log(age+0.5)+log(distance)+zoning, data=condo)
summary(model_11_4)
#
influencePlot(model_11_4, xlab="ハット値", 
  ylab="ステューデント化残差", fill=FALSE)
#
#
vif(model_11_4)
#
#####################
#### chapter 12  ####
#####################
### 12.2
install.packages(c("xts", "zoo", "stringr"))
library(xts)
library(zoo)
library(stringr)
yen_data<-read.csv("nme.csv")
yen_data<-na.omit(yen_data) # 欠損値(NA)を削除
yen_xts<-as.xts(read.zoo(yen_data))
yen_2021_xts <- yen_xts["2020-01-06/2021-12-30"]
#
length(yen_2021_xts)
#
plot(yen_2021_xts[,1], xlab="",ylab="ドル／円レート", main="")
#
T1 <- nrow(yen_2021_xts)
roc_xts<-diff(yen_2021_xts[,1])[-1]/yen_2021_xts[,1][1:(T1-1)]
plot(roc_xts, xlab="",ylab="ドル／円レート変化率", main="")
#
T2 <- nrow(yen_data)
fx_rate <- diff(yen_data[,2])/yen_data[,2][1:(T2-1)]*100
for( i in 0:5) {
  assign(paste("Lag", i, sep = ""),
         fx_rate[(6-i):(T2-1-i)])
  }
Direction <- rep("上昇", 1704)
Year <- as.integer(str_sub(yen_data[,1][6:1709], start=1, end=4))
rate_data <- data.frame(Year, Lag0, Lag1, Lag2, Lag3, Lag4, Lag5, Direction)
rate_data$Direction[Lag0<0] <- "下落"
rate_data$Direction<-as.factor(rate_data$Direction)
#
Year<-rate_data$Year
train<-(Year<2021)
test<-(Year==2021)
logit.fit=glm(Direction~Lag1+Lag2, family=binomial, 
  data=rate_data[train,])
summary(logit.fit)
#
logit.probs <- predict(logit.fit, rate_data[test,], type="response")
logit.pred <- rep("下落", dim(rate_data[test,])[1])
logit.pred[logit.probs>.5] <- "上昇"
Direction.test <- rate_data[test,]$Direction
table(logit.pred, Direction.test)
#
mean(logit.pred==Direction.test)
prop.table(table(rate_data[test,]$Direction))
#
logit.fit <- glm(Direction~Lag1+Lag2+Lag5, family=binomial, 
  data=rate_data[train,])
logit.probs <- predict(logit.fit, rate_data[test,], type="response")
logit.pred <- rep("下落", dim(rate_data[test,])[1])
logit.pred[logit.probs>.5]  <-  "上昇"
Direction.test <- rate_data[test,]$Direction
mean(logit.pred==Direction.test)
### 12.3
# 12.3.1
install.packages("openintro")
library(openintro)
data("loans_full_schema")
d1<-loans_full_schema
levels(d1$loan_status)[-1]
#
d2 <- d1[d1$loan_status!="Current" & d1$loan_status!="In Grace Period",]
y <-ifelse(d2$loan_status=="Fully Paid", "Fully Paid", "Default")
d2$loan_outcome <- ordered(y, levels=c("Fully Paid", "Default"))
summary(d2$loan_outcome)
#
d2$credit_util <- d2$total_credit_utilized/d2$total_credit_limit
df <- subset(d2, 
  select=c("homeownership", "annual_income", "debt_to_income", "credit_util", "interest_rate", "grade", "loan_outcome")
  )
df <- na.omit(df)
#
# 12.3.2
#
install.packages(c("tidymodels","rsample","withr"))
library(tidyverse)
library(tidymodels)
library(rsample)
library(withr)
set.seed(123)
df_split <- initial_split(df, prop = 0.7, strata = "loan_outcome")%>% 
   with_seed(123, .)
df_split
#
df_train <- training(df_split) 
df_test <- testing(df_split)
#
logit.fit <- glm(loan_outcome~., 
		  family=binomial, data=df_train)
library(MuMIn)
options(na.action = "na.fail")
dredge(logit.fit, rank="AIC")			  
#
logit.fit <- glm(loan_outcome~credit_util+homeownership+interest_rate, family=binomial, data=df_train)
summary(logit.fit)
#
logit.probs <- predict(logit.fit, df_test, type="response")
logit.pred <- rep("Fully Paid", dim(df_test)[1])
logit.pred <- ordered(logit.pred, levels=c("Fully Paid", "Default"))
logit.pred[logit.probs>0.4] <- "Default"
table(logit.pred, df_test$loan_outcome)
#
install.packages("pROC")
library(pROC)
df_test$loan_01_outcome <- ifelse(df_test$loan_outcome=="Default", 1, 0)
ROC <- roc(response=df_test$loan_01_outcome, predictor=logit.probs) 
coords(ROC, x=0.4, ret=c("threshold", "accuracy", "sensitivity", "specificity"))
#
r <- ggroc(ROC, size = 1, legacy.axes = TRUE)+
geom_abline(color = "dark grey", size = 0.5)+
scale_y_continuous(expand = c(0, 0))+scale_x_continuous(expand = c(0, 0))+
labs(x="偽陽性率", y="真陽性率")
plot(r)
ROC$auc
#####################
#### chapter 13  ####
#####################
### 13.1
condo <- read.csv("condo.csv") 
condo_res <- subset(condo, condo$zoning=="住居地域") 
n_test <- floor(nrow(condo_res)/5) # 検証データの個数
set.seed(123)
id_test <- sample(1:nrow(condo_res), n_test)
test_data <- condo_res[id_test,]　# 訓練データの作成
train_data <- condo_res[-id_test,]　# 検証データの作成
install.packages(c("rpart", "rpart.plot"))
library(rpart); library(rpart.plot)
tree_one <- rpart(price~fspace, data=train_data, method="anova", cp=0.03)
#
prp(tree_one, type=3, fallen.leaves=TRUE, shadow.col ="grey")
#
tree_zero <- rpart(price~., data=train_data, method="anova", cp=0)
printcp(tree_zero)
#
tree_opt <- rpart(price~., data=train_data, method="anova", cp=0.015)
prp(tree_opt, type=3, fallen.leaves=TRUE, shadow.col ="grey")
#
install.packages("rattle")
library("rattle")
fancyRpartPlot(tree_opt, sub="")
#
yhat_opt <- predict(tree_opt, newdata= test_data)
(rmse_opt <- sqrt(mean((yhat_opt - test_data$price)^2)))
### 13.2
df_train <- read.csv("df_train.csv")
C.tree_one <- rpart(loan_outcome~., data = df_train, method="class")
prp(C.tree_one, type=3, fallen.leaves=TRUE, shadow.col ="grey")	
#
C.tree_zero <- rpart(loan_outcome~., data = df_train, 
 method="class", cp=0)
printcp(C.tree_zero)
#
df_train_B <- df_train[1:154,]
printcp(C.tree_zero_B)
C.treeB_one <- rpart(loan_outcome~.-grade, data=df_train_B, method="class", cp=0.035)
fancyRpartPlot(C.treeB_one, sub="")

## Supplementary materials: Ensemble learning ##
install.packages("randomForest")
library(randomForest)
set.seed(123)
bag_condo <- randomForest(price~., train_data, mtry=5, ntree=1000, importance=TRUE) 
importance(bag_condo, type=1)
#
yhat_bag <- predict(bag_condo, newdata=test_data)
(rmse_bag <- sqrt(mean((yhat_bag-test_data$price)^2)))
#
set.seed(123)
for_condo <- randomForest(price~., data=train_data,
  mtry=3, ntree=1000, importance=TRUE) 
importance(for_condo, type=1)
#
yhat_for <- predict(for_condo, newdata=test_data)
(rmse_for <- sqrt(mean((yhat_for-test_data$price)^2)))



#####################
#### chapter 14  ####
#####################
### 14.5
library(openintro)
data("loans_full_schema")
df <- loans_full_schema
df_default <- df[df$loan_status=="Charged Off"|df$loan_status=="Late (16-30 days)"| 
  df$loan_status=="Late (31-120 days)",]
dat <- subset(df_default,
  select=c(2, 5, 7, 11, 13:18, 20, 23:27, 30:36, 41:44, 51:55))
dat <- na.omit(dat)
dim(dat)
#
library(ggplot2)
g <- ggplot(data=dat, aes(x=interest_rate))+
　xlab( "金利")+ylab("件数")+
  geom_histogram(alpha=0.5, bins=10)
g
#
install.packages("glmnet")
library(glmnet)
y <- dat$interest_rate
x <- model.matrix(interest_rate~.-1, data=dat)
set.seed(123) 
train <- sample(1:nrow(x), floor(nrow(x)/2)) # 訓練データ
test <- - train # 検証データ
#
ridge.fit <- glmnet(x[train,], y[train], alpha=0, lambda=1)
ridge.pred <- predict(ridge.fit, newx=x[test,])
sqrt(mean((ridge.pred-y[test])^2)) # 平方根平均二乗誤差
#
ols.fit <- glmnet(x[train,], y[train], alpha=0, lambda=0) # 通常の回帰
ols.pred <- predict(ols.fit, newx=x[test,])
sqrt(mean((ols.pred-y[test])^2)) # 平方根平均二乗誤差
#
set.seed(123) 
cv.lasso <- cv.glmnet(x[train,], y[train ], alpha=1, nfolds=5)
bestlam <- cv.lasso$lambda.min;bestlam
#
lasso.fit <- glmnet(x[train,], y[train], alpha=1, lambda=bestlam)
lasso.pred <- predict(lasso.fit, newx=x[test,])
sqrt(mean((lasso.pred-y[test])^2)) # 平方根平均二乗誤差
#
coef <-  cbind(coef(cv.ridge, s="lambda.min"),
                coef(cv.lasso, s="lambda.min"))
colnames(coef) <- c("Ridge","LASSO")
coef