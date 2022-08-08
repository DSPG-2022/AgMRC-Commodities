# Data Science for the Public Good

The Data Science for the Public Good (DSPG) Young Scholars program is an immersive summer program that engages students from across Iowa to work together on projects that address local and state government challenges around critical social issues relevant in the world today. Learn more about the program [here](https://dspg.iastate.edu/).

<br>

## AgMRC Commodity Reports
AGMRC Commodity Reports in tableau can be used as preliminary research in determining current production, market analysis, demographic data and price points. It can be useful in applying for a wide variety of grant funding, financial institutional loans, etc. The customizable marketing studies provide Value Added Producer Grant (VAPG) applicants with market intelligence that can easily be incorporated into feasibility studies and business plans that support the application process.

<br>

## **Objectives**

<br>

Develop end to end automated report:
- create two commodity reports(Egg and Beef)
- data discovery to find data sources to create finer detailed final product
- explore new and interesting infographic techniques applicable to increased understanding
- streamline all reports with better filters to handle differing data based on geography and year
- Use tools like R for data manipulation


<br>

## **Egg/Beef Commodity Report**

<br>

#### Cover Page (Egg/Beef)
- This page includes overview of the commodity and the resources

![image](https://user-images.githubusercontent.com/17107300/183332572-bb81e3ad-74c0-439f-9792-a21c691480cc.png)


<br>

#### Market and Harvest Trends

- It includes information on Production, sales, price etc.,
- Analyzing Production Trends(in dozens by states and over the years)
- Organic Sales(in $)
- Egg/Cattle price received in $/dozen over the years 
- Frozen Stocks






![image](https://user-images.githubusercontent.com/17107300/183332789-fad814e3-7ff2-4e4c-9289-d20fe76eacfd.png)

<br>


#### Market Consumption Profile

- This page is an overview of the market consumption profile and data behind it
- It has yearly beef expenditure, changes and comparison with national average



![Market Consumption Page](Images/Market_Consumption_Page.jpg)



<br>


#### Demographic Profile – Part 1 & Part 2

- It has demographics information like population, race, monthly precipitation info of Iowa, National Level Local Food Market Locations and statewide agricultural export percentages

![image](https://user-images.githubusercontent.com/17107300/183333277-ee59fca9-1ad4-4dd7-80dc-45819a18ae51.png)


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

## **Code**

<br>

Corresponding code is available on:

- [GitHub Repository](https://github.com/DSPG-2022/AgMRC-Commodities/tree/main/Codes)
- For the Final Presentation click [here](https://github.com/DSPG-2022/AgMRC-Commodities/tree/main/Presentation)
- Foe the Final Dashboards click [here](https://prod-useast-b.online.tableau.com/#/site/isueoced/views/BeefCommodityReport/MarketTrends?%3Adisplay_count=n&%3Aorigin=viz_share_link&%3AshowAppBanner=false&%3AshowVizHome=n)

<br>


## **Team**

<br>

The team  brought together backgrounds in Computer Science, Data Science, Economics, and Political Science, with interests in applications of technical skills to achieve meaningful impacts for decision making processes related to products at the local level.

- **Rakesh Shah** - Team Leader, Iowa State University
- **Muskan Tantia** - Graduate fellow, Iowa State University, Computer Science
- **Maxwell Skinner** - Intern, Iowa State University, Data Science & Political Science
- **Joel Martin** - Intern, Iowa State University, Data Science
- **Tanishq Jain** - Intern, Clemson University, Statistics & Data Science

<br>

