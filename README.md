# HotelDataViz-CrossPlatformSQL
This project is a journey from data integration to visualization exploring the use of SQL and data handling techniques to understand hotel booking dynamics. This project demonstrates how i work around system compatibility issues and utilize various tools to achieve the projects goals.

### Technical Challenges & Solutions
**Environment Setup:**
- **Cross-platform Compatibility:** The challenges due to the incompatibility of Mac with Power BI and MS SQL Server were solved using Azure Data Studio along with Docker to run an MS SQL Server container. This setup allowed me to manage SQL databases efectively on a non-windows machine.
- **Data Importation** Azure Data Studio doesn't support direct importation of '.xls' files. To tackle this, I exported those files to '.csv' format and used bulk importing techniques to populate my SQL database.

### Project Pipeline
- **Build a DB in SQL** I built a structured DB to effectively manage hotel booking data.
- **Develop SQL Queries** I formulated SQL queries within Azure Data Studio to perform exploratory data analysis(EDA) to retrieve the necessary data for visualization.
- **Connect to PowerBI** I connected my local MS SQL server running within the Docker on my Mac, to Power BI on a Windows machine for visualization.
- **Built Visualizations in Power BI** I created dashboards that clearly displays the findings regarding business questions from the data.

### Business Questions Addressed in Dashboard
- Is hotel growing year after year?
- Should hotel increase parking lot size?
- What are the key trends in the guest arrivals?

### Dashboard Details
**Revenue Growth Analysis:**
- A card visual displays overall revenue trends over selectable dates for all hotels and countries, controlled by slicers.
- A line chart depicts revenue fluctuations across various hotel types over time, helping in evaluating the revenue's growth or decline.

**Parking Lot Capacity Analysis**
- A card displays the total number of car spaces available, helping in evaluating if current parking spaces are adequate. Moreover, table provides more data on necessary car parking spaces and their utilization percentage, which helps in answering potential parking lot expansions.

**Guest Arrival Trends**
- A donut chart offers insights into which type of hotels attract more guests and at what times of the year which helps in identifying peak seasons.

![Screenshot 2024-04-19 110723](https://github.com/Cherukuri-Thanu/HotelDataViz-CrossPlatformSQL/assets/167354871/984cb5b0-f47e-4ec6-a8f5-eedd1d511b22)
