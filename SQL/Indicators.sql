--- World Bank Dataset Analysis
--- Economic Growth and Development Queries

-- Query to obtain an overview of the data:
SELECT * FROM ese_indicators;

-- Query to check and remove duplicates (by creating a temporary table without duplicates, using CTE's)

-- Query to check and replace missing values (using IFNULL to replace missing values):

-- Query to determine minimum and maximum GDP per Capita per year for each country:
SELECT DISTINCT Year, Country, 
                min(gdp_per_capita) AS min_gdp,
                max(gdp_per_capita) AS max_gdp
FROM ese_indicators
GROUP BY YEAR, COUNTRY;

-- Query to categorize (developed/developing/emerging) and assess each country's standard of living by their GDP per Capita using CASE statement:

-- Query to analyze YoY growth of GDP per Capita for each country using LEAD/LAG Functions:

