library(twitteR)
library(ggplot2)
library(syuzhet)
library(tm)

appname <- "R_Demo_Data"
key <- "u7BLabVpFhhv6s7WbHA8cLvHe"
secret <- "qGVlE47azdmGRh6TuZI1Io0rEIgufp0Xm0HguCUjXA4LtMNCJM"
access<-"1291627776009592832-5gOVKJF0AfBQEfyMm39EFQZc9J8X47"
access_secret<-"iZYa1zJ44jI7go1WZykHmU0q0vjgEfHcINNhYcrtWUKe6"

setup_twitter_oauth(key, secret, access, access_secret)

tweets_tech <- searchTwitter("OLA", n=100,lang = "en")

a <- twListToDF(tweets_tech)



# library(tm)

corpus = iconv(a$text, "latin1", "UTF-8")
corpus<- Corpus(VectorSource(corpus))

# corpus==>Documents/Docs
# VectorSource==>vector
# a$text==> row/records

toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs=corpus
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")
corpus=docs
corpus<- tm_map(corpus,tolower)
corpus<-tm_map(corpus,removePunctuation)# remove puntuations like , .
corpus<- tm_map(corpus,removeNumbers)
cleanset<-tm_map(corpus,removeWords,stopwords('english'))# remove common words
removeURL<- function(x)gsub('http[[:alnum:]]=','',x)
cleanset<-tm_map(cleanset,content_transformer(removeURL))
x=cleanset


tdm1<-TermDocumentMatrix(cleanset)
tdm1 # display information
tdm1<-as.matrix(tdm1)

write.csv(tdm1,"tdm1.csv")

library(syuzhet)

data=read.csv("tdm1.csv")



mysentiment_tech<-get_nrc_sentiment((data$X))

#calculationg total score for each sentiment

Sentimentscores_tech<-data.frame(colSums(mysentiment_tech[,]))



names(Sentimentscores_tech)<-"Score"
Sentimentscores_tech<-cbind("sentiment"=rownames(Sentimentscores_tech),Sentimentscores_tech)
rownames(Sentimentscores_tech)<-NULL

#*************************************************************************************

ggplot(data=Sentimentscores_tech,aes(x=sentiment,y=Score))+
  geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("scores")+ggtitle("OLA")



