a=read.csv(file.choose(),header=TRUE)
str(a)

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


tdm<-TermDocumentMatrix(cleanset)
tdm # display information
tdm<-as.matrix(tdm)
v=sort(rowSums(tdm))

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

