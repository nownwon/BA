
library(ggplot2)
library(syuzhet)
library(tuber) # youtube API
library(magrittr) # Pipes %>%, %T>% and equals(), extract().
library(tidyverse) # all tidyverse packages
library(purrr) # package for iterating/extracting data

client_id <- "375771870105-dlhu23ucu0r42qc029v0a9jhkjabaqml.apps.googleusercontent.com"
client_secret <- "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"


# use the youtube oauth 
yt_oauth(app_id = client_id,
         app_secret = client_secret,token= '')

data1= get_all_comments(video_id="Se28XHI2_xE")

b<-write.csv(data1,file="T5.csv",row.names=FALSE)

a<-read.csv("T5.csv")

corpus = iconv(a$textDisplay, "latin1", "UTF-8")
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


tdm2<-TermDocumentMatrix(cleanset)
tdm2 # display information
tdm2<-as.matrix(tdm2)

write.csv(tdm2,"tdm2.csv")

library(syuzhet)

data=read.csv("tdm2.csv")



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
  xlab("Sentiments")+ylab("scores")+ggtitle("Youu tube")

