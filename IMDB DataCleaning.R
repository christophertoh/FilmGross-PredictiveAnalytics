






setwd("C:/Users/jkchandra/Desktop/BC2406/Semester Analytics Project")

dfraw <- read.csv("movie_metadata.csv")
set.seed(1337)

library(plyr)
library(dplyr)
library(tidytext)
library(stringr)

#SPLITTING KEYWORDS AND GENRES CLEANING -----------------------------------------------------------------------

dfgenres <- subset(dfraw, select = c(genres, plot_keywords))

#Splitting the genres
dfgenres$genres <- as.character(dfgenres$genres)
dfgenres$genres <- strsplit(dfgenres$genres, "|", fixed = T)
genres <- unlist(as.vector(dfgenres$genres))
genres <- unique(genres)
length(genres) #22 genres

#Splitting the keywords
dfgenres$plot_keywords <- as.character(dfgenres$plot_keywords)
dfgenres$plot_keywords <- strsplit(dfgenres$plot_keywords,"|", fixed = T)
keywords <- as.vector(dfgenres$plot_keywords)

gen_key <- data.frame(genres)
gen_key$keywords <- NA

for(i in 1:nrow(dfgenres)){
  for(j in 1:nrow(gen_key)){
    if(grepl(gen_key$genres[j],dfgenres$genres[i])){
      if(is.na(gen_key$keywords[j])){
        gen_key$keywords[j]<- c(dfgenres$plot_keywords[i])
      }
      else
        gen_key$keywords[[j]] <- c(gen_key$keywords[[j]],dfgenres$plot_keywords[[i]], recursive =T)
    }
  }
}

#ASSIGNING WEIGHT AND COUNT TO INDIVIDUAL GENRE -----------------------------------------------------------
words<-  unique(unlist(gen_key$keywords[[1]]))
Action<-  data.frame(words)
Action$isaction <-  1

for (i in 1:nrow(Action)){
  countword <- length(grep(Action$words[i],gen_key$keywords[[1]]))
  Action$wordcount[i] <- countword
  Action$action.weight[i] <- Action$wordcount[i]/sum(Action$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[2]]))
Adventure<-  data.frame(words)
Adventure$isadv <-  1

for (i in 1:nrow(Adventure)){
  countword <- length(grep(Adventure$words[i],gen_key$keywords[[2]]))
  Adventure$wordcount[i] <- countword
  Adventure$adventure.weight[i] <- Adventure$wordcount[i]/sum(Adventure$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[3]]))
Fantasy<-  data.frame(words)
Fantasy$isfant <- 1

for (i in 1:nrow(Fantasy)){
  countword <- length(grep(Fantasy$words[i],gen_key$keywords[[3]]))
  Fantasy$wordcount[i] <- countword
  Fantasy$fantasy.weight[i] <- Fantasy$wordcount[i]/sum(Fantasy$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[4]]))
Sci_Fi<-  data.frame(words)
Sci_Fi$isscifi <-1

for (i in 1:nrow(Sci_Fi)){
  countword <- length(grep(Sci_Fi$words[i],gen_key$keywords[[4]]))
  Sci_Fi$wordcount[i] <- countword
  Sci_Fi$scifi.weight[i] <- Sci_Fi$wordcount[i]/sum(Sci_Fi$wordcount)
}


words<-  unique(unlist(gen_key$keywords[[5]]))
Thriller<-  data.frame(words)
Thriller$isthriller <- 1

for (i in 1:nrow(Thriller)){
  countword <- length(grep(Thriller$words[i],gen_key$keywords[[5]]))
  Thriller$wordcount[i] <- countword
  Thriller$thriller.weight[i] <- Thriller$wordcount[i]/sum(Thriller$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[6]]))
Romance<-  data.frame(words)
Romance$isromance <- 1

for (i in 1:nrow(Romance)){
  countword <- length(grep(Romance$words[i],gen_key$keywords[[6]]))
  Romance$wordcount[i] <- countword
  Romance$romance.weight[i] <- Romance$wordcount[i]/sum(Romance$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[7]]))
Animation<-  data.frame(words)
Animation$isanimation <- 1

for (i in 1:nrow(Animation)){
  countword <- length(grep(Animation$words[i],gen_key$keywords[[7]]))
  Animation$wordcount[i] <- countword
  Animation$animation.weight[i] <- Animation$wordcount[i]/sum(Animation$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[8]]))
Comedy<-  data.frame(words)
Comedy$iscomedy <- 1

