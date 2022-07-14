library(tidyr)
library(dplyr)
library(stringr)
library(stringdist)
library(tm)

# read in data
esri_2000_2010 <- read.csv(file.choose(), header=TRUE, stringsAsFactors=FALSE, check.names = FALSE)
esri_2021_2026 <- read.csv(file.choose(), header=TRUE, stringsAsFactors=FALSE, check.names = FALSE)

# change 2000/2010 data from tract to county level
esri_2000_2010_new <- esri_2000_2010 %>%
  group_by(stateFIPS,countyFIPS) %>%
  summarise_at(vars(5:44), list(name = mean))

# remove column name ends
for (col in 3:ncol(esri_2000_2010_new)){
  colnames(esri_2000_2010_new)[col] <-  sub("_name.*", "", colnames(esri_2000_2010_new)[col])
}

# Rename columns in 2021/2026 data
colnames(esri_2021_2026)[1] <- "countyFIPS"
colnames(esri_2021_2026)[2] <- "countyName"
colnames(esri_2021_2026)[3] <- "stateName"

# update state names in 2021/2026 data
stateNames <- rep(NA, dim(esri_2021_2026)[1])

index <- 0

for(state in esri_2021_2026$stateName){
  
  state <- str_trim(state)
  index <- index + 1
  
  if(is.na(state)){
    stateNames[index] <- NA
  }
  else if(state == 'DC'){
    stateNames[index] <- 'District of Columbia'
  }
  else {
    stateNames[index] <- state.name[grep(state, state.abb)]
  }
}

esri_2021_2026$stateName <- stateNames

# get columns of population data from esri 2021 and 2026 data and drop from same data
esri_2021_2026_population <- esri_2021_2026[c(1:3,46:47)]
esri_2021_2026_updated <- subset(esri_2021_2026, select = -c(46:47))

# join data
esri_cleaned <- merge(x = esri_2000_2010_new, y = esri_2021_2026_updated, by = "countyFIPS", all.y = TRUE)

# remove word county from county name
stopword = c("County")
x  = esri_cleaned$countyName
x  =  removeWords(x,stopword)
esri_cleaned$countyName <- x

# add 0 to start of 4 digit fips since they have been dropped
countyFIPS <- vector(length = dim(esri_cleaned)[1])

index <- 0

## !! Caution !! May take awhile to run !!
for(x in esri_cleaned$countyFIPS){
  index <- index + 1
  if(nchar(x) == 4){
    countyFIPS[index] <- paste0("0",x)
  }
  else {
    countyFIPS[index] <- x
  }
}

esri_cleaned$countyFIPS <- countyFIPS

# save wide format to file
write.csv(esri_cleaned, "C:/Users/joelm/Documents/GitHub/AgMRC-Commodities/Joel_Martin/Data/esri_food_prefs_2000_2010_2021_2026_cleaned_wide.csv", row.names = FALSE)

# change form to long
esri_cleaned <- esri_cleaned %>%
  pivot_longer(
    -c(1:2,43:44),
    names_to = "category",
    values_to = "dollars"
  )

# round to 2 decimal
esri_cleaned$dollars <- round(esri_cleaned$dollars, digit = 2)

# split to get Year from Category
esri_cleaned <- esri_cleaned %>%
  separate(category,into = c('year','category'),sep = "_",remove = FALSE,extra = "merge")

# make countyFIPS a char column
esri_cleaned$countyFIPS <-as.character(esri_cleaned$countyFIPS)

# write long format to file
write.csv(esri_cleaned, "C:/Users/joelm/Documents/GitHub/AgMRC-Commodities/Joel_Martin/Data/esri_food_prefs_2000_2010_2021_2026_cleaned_long.csv", row.names = FALSE)
