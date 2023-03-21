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

tweets_tech <- searchTwitter("Cococola", n=1000,lang = "en")

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

#=============================================================

v=sort(rowSums(tdm1))

library(wordcloud)
w<-data.frame(names(v),v)

colnames(w)<-c('word','freq')
set.seed(1234)
wordcloud(words=w$word,freq=w$freq)

library(wordcloud2)


letterCloud(w,
            word="R",
            size=5,
            color="rainbow")

letterCloud(w, word = "WORDCLOUD2", wordSize = 1)
wordcloud2(w, size=10,color = "random-light", backgroundColor = "grey")
wordcloud2(w,size=5,shape = 'circle')


#==============================================================






write.csv(tdm1,"tdm1.csv")

library(syuzhet)

data=read.csv("tdm1.csv")



mysentiment_tech<-get_nrc_sentiment((data$X))

#calculationg total score for each sentiment

Sentimentscores_tech<-data.frame(colSums(mysentiment_tech[,]))

#=======================================

tweets_tech <- searchTwitter("Pepsi", n=1000,lang = "en")

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

#=============================================

v=sort(rowSums(tdm1))

library(wordcloud)
w<-data.frame(names(v),v)

colnames(w)<-c('word','freq')
set.seed(1234)
wordcloud(words=w$word,freq=w$freq)

library(wordcloud2)


letterCloud(w,
            word="R",
            size=5,
            color="rainbow")

letterCloud(w, word = "WORDCLOUD2", wordSize = 1)
wordcloud2(w, size=10,color = "random-light", backgroundColor = "grey")
wordcloud2(w,size=5,shape = 'circle')

#=============================


write.csv(tdm1,"tdm1.csv")

library(syuzhet)

data=read.csv("tdm1.csv")



mysentiment_tech1<-get_nrc_sentiment((data$X))

#calculationg total score for each sentiment

Sentimentscores_tech1<-data.frame(colSums(mysentiment_tech1[,]))


#=======================================

names(Sentimentscores_tech)<-"Cococola"
names(Sentimentscores_tech1)<-"Pepsi"
Sentimentscores_tech<-cbind("sentiment"=rownames(Sentimentscores_tech),Sentimentscores_tech,Sentimentscores_tech1)
rownames(Sentimentscores_tech)<-NULL

#*************************************************************************************

ggplot(data=Sentimentscores_tech,aes(x=sentiment,y=Cococola))+
  geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("Cococola")+ggtitle("Cococola")

ggplot(data=Sentimentscores_tech,aes(x=sentiment,y=Pepsi))+
  geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("Pepsi")+ggtitle("Pepsi")