for (i in 1:nrow(Comedy)){
  countword <- length(grep(Comedy$words[i],gen_key$keywords[[8]]))
  Comedy$wordcount[i] <- countword
  Comedy$comedy.weight[i] <- Comedy$wordcount[i]/sum(Comedy$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[9]]))
Family<-  data.frame(words)
Family$isfamily <- 1

for (i in 1:nrow(Family)){
  countword <- length(grep(Family$words[i],gen_key$keywords[[9]]))
  Family$wordcount[i] <- countword
  Family$family.weight[i] <- Family$wordcount[i]/sum(Family$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[10]]))
Musical<-  data.frame(words)
Musical$ismusical <- 1

for (i in 1:nrow(Musical)){
  countword <- length(grep(Musical$words[i],gen_key$keywords[[10]]))
  Musical$wordcount[i] <- countword
  Musical$musical.weight[i] <- Musical$wordcount[i]/sum(Musical$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[11]]))
Mystery<-  data.frame(words)
Mystery$ismystery <- 1

for (i in 1:nrow(Mystery)){
  countword <- length(grep(Mystery$words[i],gen_key$keywords[[11]]))
  Mystery$wordcount[i] <- countword
  Mystery$mystery.weight[i] <- Mystery$wordcount[i]/sum(Mystery$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[12]]))
Western<-  data.frame(words)
Western$iswestern <- 1

for (i in 1:nrow(Western)){
  countword <- length(grep(Western$words[i],gen_key$keywords[[12]]))
  Western$wordcount[i] <- countword
  Western$western.weight[i] <- Western$wordcount[i]/sum(Western$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[13]]))
Drama<-  data.frame(words)
Drama$isdrama <- 1

for (i in 1:nrow(Drama)){
  countword <- length(grep(Drama$words[i],gen_key$keywords[[13]]))
  Drama$wordcount[i] <- countword
  Drama$drama.weight[i] <- Drama$wordcount[i]/sum(Drama$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[14]]))
History<-  data.frame(words)
History$ishistory <- 1

for (i in 1:nrow(History)){
  countword <- length(grep(History$words[i],gen_key$keywords[[14]]))
  History$wordcount[i] <- countword
  History$history.weight[i] <- History$wordcount[i]/sum(History$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[15]]))
Sport<-  data.frame(words)
Sport$issport <- 1

for (i in 1:nrow(Sport)){
  countword <- length(grep(Sport$words[i],gen_key$keywords[[15]]))
  Sport$wordcount[i] <- countword
  Sport$sport.weight[i] <- Sport$wordcount[i]/sum(Sport$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[16]]))
Crime<-  data.frame(words)
Crime$iscrime <- 1

for (i in 1:nrow(Crime)){
  countword <- length(grep(Crime$words[i],gen_key$keywords[[16]]))
  Crime$wordcount[i] <- countword
  Crime$crime.weight[i] <- Crime$wordcount[i]/sum(Crime$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[17]]))
Horror<-  data.frame(words)
Horror$ishorror <- 1

for (i in 1:nrow(Horror)){
  countword <- length(grep(Horror$words[i],gen_key$keywords[[17]]))
  Horror$wordcount[i] <- countword
  Horror$horror.weight[i] <- Horror$wordcount[i]/sum(Horror$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[18]]))
War<-  data.frame(words)
War$iswar <- 1

for (i in 1:nrow(War)){
  countword <- length(grep(War$words[i],gen_key$keywords[[18]]))
  War$wordcount[i] <- countword
  War$war.weight[i] <- War$wordcount[i]/sum(War$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[19]]))
Biography<-  data.frame(words)
Biography$isbio <- 1

for (i in 1:nrow(Biography)){
  countword <- length(grep(Biography$words[i],gen_key$keywords[[19]]))
  Biography$wordcount[i] <- countword
  Biography$bio.weight[i] <- Biography$wordcount[i]/sum(Biography$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[20]]))
Music<-  data.frame(words)
Music$ismusic <- 1

for (i in 1:nrow(Music)){
  countword <- length(grep(Music$words[i],gen_key$keywords[[20]]))
  Music$wordcount[i] <- countword
  Music$music.weight[i] <- Music$wordcount[i]/sum(Music$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[21]]))
Documentary<-  data.frame(words)
Documentary$isdoc <- 1

for (i in 1:nrow(Documentary)){
  countword <- length(grep(Documentary$words[i],gen_key$keywords[[21]]))
  Documentary$wordcount[i] <- countword
  Documentary$doc.weight[i] <- Documentary$wordcount[i]/sum(Documentary$wordcount)
}

