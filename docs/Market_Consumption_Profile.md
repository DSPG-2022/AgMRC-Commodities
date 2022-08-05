# Market Consumption Profile

#### Author: Joel Martin

<br>

This page explains the steps taken to create the market consumption profile page of the commodity reports.

<br> 

### Data Sources:

| Data Name                           | Accessed Through                    | Usage                                                                                 |
|-------------------------------------|-------------------------------------|---------------------------------------------------------------------------------------|
| ESRI Consumer Spending              | Arc GIS Pro and previous teams work | Used to find consumer spending for egg, beef, and overall food at and away from home. |
| USDA Agricultural Marketing Service | MariaDB                             | Used to find number of CSAs and farmers markets in a state.                           |
| CDC State Indicator Report          | MariaDB                             | Used to find number of food hubs in a state.                                          |
| Data Axle Genie                     | MariaDB                             | Used to find number of grocery stores and restaurants in a state.                     |

### Data Transformation:

After accessing 