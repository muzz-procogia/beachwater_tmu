
#Set up library and wd
library(dplyr)
library(readr)
library(plyr)
library(tidyverse)
library(purrr)
library(data.table)
setwd("/Users/racheljardine/Desktop/BEACH/Merge")

#first, read in all excel files
allbeaches20072019 <- read.csv(file="allbeaches20072019.csv", header = TRUE)
allbeaches20202021 <- read.csv(file="allbeaches20202021.csv", header = TRUE)
turbiditySS <- read.csv(file="turbiditySS.csv", header = TRUE)
turbiditymarie <- read.csv("turbiditymarie.csv", header = TRUE)

####2007/2019
#merging turbidity to 2007/2019 with marie
mariemerged20072019 <- merge(x=allbeaches20072019,y=turbiditymarie, by=c("Da","Na"), na= '')

#export marie to csv
write.csv(mariemerged20072019, "/Users/racheljardine/Desktop/BEACH/Merge/mariemerged20072019.csv", row.names=FALSE)

#merging turbidity to 2007/2019 with SS
SSmerged20072019 <- merge(x=allbeaches20072019,y=turbiditySS, by=c("Da","Na"), na= '')

#export SS to csv
write.csv(SSmerged20072019, "/Users/racheljardine/Desktop/BEACH/Merge/SSmerged20072019.csv", row.names=FALSE)

####2020/2021
#merging turbidity to 2020/2021 with marie
mariemerged20202021 <- merge(x=allbeaches20202021,y=turbiditymarie, by=c("Da","Na"), na= '')

#export marie to csv
write.csv(mariemerged20202021, "/Users/racheljardine/Desktop/BEACH/Merge/mariemerged20202021.csv", row.names=FALSE)

#merging turbidity to 2020/2021 with SS
SSmerged20202021 <- merge(x=allbeaches20202021,y=turbiditySS, by=c("Da","Na"), na= '')

#export SS to csv
write.csv(SSmerged20202021, "/Users/racheljardine/Desktop/BEACH/Merge/SSmerged20202021.csv", row.names=FALSE)



##Creating full 2020/2021 data set

full_dt = merge(allbeaches20202021, mariemerged20202021, by = c('Da', 'Na'), all = T, na='')
fullmerge20202021 = merge(full_dt, SSmerged20202021, by = c('Da', 'Na'), all = T, na='')
write.csv(fullmerge20202021, "/Users/racheljardine/Desktop/BEACH/Merge/fullmerge20202021.csv", row.names=FALSE)

##creating full 20072019 data set
full_dt = merge(allbeaches20072019, mariemerged20072019, by = c('Da', 'Na'), all = T, na='')
fullmerge20072019 = merge(full_dt, SSmerged20072019, by = c('Da', 'Na'), all = T, na='')
write.csv(fullmerge20072019, "/Users/racheljardine/Desktop/BEACH/Merge/fullmerge20072019.csv", row.names=FALSE)