words<-  unique(unlist(gen_key$keywords[[22]]))
Short<-  data.frame(words)
Short$isshort <- 1

for (i in 1:nrow(Short)){
  countword <- length(grep(Short$words[i],gen_key$keywords[[22]]))
  Short$wordcount[i] <- countword
  Short$short.weight[i] <- Short$wordcount[i]/sum(Short$wordcount)
}

#Using dplyr to merge multiple df by word weight
df.key.weight <- join_all(list(Action,Adventure,Animation,Biography, Comedy, Crime, Documentary,
                                 Drama, Family, Fantasy, History, Horror, Music, Musical,
                                 Mystery, Romance, Sci_Fi, Short, Sport, Thriller, War,
                                 Western), by = "words", type = "full")

df.key.weight <- subset(df.key.weight, select = -c(wordcount))

#Using dplyr to merge multiple df by word count
df.key.count <- join_all(list(Action,Adventure,Animation,Biography, Comedy, Crime, Documentary,
                               Drama, Family, Fantasy, History, Horror, Music, Musical,
                               Mystery, Romance, Sci_Fi, Short, Sport, Thriller, War,
                               Western), by = "words", type = "full")

df.key.count <- subset(df.key.count, select = c(words, isaction, isadv, isanimation, isbio,
                                                iscomedy,iscrime,isdoc,isdrama,isfamily,isfant,ishistory,
                                                ishorror,ismusic,ismusical,ismystery,isromance,isscifi,
                                                isshort,issport,isthriller,iswar,iswestern))
#Converting all NA to 0
df.key.count[is.na(df.key.count)] <- 0

#SUMMING UP MOVIE GENRE WEIGHT -------------------------------------------------------------------------
#Grabbing new set of df for movies
df.movie.weight <- dfraw
#Removing unnecessary data
df.movie.weight <- subset(df.movie.weight, !is.na(gross))
df.movie.weight <- subset(df.movie.weight, !is.na(duration))
df.movie.weight <- subset(df.movie.weight, !is.na(budget))
df.movie.weight <- subset(df.movie.weight, title_year >= 2000)
df.movie.weight <- df.movie.weight[!duplicated(df.movie.weight$movie_title),]
df.movie.weight <- subset(df.movie.weight, select = c(plot_keywords, movie_title))

#separating plot_keywords into a list
df.movie.weight$plot_keywords <- as.character(df.movie.weight$plot_keywords)
df.movie.weight$plot_keywords <- strsplit(df.movie.weight$plot_keywords,"|", fixed = T)

#initialising the weight columns for df.movie.weight
df.movie.weight[,colnames(df.key.weight)] <- 0
#changing words from factor to character
df.key.weight$words <- as.character(df.key.weight$words)

#Sums up amount of weight to each row based on keywords of the movie
for (i in 1:nrow(df.movie.weight)){
  print(i)
  if(lengths(df.movie.weight$plot_keywords[i]) == 0){
    next
  }
  for (j in 1:lengths(df.movie.weight$plot_keywords[i])) {
    for(k in 1:nrow(df.key.weight)){
      if(df.movie.weight$plot_keywords[[i]][j] == df.key.weight[k,1]){
        for(l in 1:(length(df.movie.weight)-3)){
          df.movie.weight[i,(l+3)] <- df.movie.weight[i,(l+3)] + df.key.weight[k,(l+1)]
        }
        break
      }
    }
  }
}

#Choosing the highest column as the dominant genre
df.movie.weight.numeric <- subset(df.movie.weight, select = -c(plot_keywords, movie_title,words))
df.movie.weight$maxcol <- colnames(df.movie.weight.numeric)[apply(df.movie.weight.numeric,1,which.max)]

#SUMMING UP MOVIE GENRE COUNT -------------------------------------------------------------------------
#Grabbing new set of df for movies
df.movie.count <- dfraw
#Removing unnecessary data
df.movie.count <- subset(df.movie.count, !is.na(gross))
df.movie.count <- subset(df.movie.count, !is.na(duration))
df.movie.count <- subset(df.movie.count, !is.na(budget))
df.movie.count <- subset(df.movie.count, title_year >= 2000)
df.movie.count <- df.movie.count[!duplicated(df.movie.count$movie_title),]
df.movie.count <- subset(df.movie.count, select = c(plot_keywords, movie_title))

#separating plot_keywords into a list
df.movie.count$plot_keywords <- as.character(df.movie.count$plot_keywords)
df.movie.count$plot_keywords <- strsplit(df.movie.count$plot_keywords,"|", fixed = T)

