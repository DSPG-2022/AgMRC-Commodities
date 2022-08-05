# Load libraries
library(tidyverse)
library(tm)

# Read in data
esri_2000_2010 <- read.csv(file.choose(), header=TRUE, stringsAsFactors=FALSE, check.names = FALSE)
esri_2021_2026 <- read.csv(file.choose(), header=TRUE, stringsAsFactors=FALSE, check.names = FALSE)

# Update 2000/2010 column names to match 2021/2026 column names
esri_2000_2010 <- esri_2000_2010 %>% 
                        rename('2000_Food_Average'                                 = 7,
                               '2000_Food_at_Home_Average'                         = 8,
                               '2000_Meat_Poultry_Fish_Eggs_Average'               = 9,
                               '2000_Fruit_Vegetables_Average'                     = 10,
                               '2000_Food_Away_from_Home_Average'                  = 11,
                               '2010_Food_Average'                                 = 12,
                               '2010_Food_at_Home_Average'                         = 13,
                               '2010_Meat_Poultry_Fish_Eggs_Average'               = 14,
                               '2010_Fruit_Vegetables_Average'                     = 15,
                               '2010_Food_Away_from_Home_Average'                  = 16,
                               '2000_Bakery_Cereal_Products_Average'               = 17,
                               '2000_Flour_Average'                                = 18,
                               '2000_Rice_Average'                                 = 19,
                               '2000_Pasta_Cornmeal_Other_Cereal_Products_Average' = 20,
                               '2000_Bread_Average'                                = 21,
                               '2000_Beef_Average'                                 = 22,
                               '2000_Pork_Average'                                 = 23,
                               '2000_Poultry_Average'                              = 24,
                               '2000_Seafood_Average'                              = 25,
                               '2000_Eggs_Average'                                 = 26,
                               '2000_Dairy_Products_Average'                       = 27,
                               '2000_Lunch_Away_from_Home_Average'                 = 28,
                               '2000_Dinner_Away_from_Home_Average'                = 29,
                               '2000_Breakfast_and_Brunch_Away_from_Home_Average'  = 30,
                               '2000_Alcoholic_Beverages_Average'                  = 31,
                               '2010_Bakery_Cereal_Products_Average'               = 32,
                               '2010_Flour_Average	2010_Rice_Average'             = 33,
                               '2010_Pasta_Cornmeal_Other_Cereal_Products_Average' = 34,
                               '2010_Bread_Average'                                = 35,
                               '2010_Beef_Average'                                 = 36,
                               '2010_Pork_Average'                                 = 37,
                               '2010_Poultry_Average'                              = 38,
                               '2010_Seafood_Average'                              = 39,
                               '2010_Eggs_Average'                                 = 40,
                               '2010_Dairy_Products_Average'                       = 41,
                               '2010_Lunch_Away_from_Home_Average'                 = 42,
                               '2010_Dinner_Away_from_Home_Average'                = 43,
                               '2010_Breakfast_and_Brunch_Away_from_Home_Average'  = 44,
                               '2010_Alcoholic_Beverages_Average'                  = 45)

# Change 2000/2010 data from tract to county level
esri_2000_2010_new <- esri_2000_2010 %>%
  group_by(stateFIPS,countyFIPS) %>%
  summarise_at(vars(5:44), list(name = mean))

# Remove word "name" from column names ends
for (col in 3:ncol(esri_2000_2010_new)){
  colnames(esri_2000_2010_new)[col] <-  sub("_name.*", "", colnames(esri_2000_2010_new)[col])
}

# Rename columns in 2021/2026 data to match column names in 2000/2010 data
esri_2021_2026 <- esri_2021_2026 %>% 
                    rename(countyFIPS = 1,
                           countyName = 2,
                           stateName = 3)

# Update state abbreviations to full names for ease of display in Tableau

    # Empty vector set to the length of the state column.
    # This method greatly increases the speed of the for loop
    # since the array is already the length it needs whereas using
    # a function such as append requires R to constantly run through
    # the entire array and update the length accordingly.
    stateNames <- rep(NA, dim(esri_2021_2026)[1])
  
    # Index to keep track of array index
    index <- 0
    
    # For each state in the stateName column
    for(state in esri_2021_2026$stateName){
      
      # Trim state of any potential spaces on the ends
      state <- str_trim(state)
      
      # Increase index (Note: R indexes start at 1)
      index <- index + 1
      
      # Checks if state is NA and updates array accordingly
      if(is.na(state)){
        stateNames[index] <- NA
      }
      
      # Checks if state is DC since this state abbreviation is not 
      # supported in the state.name functionand updates array accordingly
      else if(state == 'DC'){
        stateNames[index] <- 'District of Columbia'
      }
      
      # Gets the state name from the abbreviation and updates array accordingly
      else {
        stateNames[index] <- state.name[grep(state, state.abb)]
      }
    }
    
    # Sets the new array of state names to replace the current state name column of abbreviations
    esri_2021_2026$stateName <- stateNames

