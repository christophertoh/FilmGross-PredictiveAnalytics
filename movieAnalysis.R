






setwd("C:/Users/jkchandra/Desktop/BC2406/Semester Analytics Project")

dfraw <- read.csv("movie_team1_cleaned.csv")
dfraw <- dfraw[,-1]
set.seed(349)

library(caTools)
library(leaps)
library(car)

summary(dfraw)

df1 <- dfraw


#LOGGING VARIABLES ------------------------------------------------------------------------------
#Putting 0 as 1 to prevent infinity errors
df1$director_facebook_likes[df1$director_facebook_likes == 0] <- 1
df1$cast_total_facebook_likes[df1$cast_total_facebook_likes == 0] <- 1
df1$movie_facebook_likes[df1$movie_facebook_likes == 0] <- 1
df1$actor_fb_likes[df1$actor_fb_likes == 0] <- 1

#Logging all the variables to reduce the spread of continuous variables
df1$log_director_facebook_likes <- log(df1$director_facebook_likes)
df1$log_gross <- log(df1$gross)
df1$log_cast_total_facebook_likes <- log(df1$cast_total_facebook_likes)
df1$log_actor_fb_likes <- log(df1$actor_fb_likes)
df1$log_budget <- log(df1$budget)
df1$log_movie_facebook_likes <- log(df1$movie_facebook_likes)

df1 <- subset(df1, select = -c(director_facebook_likes, gross, cast_total_facebook_likes, 
                                 actor_fb_likes, budget, movie_facebook_likes))
                                

#Remove Genre None
df1 <- subset(df1,df1$dominantGenre != "None")
df2 <- df1

#SPLITTING TRAIN SET AND TEST SET ------------------------------------------------------------

train.split <- sample.split(Y = df2$log_gross, SplitRatio = 0.7)

df2.train <- subset(df2, train.split == T)
df2.test <- subset(df2, train.split == F)


#BEST SUBSET AJDR2 (m1) -------------------------------------------------------------------------

best.subsets <- regsubsets(log_gross~.-dominantGenre , nbest = 1, nvmax = ncol(df2.train), data = df2.train)
summary(best.subsets)

which.max(summary(best.subsets)$adjr2)
# Maximum adjr2 is 8 coefficients

coef(best.subsets,8)
m1 <- lm(log_gross ~ duration + log_cast_total_facebook_likes + log_actor_fb_likes + 
           log_director_facebook_likes +facenumber_in_poster + log_budget + imdb_score + 
           log_movie_facebook_likes, data = df2.train)

summary(m1)
#Adjr2 is 0.427 and p-value is < 2.2e-16

vif(m1) 
#cast_total_facebook_likes and actor_fb_likes is strongly multicollinear
#Removing actor_fb_likes as cast_total_facebook_likes shows a more general like amongst the cast members
m1 <- lm(log_gross ~ duration + log_cast_total_facebook_likes +  log_director_facebook_likes +
           facenumber_in_poster + log_budget + imdb_score + log_movie_facebook_likes, data = df2.train)

summary(m1)
#Adjr2 is 0.4183 and p-value is < 2.2e-16
par(mfrow=c(2,2))
plot(m1)
#No outliers outside Cook's Distance

#Finding trainset and test set error
m1.trainset.error <- residuals(m1) 
RMSE.m1.train <- sqrt(mean(m1.trainset.error^2))

m1.predict.test <- predict(m1, newdata = df2.test)
m1.testset.error <- df2.test$log_gross - m1.predict.test
RMSE.m1.test <- sqrt(mean(m1.testset.error^2, na.rm = T))
## NEED TO FIND THE EQUATION NOT IN TERMS OF LOG BUT IN TERMS OF EXPONENTIAL

#BEST SUBSET BIC (m2) -------------------------------------------------------------------------

which.min(summary(best.subsets)$bic)
# Minimum BIC is 6 coefficients
coef(best.subsets, 6)
m2 <- lm(log_gross ~ log_budget + log_director_facebook_likes + log_cast_total_facebook_likes  +
            log_actor_fb_likes + duration + imdb_score, data = df2.train)

summary(m2)
#adjr2 = 0.4256, p-value < 2.2e-16
vif(m2) 
#cast_total_facebook_likes and actor_fb_likes is strongly multicollinear
#Removing actor_fb_likes as cast_total_facebook_likes shows a more general like amongst the cast members
m2 <- lm(log_gross ~ log_budget + log_director_facebook_likes + log_cast_total_facebook_likes +
            duration + imdb_score, data = df2.train)

summary(m2)
#adjr2 = 0.4171, p-value < 2.2e-16
par(mfrow=c(2,2))
plot(m2)
#No outliers outside Cook's Distance

m2.trainset.error <- residuals(m2)
RMSE.m2.train <- sqrt(mean(m2.trainset.error^2))

m2.predict.test <- predict(m2, newdata = df2.test)
m2.testset.error <- df2.test$log_gross - m2.predict.test
RMSE.m2.test <- sqrt(mean(m2.testset.error^2, na.rm = T))

#SEPARATING MOVIES INTO THEIR RESPECTIVE GENRES ----------------------------------------------------------------
df3 <- df2.train

#Grouping the Dominant Genres to their Group Genres
FictionGeneral <- c("Drama", "Comedy", "Romance", "Family", "Music", "Fantasy", "Sport", "Musical")
FictionMature <- c("Thriller", "Horror", "Action", "Crime", "Adventure", "SciFi", "Mystery", 
              "Animation", "Western")
NonFiction <- c("Documentary", "History","Biography", "War")


df3$groupGenre[df3$dominantGenre %in% FictionGeneral] <- "FGen" 
df3$groupGenre[df3$dominantGenre %in% FictionMature] <- "FMat"
df3$groupGenre[df3$dominantGenre %in% NonFiction] <- "NF"

#CLUSTERING

df3.c1 <- subset(df3, df3$groupGenre == "FGen")
df3.c2 <- subset(df3, df3$groupGenre == "FMat")
df3.c3 <- subset(df3, df3$groupGenre == "NF")

m3.1 <- lm(log_gross ~ log_budget + log_director_facebook_likes + log_cast_total_facebook_likes +
           duration + imdb_score, data = df3.c1)
m3.2 <- lm(log_gross ~ log_budget + log_director_facebook_likes + log_cast_total_facebook_likes +
             duration + imdb_score, data = df3.c2)
m3.3 <- lm(log_gross ~ log_budget + log_director_facebook_likes + log_cast_total_facebook_likes +
             duration + imdb_score, data = df3.c3)


#BASELINE MODEL (m0) -----------------------------------------------------------------------------------
m0 <- lm(log_gross ~ log_budget, data = df2)

#CCOMPARING AND EVALUATING OF DIFFERENT MODELS ----------------------------------------------------------
summary(m0)
summary(m1)
summary(m2)
summary(m3.1)
summary(m3.2)
summary(m3.3)
