library(sentimentr)
some_text<-c('hello','good','bye','anger')
sentiment(some_text)

extract_sentiment_terms(some_text)
plot(sentiment(some_text))


mytext <- c(
  'do you like it?  But I hate really bad dogs',
  'I am the best friend.',
  'Do you really like it?  I\'m not a fan'
)
mytext <- get_sentences(mytext)
sentiment_by(mytext)
sentiment(mytext)
plot(sentiment(mytext))




