install.packages("rjson")
library("rjson")

data <- fromJSON(file="D:/Class files/Module 3/INTM577(BA2)/file.json")



json_data<-as.data.frame(data)



print(json_data)
