create table alcohol_consumption (country varchar(250), total_consumption numeric, recorded_consumption numeric,
								  unrecorded_consumption numeric, beer_percentage numeric, wine_percentage
 numeric, spirits_percentage numeric, other_percentage numeric, "2020_projection" numeric, "2025_projection" numeric);

--Checking for missing values
Select * from alcohol_consumption where (beer_percentage, wine_percentage,spirits_percentage, other_percentage) is null
--Replacing the missing values with 0
UPDATE alcohol_consumption SET beer_percentage=0 WHERE beer_percentage IS NULL
UPDATE alcohol_consumption SET wine_percentage=0 WHERE wine_percentage IS NULL
UPDATE alcohol_consumption SET spirits_percentage=0 WHERE spirits_percentage IS NULL
UPDATE alcohol_consumption SET other_percentage=0 WHERE other_percentage IS NULL

--Looking at top 10 countries with the highest total consumption
Select * from alcohol_consumption order by total_consumption desc LIMIT 10

--Looking at top 10 countries by beer consumption
Select * from alcohol_consumption order by beer_percentage desc LIMIT 10

--Looking at top 10 countries by wine consumption
Select * from alcohol_consumption order by wine_percentage desc LIMIT 10

--Looking at top 10 countries by wine consumption
Select * from alcohol_consumption order by spirits_percentage desc LIMIT 10

--Getting beer_consumption, wine_consumption, spirit_consumption, other_consumption in litres_per_capita 2016
Select country, (total_consumption * beer_percentage/100) as beer_consumption, (total_consumption * wine_percentage/100) as wine_consumption, 
(total_consumption * spirits_percentage/100) as spirits_consumption, (total_consumption * other_percentage/100) as other_consumption from alcohol_consumption

--Getting the total beer_consumption, wine_consumption, spirit_consumption, other_consumption in litres_per_capita 2016
Select MAX(total_consumption * beer_percentage/100) as total_beer_consumption, MAX(total_consumption * wine_percentage/100) as total_wine_consumption, 
MAX(total_consumption * spirits_percentage/100) as total_spirits_consumption, MAX(total_consumption * other_percentage/100) as total_other_consumption from alcohol_consumption
--Beer is the most consumed alcoholic beverage globally, followed by spirits, and wine comes in last.

Select * from alcohol_consumption


--Summary statistics from 2020 projection
WITH RECURSIVE
summary_stats AS
(
 SELECT 
  ROUND(AVG("2020_projection"), 2) AS mean,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY "2020_projection") AS median,
  MIN("2020_projection") AS min,
  MAX("2020_projection") AS max,
  MAX("2020_projection") - MIN("2020_projection") AS range,
  ROUND(STDDEV("2020_projection"), 2) AS standard_deviation,
  ROUND(VARIANCE("2020_projection"), 2) AS variance,
  PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY "2020_projection") AS q1,
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY "2020_projection") AS q3
   FROM alcohol_consumption
),
row_summary_stats AS
(
SELECT 
 1 AS sno, 
 'mean' AS statistic, 
 mean AS value 
  FROM summary_stats
UNION
SELECT 
 2, 
 'median', 
 median 
  FROM summary_stats
UNION
SELECT 
 3, 
 'minimum', 
 min 
  FROM summary_stats
UNION
SELECT 
 4, 
 'maximum', 
 max 
  FROM summary_stats
UNION
SELECT 
 5, 
 'range', 
 range 
  FROM summary_stats
UNION
SELECT 
 6, 
 'standard deviation', 
 standard_deviation 
  FROM summary_stats
UNION
SELECT 
 7, 
 'variance', 
 variance 
  FROM summary_stats
UNION
SELECT 
 9, 
 'Q1', 
 q1 
  FROM summary_stats
UNION
SELECT 
 10, 
 'Q3', 
 q3 
  FROM summary_stats
UNION
SELECT 
 11, 
 'IQR', 
 (q3 - q1) 
  FROM summary_stats
UNION
SELECT 
 12, 
 'skewness', 
 ROUND(3 * (mean - median)::NUMERIC / standard_deviation, 2) AS skewness 
  FROM summary_stats
)
SELECT * 
 FROM row_summary_stats
order by sno

--Summary statistics from 2025_projection
WITH RECURSIVE
summary_stats AS
(
 SELECT 
  ROUND(AVG("2025_projection"), 2) AS mean,
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY "2025_projection") AS median,
  MIN("2025_projection") AS min,
  MAX("2025_projection") AS max,
  MAX("2025_projection") - MIN("2025_projection") AS range,
  ROUND(STDDEV("2025_projection"), 2) AS standard_deviation,
  ROUND(VARIANCE("2025_projection"), 2) AS variance,
  PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY "2025_projection") AS q1,
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY "2025_projection") AS q3
   FROM alcohol_consumption
),
row_summary_stats AS
(
SELECT 
 1 AS sno, 
 'mean' AS statistic, 
 mean AS value 
  FROM summary_stats
UNION
SELECT 
 2, 
 'median', 
 median 
  FROM summary_stats
UNION
SELECT 
 3, 
 'minimum', 
 min 
  FROM summary_stats
UNION
SELECT 
 4, 
 'maximum', 
 max 
  FROM summary_stats
UNION
SELECT 
 5, 
 'range', 
 range 
  FROM summary_stats
UNION
SELECT 
 6, 
 'standard deviation', 
 standard_deviation 
  FROM summary_stats
UNION
SELECT 
 7, 
 'variance', 
 variance 
  FROM summary_stats
UNION
SELECT 
 9, 
 'Q1', 
 q1 
  FROM summary_stats
UNION
SELECT 
 10, 
 'Q3', 
 q3 
  FROM summary_stats
UNION
SELECT 
 11, 
 'IQR', 
 (q3 - q1) 
  FROM summary_stats
UNION
SELECT 
 12, 
 'skewness', 
 ROUND(3 * (mean - median)::NUMERIC / standard_deviation, 2) AS skewness 
  FROM summary_stats
)
SELECT * 
 FROM row_summary_stats
order by sno