library(rvest)
library(stringr)
#Specifying the url for desired website to be scrapped
url <-  read_html( "https://www.amazon.in/OnePlus-Mirror-Black-64GB-Memory/dp/B0756Z43QS?tag=googinhydr18418-21&tag=googinkenshoo-21&ascsubtag=aee9a916-6acd-4409-92ca-3bdbeb549f80")
#scrape title of the product> title_html <- html_nodes(webpage, 'h1#title')>
title <- html_text(url)
head(title)
title

size <- url %>%  
  html_nodes(".a-size-small") %>%  
  html_text()
size


review <- url %>%
  html_nodes(".a-size-base") %>%
  html_text()
review
head(review)
tail(review)


t <- url %>%
  html_nodes("table") %>%
  .[[1]]%>%
  html_table()
t


url %>%
  html_nodes("p") %>%
  html_text()
url


url %>% 
  html_node("div h1")%>%
  html_text()
url

