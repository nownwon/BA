library(sentimentr)


a=read.csv("D:/Class files/Module 3/INTM577(BA2)/gdp.csv")
some_text<-a$text
sentiment(some_text)

extract_sentiment_terms(some_text)
plot(sentiment(some_text))

