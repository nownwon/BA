library(twitteR)
library(ggplot2)
library(syuzhet)
library(tm)

appname <- "DipK"
key <- "hVmkA8klKaRoyaWIMfcKVI8In"
secret <- "nJ8CQLyG79NSS6kjqdi3A3sJM0DiZkxkMLkj7DiVtwQH9V01fc"
access<-"1089743576982945792-k0QnskV7AHxE7becjFFBngIWoaKsJU"
access_secret="fWCs6agIte2x6H7lYq5L1UnjqQDQ2Zqqg37FBla6E3H1s"


setup_twitter_oauth(key, secret, access, access_secret)

tweets_tech <- searchTwitter("#Budget2023", n=500,lang = "en")

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


tdm4<-TermDocumentMatrix(cleanset)
tdm4 # display information
tdm4<-as.matrix(tdm4)

#=====================================
v=sort(rowSums(tdm4))

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

#===================================


write.csv(tdm4,"tdm4.csv")

library(syuzhet)

data=read.csv("tdm4.csv")



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
  xlab("Sentiments")+ylab("scores")+ggtitle("Budget 2023")







