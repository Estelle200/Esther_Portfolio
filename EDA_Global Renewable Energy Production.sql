#Global Renewable Energy Production EDA

SELECT *
FROM renewable_energy.global_renewable_energy_production;

#Summary statistics of renewable energy produced by different countries from 2000-2023
SELECT Country,
    MIN(SolarEnergy) AS Min_SolarEnergy,
    MAX(SolarEnergy) AS Max_SolarEnergy,
    ROUND(AVG(SolarEnergy),2) AS Avg_SolarEnergy,
    ROUND(SUM(SolarEnergy),2) AS Total_SolarEnergy,

    MIN(WindEnergy) AS Min_WindEnergy,
    MAX(WindEnergy) AS Max_WindEnergy,
   ROUND(AVG(WindEnergy),2) AS Avg_WindEnergy,
    ROUND(SUM(WindEnergy),2) AS Total_WindEnergy,

    MIN(HydroEnergy) AS Min_HydroEnergy,
    MAX(HydroEnergy) AS Max_HydroEnergy,
    ROUND(AVG(HydroEnergy),2) AS Avg_HydroEnergy,
    ROUND(SUM(HydroEnergy),2) AS Total_HydroEnergy
FROM global_renewable_energy_production
GROUP BY Country;

#Top 5 renewable energy producing countries over the years
SELECT Country, ROUND(SUM(TotalRenewableEnergy),2) AS Total_Energy_Produced
FROM global_renewable_energy_production
GROUP BY Country
ORDER BY Total_Energy_Produced DESC
LIMIT 5;

#Yearly trend of total renewable energy production
SELECT Year, ROUND(SUM(TotalRenewableEnergy),2) AS Total_Energy_Produced
FROM global_renewable_energy_production
GROUP BY Year
ORDER BY Total_Energy_Produced DESC;

#Breakdown of renewable energy sources by country
SELECT Country,
       ROUND(SUM(SolarEnergy),2) AS Total_SolarEnergy,
       ROUND(SUM(WindEnergy),2) AS Total_WindEnergy,
       ROUND(SUM(HydroEnergy),2) AS Total_HydroEnergy,
       ROUND(SUM(TotalRenewableEnergy),2) AS Total_Renewable_Energy
FROM global_renewable_energy_production
GROUP BY Country
ORDER BY Total_Renewable_Energy DESC;
#Renewable energy by source per year
SELECT Year,
       ROUND(SUM(SolarEnergy),2) AS Total_SolarEnergy,
       ROUND(SUM(WindEnergy),2) AS Total_WindEnergy,
       ROUND(SUM(HydroEnergy),2) AS Total_HydroEnergy,
       ROUND(SUM(TotalRenewableEnergy),2) AS Total_Renewable_Energy
FROM global_renewable_energy_production
GROUP BY Year
ORDER BY Year;

#Year-on-Year growth of total renewable energy production
SELECT Year,
       SUM(TotalRenewableEnergy) AS Total_Energy_Produced,
       (SUM(TotalRenewableEnergy) - LAG(SUM(TotalRenewableEnergy)) OVER (ORDER BY Year))/ 
       LAG(SUM(TotalRenewableEnergy)) OVER (ORDER BY Year) * 100 AS Yearly_Growth_Percentage
FROM global_renewable_energy_production
GROUP BY Year
ORDER BY Year;

#Germany's energy production from 2011
SELECT * 
FROM global_renewable_energy_production
WHERE Country = 'Germany' AND Year > 2010;

#Years where solar energy contributed 25% or more to the total renewable energy production
SELECT Year,
       SUM(SolarEnergy) / SUM(TotalRenewableEnergy) * 100 AS Solar_Energy_Percentage
FROM global_renewable_energy_production
GROUP BY Year
HAVING Solar_Energy_Percentage >= 25;

#Countries where total renewable energy produced exceeds 60,000
SELECT Country, ROUND(SUM(TotalRenewableEnergy),2) AS TotalEnergyProduced
FROM global_renewable_energy_production
GROUP BY Country
HAVING ROUND(SUM(TotalRenewableEnergy),2) > 60000;

#Comparing energy production in european countries
SELECT * 
FROM global_renewable_energy_production
WHERE Country IN ('Germany', 'France', 'Italy');
