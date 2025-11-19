--- World Bank Dataset Analysis
--- Economic Growth and Development Queries

---Query to extract an overview of the dataset
SELECT * FROM ese_indicators;

--Query to check for missing values and replace missing values - CREATE TABLE USING WINDOW FUNCTIONS
SELECT *
FROM ese_indicators
WHERE YEAR IS NULL OR COUNTRY IS NULL OR GDP_USD IS NULL OR POPULATION IS NULL OR GDP_PER_CAPITA IS NULL OR 
LIFE_EXPECTANCY IS NULL OR UNEMPLOYMENT_RATE_PCT IS NULL OR CO2_Emissions_metric_tons_per_capita IS NULL OR Access_to_Electricity IS NULL; 
-- no records with msising values


--Query to check for duplicates
SELECT *, COUNT(*)
FROM ese_indicators
GROUP BY ALL
HAVING COUNT(*)>1; -- no records/rows with duplicates

--Query to assess minimum and maximum GDP per capita for each country per year:

SELECT DISTINCT YEAR, COUNTRY, MIN(GDP_PER_CAPITA) OVER(PARTITION BY COUNTRY ORDER BY YEAR) AS MIN_GDP_PER_CAPITA
FROM ese_indicators
GROUP BY year, country, gdp_per_capita
ORDER BY year, country;

SELECT DISTINCT YEAR, COUNTRY, MAX(GDP_PER_CAPITA) OVER(PARTITION BY COUNTRY ORDER BY YEAR) AS MAX_GDP_PER_CAPITA
FROM ese_indicators
GROUP BY year, country, gdp_per_capita
ORDER BY year, country;

--Query to assess minimum and maximum life expectancy for each country per year:

SELECT DISTINCT YEAR, COUNTRY, MIN(LIFE_EXPECTANCY) OVER(PARTITION BY COUNTRY ORDER BY YEAR) AS MIN_LIFE_EXPECTANCY
FROM ese_indicators
GROUP BY year, country, life_expectancy
ORDER BY year, country;

SELECT DISTINCT YEAR, COUNTRY, MAX(LIFE_EXPECTANCY) OVER(PARTITION BY COUNTRY ORDER BY YEAR) AS MAX_LIFE_EXPECTANCY
FROM ese_indicators
GROUP BY year, country, life_expectancy
ORDER BY year, country;

--Query to assess minimum and maximum CO2 emissions for each country per year:

SELECT DISTINCT YEAR, COUNTRY, MIN(CO2_Emissions_metric_tons_per_capita) OVER(PARTITION BY COUNTRY ORDER BY YEAR) AS MIN_CO2_Emissions_metric_tons_per_capita
FROM ese_indicators
GROUP BY year, country, co2_emissions_metric_tons_per_capita
ORDER BY year, country;

SELECT DISTINCT YEAR, COUNTRY, MAX(CO2_Emissions_metric_tons_per_capita) OVER(PARTITION BY COUNTRY ORDER BY YEAR) AS MAX_CO2_Emissions_metric_tons_per_capita
FROM ese_indicators
GROUP BY year, country, co2_emissions_metric_tons_per_capita
ORDER BY year, country;

--Query to assess minimum and maximum access to electricity for each country per year:

SELECT DISTINCT YEAR, COUNTRY, MIN(Access_to_Electricity) OVER(PARTITION BY COUNTRY ORDER BY YEAR) AS MIN_ACCESS_TO_ELECTRICITY
FROM ese_indicators
GROUP BY year, country, access_to_electricity
ORDER BY year, country;

SELECT DISTINCT YEAR, COUNTRY, MAX(Access_to_Electricity) OVER(PARTITION BY COUNTRY ORDER BY YEAR) AS MAX_ACCESS_TO_ELECTRICITY
FROM ese_indicators
GROUP BY year, country, access_to_electricity
ORDER BY year, country;

--Query to assess minimum and maximum unemployment rate for each country per year:

SELECT DISTINCT YEAR, COUNTRY, MIN(UNEMPLOYMENT_RATE_PCT) OVER(PARTITION BY COUNTRY ORDER BY YEAR) AS MIN_UNEMPLOYMENT_RATE_PCT
FROM ese_indicators
GROUP BY year, country, unemployment_rate_pct
ORDER BY year, country;

SELECT DISTINCT YEAR, COUNTRY, MAX(UNEMPLOYMENT_RATE_PCT) OVER(PARTITION BY COUNTRY ORDER BY YEAR) AS MAX_UNEMPLOYMENT_RATE_PCT
FROM ese_indicators
GROUP BY year, country, unemployment_rate_pct
ORDER BY year, country;

--Query to assess minimum and maximum population for each country per year:

SELECT DISTINCT YEAR, COUNTRY, MIN(POPULATION) OVER(PARTITION BY COUNTRY ORDER BY YEAR) AS MIN_POPULATION
FROM ese_indicators
GROUP BY year, country, population
ORDER BY year, country;

SELECT DISTINCT YEAR, COUNTRY, MAX(POPULATION) OVER(PARTITION BY COUNTRY ORDER BY YEAR) AS MAX_POPULATION
FROM ese_indicators
GROUP BY year, country, population
ORDER BY year, country;

--Query to assess minimum and maximum gdp for each country per year:

SELECT DISTINCT YEAR, COUNTRY, MIN(GDP_USD) OVER(PARTITION BY COUNTRY ORDER BY YEAR) AS MIN_GDP_USD
FROM ese_indicators
GROUP BY year, country, gdp_usd
ORDER BY year, country;

SELECT DISTINCT YEAR, COUNTRY, MAX(GDP_USD) OVER(PARTITION BY COUNTRY ORDER BY YEAR) AS MAX_GDP_USD
FROM ese_indicators
GROUP BY year, country, gdp_usd
ORDER BY YEAR, COUNTRY;

--Query to assess Year-on-Year GDP per Capita Over Time
SELECT DISTINCT YEAR, COUNTRY,
                LAG(gdp_per_capita) OVER (PARTITION BY COUNTRY ORDER BY YEAR) AS PREV_GDP_PER_CAPITA,
CASE 
    WHEN LAG(gdp_per_capita) OVER (PARTITION BY COUNTRY ORDER BY YEAR) IS NULL THEN NULL
    WHEN LAG(gdp_per_capita) OVER (PARTITION BY COUNTRY ORDER BY YEAR) IS NOT NULL THEN 
  ((gdp_per_capita - LAG(gdp_per_capita) OVER (PARTITION BY COUNTRY ORDER BY YEAR))/LAG(gdp_per_capita) OVER (PARTITION BY COUNTRY ORDER BY YEAR))*100
END AS YOY_GDP_PER_CAPITA_GROWTH_PCT
FROM ese_indicators
ORDER BY YEAR, COUNTRY;

--query to determine population per year for each country
SELECT
  YEAR,
  COUNTRY,
  POPULATION
FROM ese_indicators
ORDER BY YEAR, COUNTRY;
