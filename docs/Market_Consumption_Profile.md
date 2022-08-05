# Market Consumption Profile

#### Author: Joel Martin

<br>

This page is an overview of the market consumption profile and data behind it.

##### Report Page

![Market Consumption Page](Images/Market_Consumption_Page.jpg)

##### Iowa Average Yearly Egg Expenditure Changes

![Average Yearly Egg Expenditure Changes](Images/Average_Yearly_Egg_Expenditure_Changes.jpg)

##### 2021 Iowa Average Yearly Egg Expenditure

![2021 Iowa Average Yearly Egg Expenditure](Images/2021_Iowa_Average_Yearly_Egg_Expenditure.jpg)

##### 2021 Iowa Food Expenditure

![2021 Iowa Food Expenditure](Images/2021_Iowa_Food_Expenditure.jpg)

##### Iowa Food Markets

![Iowa Food Markets](Images/Iowa_Food_Markets.jpg)

##### Iowa Farmers Markets per 100,000 People

![Iowa Farmers Markets per 100,000 People](Images/Iowa_Farmers_Markets.jpg)

<br>

### Data Sources

| Data Name                           | Level     | Accessed Through                    | Usage                                                                                 | Website                                                                                                                                                                                              |
|-------------------------------------|-----------|-------------------------------------|---------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ESRI Consumer Spending              | Primary   | Arc GIS Pro and previous teams work | Used to find consumer spending for egg, beef, and overall food at and away from home. | [https://doc.arcgis.com/en/esri-demographics/latest/regional-data/consumer-spending.htm](https://doc.arcgis.com/en/esri-demographics/latest/regional-data/consumer-spending.htm)                     |
| USDA Agricultural Marketing Service | Secondary | MariaDB                             | Used to find number of CSAs and farmers markets in a state.                           | [https://www.ams.usda.gov/](https://www.ams.usda.gov/)                                                                                                                                               |
| CDC State Indicator Report          | Secondary | MariaDB                             | Used to find number of food hubs in a state.                                          | [https://www.cdc.gov/nutrition/data-statistics/2018-state-indicator-report-fruits-vegetables.html](https://www.cdc.gov/nutrition/data-statistics/2018-state-indicator-report-fruits-vegetables.html) |
| Data Axle Genie                     | Secondary | MariaDB                             | Used to find number of grocery stores and restaurants in a state.                     | [https://www.dataaxlegenie.com/](https://www.dataaxlegenie.com/)                                                                                                                                     |

<br>

### Data Acquisition

The primary ESRI data source had 2020 and 2010 data from the previous Data Science teams work.

Through Iowa State University, I was able to get a temporary license to get access to new 2021 and 2026 predictions.

The secondary data sources were re-used from the previous teams work.

<br>

### Data Transformation

After accessing the new ESRI data through Arc GIS Pro, the following R script was used to: 

1. Combine the old ESRI data to the new ESRI data
2. Transform the data from wide format into long format
3. General cleaning of column names and standardization of state names

<br>

### ESRI Transformation Code

If you would like to see the R code used to transform the ESRI data please click [here](https://github.com/DSPG-2022/AgMRC-Commodities/blob/main/Joel_Martin/esri_data_cleaning_and_transformation_to_wide_and_long.R).