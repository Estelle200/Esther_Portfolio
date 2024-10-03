#World Life Expectancy Project (EDA)

SELECT * 
FROM world_life_expectancy;

#Checking for max and min life expectancy and life expectancy increase over 15 years.
SELECT Country, MIN(`Life expectancy`), 
MAX(`Life expectancy`), 
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years;

#Checking the average Life expectancy increase over the years.
SELECT Year, ROUND(AVG(`Life expectancy`), 2)
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year;

#Correlation between life expectancy and GDP.
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Expectancy, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Expectancy > 0
AND GDP > 0
ORDER BY GDP DESC;

#Categorizing the GDP based on life expectancy
SELECT
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_Expectancy
FROM world_life_expectancy;

#Comparing Life expectancy based on status of the country
SELECT Status, ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status;

SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status;

#Comparing BMI against life expectancy based on Country
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Expectancy, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY Country
HAVING Life_Expectancy > 0
AND BMI > 0
ORDER BY BMI;

#Rolling Total
# Checking Mortatlity rate over the years
SELECT Country, 
Year, 
`life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy;
