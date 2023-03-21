library(twitteR)
library(ggplot2)
library(syuzhet)

appname <- "R_Demo_Data"
key <- "u7BLabVpFhhv6s7WbHA8cLvHe"
secret <- "qGVlE47azdmGRh6TuZI1Io0rEIgufp0Xm0HguCUjXA4LtMNCJM"
access<-"1291627776009592832-5gOVKJF0AfBQEfyMm39EFQZc9J8X47"
access_secret="iZYa1zJ44jI7go1WZykHmU0q0vjgEfHcINNhYcrtWUKe6"






setup_twitter_oauth(key, secret, access, access_secret)



tweets_tech <- searchTwitter("#UBER", n=100,lang = "en")


## data cleaning
tech_tweets <- twListToDF(tweets_tech)



tech_text<- tech_tweets$text

tech_text<- tolower(tech_text)
tech_text <- gsub("rt", "", tech_text)
tech_text <- gsub("@\\w+", "", tech_text)
tech_text <- gsub("[[:punct:]]", "", tech_text)

#getting emotions using in-built function



mysentiment_tech<-get_nrc_sentiment((tech_text))

#calculationg total score for each sentiment

Sentimentscores_tech<-data.frame(colSums(mysentiment_tech[,]))



names(Sentimentscores_tech)<-"Score"
Sentimentscores_tech<-cbind("sentiment"=rownames(Sentimentscores_tech),Sentimentscores_tech)
rownames(Sentimentscores_tech)<-NULL

#*************************************************************************************


ggplot(data=Sentimentscores_tech,aes(x=sentiment,y=Score))+
  geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("scores")+ggtitle("UBER")





l=get_nrc_sentiment('ugly')
o=get_nrc_sentiment('delay')
p=get_nrc_sentiment('trust')
p1=get_nrc_sentiment('happy')
p2=get_nrc_sentiment('sad')
p2=get_nrc_sentiment('joy')



