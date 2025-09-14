--Listings By neighbourhood group--
SELECT neighbourhood_group, COUNT(*) AS LISTINGS
From helical-land-454919-i7.Airbnb.airbnb
GROUP BY neighbourhood_group
ORDER BY COUNT(*) DESC;

--Distribution of room types across nyc--
Select room_type AS TYPE, COUNT(ID) AS LISTING
FROM `Airbnb.airbnb`
GROUP BY TYPE 
ORDER BY LISTING DESC;

--Avg of listing grouped by neigbhourhood and room type--
SELECT  neighbourhood_group AS BOROUGH, room_type AS TYPE , ROUND(AVG(price),2) AS AVG_PRICE,
FROM `Airbnb.airbnb`
GROUP BY neighbourhood_group, room_type;

--No hosts based on host type (multi property pr single property)--
WITH HOST_COUNT AS (
  SELECT 
    host_id,
    COUNT(id) AS no_of_listings
  FROM `Airbnb.airbnb`
  GROUP BY host_id
)
SELECT 
  CASE 
    WHEN no_of_listings > 1 THEN "Multiple_Properties"
    ELSE "Single_Property"
  END AS host_type,
  COUNT(*) AS host_count
FROM HOST_COUNT
GROUP BY host_type;

--do multi property hosts charge more--
WITH HOST_COUNT AS (
  SELECT 
    host_id,
    COUNT(id) AS no_of_listings
  FROM `Airbnb.airbnb`
  GROUP BY host_id
)
SELECT 
  CASE 
    WHEN no_of_listings > 1 THEN "Multiple_Properties"
    ELSE "Single_Property"
  END AS host_type,
  COUNT(*) AS host_count,ROUND(AVG(a.price),2) AS avg_price
FROM `Airbnb.airbnb` A
JOIN HOST_COUNT ON A.host_id = HOST_COUNT.host_id
WHERE a.price BETWEEN 10 AND 1000
GROUP BY host_type;


--neighbourhood groups with most reveiws--
SELECT neighbourhood_group , 
SUM(number_of_reviews) AS Total_reviews ,
AVG(number_of_reviews) AS AVG_reviews
From Airbnb.airbnb
GROUP BY neighbourhood_group
ORDER BY AVG_reviews DESC;


--affect of price on reviews--
SELECT Price , 
number_of_reviews from Airbnb.airbnb
where price Between 10 AND 1000;

--neighbourhoods with year round availability--
SELECT neighbourhood_group,
neighbourhood ,
COUNT(id) AS Year_round_listing
From Airbnb.airbnb
where availability_365 = 365 
GROUP BY neighbourhood_group, neighbourhood
ORDER BY Year_round_listing DESC
LIMIT 10;