# Get columns of population data from esri 2021 and 2026 data and drop from data
esri_2021_2026_population <- esri_2021_2026[c(1:3,46:47)]
esri_2021_2026_updated <- subset(esri_2021_2026, select = -c(46:47))

# Join 2000/2010 data and 2021/2026 data
esri_cleaned <- merge(x = esri_2000_2010_new, y = esri_2021_2026_updated, by = "countyFIPS", all.y = TRUE)

# Remove word county from county names
stopword = c("County")
x  = esri_cleaned$countyName
x  =  removeWords(x,stopword)
esri_cleaned$countyName <- x

# Add 0 to start of 4 digit fips since they have been dropped

    # Empty vector set to the length of the esri_cleaned dataset.
    # This method greatly increases the speed of the for loop
    # since the array is already the length it needs whereas using
    # a function such as append requires R to constantly run through
    # the entire array and update the length accordingly.
    countyFIPS <- vector(length = dim(esri_cleaned)[1])
    
    # Index to keep track of array index
    index <- 0
    
    # For each countyFIPS in the countyFIPS column
    for(x in esri_cleaned$countyFIPS){
      
      # Increase index (Note: R indexes start at 1)
      index <- index + 1
      
      # If the number of characters is 4 this indicates that
      # the 0 has been dropped from the start of the countyFIPS
      # since countFIPS are 5 digits.
      # Adds 0 if this is the case.
      if(nchar(x) == 4){
        countyFIPS[index] <- paste0("0",x)
      }
      
      # Otherwise countyFIPS is in 5 digit format.
      # add to array.
      else {
        countyFIPS[index] <- x
      }
    }
    
    # Set updated countyFIPS array to old countFIPS array
    esri_cleaned$countyFIPS <- countyFIPS

# ESRI 2000/2010/2021/2026 is now in cleaned wide format and can be saved.
    
    # Save wide format to file
    write.csv(esri_cleaned, "C:/Users/joelm/Documents/GitHub/AgMRC-Commodities/Joel_Martin/Data/esri_food_prefs_2000_2010_2021_2026_cleaned_wide.csv", row.names = FALSE)

###################        Change ESRI data into long format        ###################
# Change form to long
esri_cleaned <- esri_cleaned %>%
  pivot_longer(
    -c(1:2,43:44),
    names_to = "category",
    values_to = "dollars"
  )

# round dollar amounts to 2 decimals
esri_cleaned$dollars <- round(esri_cleaned$dollars, digit = 2)

# Split to get year from category names
esri_cleaned <- esri_cleaned %>%
  separate(category,into = c('year','category'),sep = "_",remove = FALSE,extra = "merge")

# make countyFIPS a char column
esri_cleaned$countyFIPS <-as.character(esri_cleaned$countyFIPS)

# Add 0 to start of 4 digit fips since they have been dropped

# Empty vector set to the length of the esri_cleaned dataset.
# This method greatly increases the speed of the for loop
# since the array is already the length it needs whereas using
# a function such as append requires R to constantly run through
# the entire array and update the length accordingly.
countyFIPS <- vector(length = dim(esri_cleaned)[1])

# Index to keep track of array index
index <- 0

# For each countyFIPS in the countyFIPS column
for(x in esri_cleaned$countyFIPS){
  
  # Increase index (Note: R indexes start at 1)
  index <- index + 1
  
  # If the number of characters is 4 this indicates that
  # the 0 has been dropped from the start of the countyFIPS
  # since countFIPS are 5 digits.
  # Adds 0 if this is the case.
  if(nchar(x) == 4){
    countyFIPS[index] <- paste0("0",x)
  }
  
  # Otherwise countyFIPS is in 5 digit format.
  # add to array.
  else {
    countyFIPS[index] <- x
  }
}

# Set updated countyFIPS array to old countFIPS array
esri_cleaned$countyFIPS <- countyFIPS

# ESRI 2000/2010/2021/2026 is now in cleaned long format and can be saved.

    # write long format to file
    write.csv(esri_cleaned, "C:/Users/joelm/Documents/GitHub/AgMRC-Commodities/Joel_Martin/Data/esri_food_prefs_2000_2010_2021_2026_cleaned_long.csv", row.names = FALSE)