#initialising the weight columns for df.movie.weight
df.movie.count[,colnames(df.key.count)] <- 0
#changing words from factor to character
df.key.count$words <- as.character(df.key.count$words)

#Sums up amount of weight to each row based on keywords of the movie
for (i in 1:nrow(df.movie.count)){
  print(i)
  if(lengths(df.movie.count$plot_keywords[i]) == 0){
    next
  }
  for (j in 1:lengths(df.movie.count$plot_keywords[i])) {
    for(k in 1:nrow(df.key.count)){
      if(df.movie.count$plot_keywords[[i]][j] == df.key.count[k,1]){
        for(l in 1:(length(df.movie.count)-3)){
          df.movie.count[i,(l+3)] <- df.movie.count[i,(l+3)] + df.key.count[k,(l+1)]
        }
        break
      }
    }
  }
}

#Choosing the highest column as the dominant genre
df.movie.count.numeric <- subset(df.movie.count, select = -c(plot_keywords, movie_title,words,maxcol))
df.movie.count$maxcol <- colnames(df.movie.count.numeric)[max.col(df.movie.count.numeric,
                                                                  ties.method = "random")]

#to prevent rerunning the application (Weight)
df.movie.weight2 <- df.movie.weight
domGenLab <-  c("Action","Adventure","Animation","Biography","Comedy","Crime","Documentary","Drama",
                "Family","Fantasy","History","Horror","Music","Musical","Mystery","Romance","SciFi",
                "Sport","Thriller","War","Western")
df.movie.weight2$dominantGenre <- factor(df.movie.weight2$maxcol, labels = domGenLab)

#to prevent rerunning the application (Count)
df.movie.count2 <- df.movie.count
domGenLab2 <-  c("Action","Adventure","Animation","Biography","Comedy","Crime","Documentary","Drama",
                "Family","Fantasy","History","Horror","Music","Musical","Mystery","Romance","SciFi","None",
                "Sport","Thriller","War","Western")
df.movie.count2$dominantGenre <- factor(df.movie.count2$maxcol, labels = domGenLab2)

summary(factor(df.movie.weight2$dominantGenre))
summary(factor(df.movie.count2$dominantGenre))

#FURTHER DATA CLEANING ---------------------------------------------------------------------------------

df.final <- dfraw

#Removing data without gross 
df.final <- subset(df.final, !is.na(gross))
#Removing data without duration
df.final <- subset(df.final, !is.na(duration))
#Removing data without budget
df.final <- subset(df.final, !is.na(budget))
#Subsetting only recent movies (Title year >= 2000 only)
df.final <- subset(df.final, title_year >= 2000)

#Removing duplicated movies
df.final <- df.final[!duplicated(df.final$movie_title),]


#Choosing only the highest facebook likes for the three actors
df.final$actor_fb_likes <- pmax(df.final$actor_1_facebook_likes, df.final$actor_2_facebook_likes,
                                df.final$actor_3_facebook_likes, na.rm = T)

#Converting unavailable information to NA
df.final$color[df.final$color == ""] <- NA  
df.final$director_name[df.final$director_name == ""] <- NA
df.final$actor_3_name[df.final$actor_3_name == ""] <- NA
df.final$content_rating[df.final$content_rating == ""] <- NA


#Eliminating further variables
df.final <- subset(df.final, select = -c(title_year, language, content_rating, country,
                               actor_3_name, actor_1_name, actor_2_name,
                               director_name, actor_2_facebook_likes, 
                               actor_3_facebook_likes, actor_1_facebook_likes, num_critic_for_reviews,
                               num_user_for_reviews, num_voted_users, color, movie_imdb_link, aspect_ratio))
#Merging with dominant genre column
df.final2 <- join_all(list(df.final, df.movie.count2), by = "movie_title", type = "left")
df.final2 <- subset(df.final2, select = c(gross, duration, budget,imdb_score ,dominantGenre,
                                          director_facebook_likes,cast_total_facebook_likes, 
                                          facenumber_in_poster, movie_facebook_likes, actor_fb_likes))

#Converting NA's to Mean
df.final2$facenumber_in_poster[is.na(df.final2$facenumber_in_poster)] <- mean(df.final2$facenumber_in_poster, na.rm = T)
df.final2$actor_fb_likes[is.na(df.final2$actor_fb_likes)] <- mean(df.final2$actor_fb_likes, na.rm = T)


summary(df.final2)

write.csv(df.final2, file = "movie_team1_cleaned.csv")
