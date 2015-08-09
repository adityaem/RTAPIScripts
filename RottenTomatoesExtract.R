library(RJSONIO)
library(xlsx)
library(jsonlite)
library(dplyr)
#Read input List
RTList <- read.xlsx("IMDBRTMasterList.xlsx", sheetName = "Sheet1")

for (i in 1:nrow(RTList)) {
  print(RTList[i, "id"])
  #Set 5 Sec Delay/Record
  p1 <- proc.time()
  Sys.sleep(5)
  proc.time() - p1 # The cpu usage should be negligible
  # do more things with the data frame...
  RTRaw <-fromJSON(paste("http://api.rottentomatoes.com/api/public/v1.0/movies/",RTList[i, "id"],".json?apikey=rmsva3gj24wbtgwayk6bsdqj",sep = ""))

  RTID<-RTRaw['id']
  RTTitle<-RTRaw['title']
  RTyear<-RTRaw['year']
  RTmpaarating <-RTRaw['mpaa_rating']
  RTruntime <-RTRaw['runtime']
  RTratings <-RTRaw['ratings']
  RTRow <-c(RTID,RTTitle,RTyear, RTmpaarating,RTruntime,RTratings)
  write.table(RTRow, paste("c:/sf/output/",RTList[i, "id"],".csv",sep = ","))
 
}

file_list <- list.files("c:/sf/output/", pattern=".csv", full.names=T)

combined_files <- do.call("rbind", lapply(file_list, read.csv))




