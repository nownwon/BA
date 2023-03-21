install.packages("RGoogleAnalytics")
library(RGoogleAnalyticsPremium)

client_id <- "375771870105-dlhu23ucu0r42qc029v0a9jhkjabaqml.apps.googleusercontent.com"
client_secret <- "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"

token<- Auth(client_id,client_secret)

ValidateToken(token)

query.list <- Init(start.date="2023-03-03",
                   end.date="2023-03-03",
                   dimensions="ga:month,ga.year",
                   metrics="ga:itemRevenue",
                   max.results = 100,
                   sort="ga:year",
                   table.id="ga:92320289")
ga.query<-QueryBuilder(query.list)

ga.data<-GetReportData(ga.query,token)

head(ga.data)

