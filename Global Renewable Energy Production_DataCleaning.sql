# Global Renewable Energy Production from 2000-2023 Project (Data Cleaning)
SELECT * FROM renewable_energy.global_renewable_energy_production;

#Checking for duplicate values
SELECT Country, Year , CONCAT(Country, Year) As Country_Year, COUNT(CONCAT(Country, Year)) AS count
FROM global_renewable_energy_production
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING count > 1;
# From the Output, there are no duplicate values.
