library(twitteR)
library(ggplot2)
library(syuzhet)


appname <- "DipK"
key <- "hVmkA8klKaRoyaWIMfcKVI8In"
secret <- "nJ8CQLyG79NSS6kjqdi3A3sJM0DiZkxkMLkj7DiVtwQH9V01fc"
access<-"1089743576982945792-k0QnskV7AHxE7becjFFBngIWoaKsJU"
access_secret="fWCs6agIte2x6H7lYq5L1UnjqQDQ2Zqqg37FBla6E3H1s"

setup_twitter_oauth(key, secret, access, access_secret)



tweets_tech <- searchTwitter("#Python", n=100,lang = "en")


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


tweets_tech1 <- searchTwitter("#R_program", n=100,lang = "en")


## data cleaning
tech_tweets1 <- twListToDF(tweets_tech1)
tech_text1<- tech_tweets1$text
tech_text1<- tolower(tech_text1)
tech_text1 <- gsub("rt", "", tech_text1)
tech_text1 <- gsub("@\\w+", "", tech_text1)
tech_text1 <- gsub("[[:punct:]]", "", tech_text1)

#getting emotions using in-built function
mysentiment_tech1<-get_nrc_sentiment((tech_text1))

#calculationg total score for each sentiment
Sentimentscores_tech1<-data.frame(colSums(mysentiment_tech1[,]))

names(Sentimentscores_tech)<-"Python","R program"
Sentimentscores_tech<-cbind("sentiment"=rownames(Sentimentscores_tech),Sentimentscores_tech,Sentimentscores_tech1)
rownames(Sentimentscores_tech)<-NULL

#*************************************************************************************

ggplot(data=Sentimentscores_tech,aes(x=sentiment,y=Score))+
  geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("scores")+ggtitle("GDP")





l=get_nrc_sentiment('ugly')
o=get_nrc_sentiment('delay')
p=get_nrc_sentiment('trust')
p1=get_nrc_sentiment('happy')
p2=get_nrc_sentiment('sad')
p2=get_nrc_sentiment('joy')



