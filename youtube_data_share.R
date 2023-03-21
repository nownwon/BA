install.packages("tuber")
install.packages("tidyverse")
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


get_stats(video_id='8XAfjB0fVas')
get_stats(video_id = "N708P-A45D0")

#devtools::install_github("soodoku/tuber", build_vignettes = TRUE)

get_video_details(video_id = "N708P-A45D0")
yt_search("Barack Obama")

get_all_comments(video_id = "a-UQz7fqR3w")



#https://www.youtube.com/watch?v=UVxkn8Ynbbs

