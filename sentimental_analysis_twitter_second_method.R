library(twitteR)
library(tidyverse)
library(tidytext)

appname <- "R_Demo_Data"
key <- "u7BLabVpFhhv6s7WbHA8cLvHe"
secret <- "qGVlE47azdmGRh6TuZI1Io0rEIgufp0Xm0HguCUjXA4LtMNCJM"
access<-"1291627776009592832-5gOVKJF0AfBQEfyMm39EFQZc9J8X47"
access_secret="iZYa1zJ44jI7go1WZykHmU0q0vjgEfHcINNhYcrtWUKe6"


setup_twitter_oauth(key, secret, access, access_secret)


########## GDP

fn_twitter <- searchTwitter("#gdp",n=100)

fn_twitter_df <- twListToDF(fn_twitter) # Convert to data frame

a=write.csv(fn_twitter_df,file="gdp.csv")

############ China+ Coronavirus
virus <- searchTwitter('#China + #Coronavirus', n = 100, since = '2021-01-01')
#since: is the time frame you want the tweets
virus_df = twListToDF(virus)

a <- searchTwitter("covid",n=3)
a
b<-searchTwitter("#RProgramming",n=10,lang="en")
b
tdf<- twListToDF(a)#data frame 
write.csv(tdf,file='T4.csv',row.names = F)
#write.cse(tdf,file='~/Desktop/T3.csv',row.names=F)


#Trends
trend<- availableTrendLocations()
head(trend)#woeid: where on earth ID
trend


# getting trends

world<-getTrends(1)
world
head(world)


tr<-getTrends(2295420)
head(tr,n=3)



#user timeline
t<-getUser('MSDhoni')
t
a<-userTimeline(t,n=4)# retreive recent trends(n=2)





library(rtweet)

## search for 500 tweets using the #rstats hashtag
rstats_tweets <- search_tweets(q = "#rstats",
                               n = 500)
#1) q: the query word that you want to look for
#2) n: the number of tweets that you want returned. 
#             user can request up to a maximum of 18,000 tweets.

# view the first 3 rows of the dataframe
head(rstats_tweets, n = 3)
rstats_tweets$text


# find recent tweets with #rstats but ignore retweets
rstats_tweets <- search_tweets("#rstats", n = 500,
                               include_rts = FALSE)
# view top 2 rows of data
head(rstats_tweets, n = 2)

# view column with screen names - top 6
head(rstats_tweets$screen_name)

# get a list of unique usernames
unique(rstats_tweets$screen_name)


# what users are tweeting with #rstats
users <- search_users("#rstats",n = 50)
# just view the first 2 users - the data frame is large!
head(users, n = 2)


# how many locations are represented
length(unique(users$location))



######  "Twitter users - unique locations "
users %>%
  ggplot(aes(location)) +
  geom_bar() + coord_flip() +
  labs(x = "Count",
       y = "Location",
       title = "Twitter users - unique locations ")





