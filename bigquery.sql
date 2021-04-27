# 1- Exploratory Data Analysis, getting a better sense of data

select min(start_station_id), max(start_station_id), count(distinct start_station_id)
FROM
    `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
    starttime BETWEEN '2015-01-01'AND '2015-12-30'
;

select  EXTRACT(YEAR FROM starttime) AS year,count(distinct bikeid), count(distinct start_station_id), 
FROM
    `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
    starttime BETWEEN '2014-01-01'AND '2015-12-30'
group by 1;

select  EXTRACT(YEAR FROM starttime) AS year,count(distinct bikeid), count(distinct start_station_id), 
FROM
    `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
    starttime BETWEEN '2014-01-01'AND '2015-12-30'
group by 1;


#top ten stations for subscribers
select  start_station_id,  start_station_name, count(*) 
FROM
    `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
    starttime BETWEEN '2014-01-01'AND '2015-12-30'
# and usertype = 'Subscriber'
group by 1,2
order by 3 desc
limit 10;






# TO get a preview of the DATA
SELECT 
    *
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  starttime BETWEEN '2014-01-01' AND '2015-12-30'
LIMIT
  10; 

# TO get number OF trips yearly AND monthly
SELECT
    EXTRACT(YEAR FROM starttime) AS year,
    COUNT(*) AS num_trips
FROM
    `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
    starttime BETWEEN '2014-01-01'AND '2015-12-30'
GROUP BY
    year;
    
SELECT
    EXTRACT(YEAR FROM starttime) AS year,
    EXTRACT(Month FROM starttime) AS month,
    COUNT(*) AS num_trips
FROM
    `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
  starttime BETWEEN '2014-01-01' AND '2015-12-30'
GROUP BY
    year,
    month
ORDER BY
    year,
    month;
     
# TO get number OF trips yearly AND monthly AND gender
SELECT
    EXTRACT(YEAR FROM starttime) AS year,
    EXTRACT(Month FROM starttime) AS month,
    gender,
    COUNT(*) AS num_trips
FROM
    `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
    starttime BETWEEN '2014-01-01' AND '2015-12-30'
GROUP BY
    year,
    month,
    gender
ORDER BY
    year,
    month,
    gender; 

# TO get number OF trips yearly AND monthly AND BY gender AND user type
SELECT
    EXTRACT(YEAR FROM starttime) AS year,
    EXTRACT(Month FROM starttime) AS month,
    gender,
    usertype,
    COUNT(*) AS num_trips
FROM
    `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
    starttime BETWEEN '2014-01-01'AND '2015-12-30'
GROUP BY
    year,
    month,
    gender,
    usertype
ORDER BY
    year,
    month,
    gender;
  

#######################################################################
# 2- Creating features, index and deeper dive analysis  

Begin
create temp table out_trips as  
SELECT 
        EXTRACT(YEAR FROM starttime) AS year,
        start_station_id as station_id,
        COUNT(*) AS num_trips,
    FROM
        `bigquery-public-data.new_york_citibike.citibike_trips`
    WHERE
        starttime BETWEEN '2014-01-01' AND '2015-12-30'
    GROUP BY
        year,
        station_id;

create temp table in_trips as
SELECT 
    EXTRACT(YEAR FROM starttime) AS year,
    end_station_id as station_id,
    COUNT(*) AS num_trips,
FROM
   `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE
    starttime BETWEEN '2014-01-01' AND '2015-12-30'
GROUP BY
    year,
    station_id;

create temp table in_out_aggregated as
SELECT 
    year,
    station_id,
    sum(num_trips) as num_trips
FROM (
    SELECT * from out_trips 
    union all 
    SELECT * from in_trips
) 
group by  1,2;
End;


WITH station_out_start_date AS (
    SELECT start_station_id as station_id,
        MIN(starttime) AS station_first_usage
    FROM
        `bigquery-public-data.new_york_citibike.citibike_trips`
    WHERE
        starttime BETWEEN '2014-01-01' AND '2015-12-30'    
    GROUP BY 1       
), 
station_in_start_date AS (
    SELECT end_station_id AS station_id,
        MIN(stoptime) AS station_first_usage
    FROM
        `bigquery-public-data.new_york_citibike.citibike_trips`
    WHERE
        starttime BETWEEN '2014-01-01' AND '2015-12-30'   
    GROUP BY 1  
), 
operation_day AS (
    SELECT 
        station_id,
        DATE_DIFF(DATE '2016-01-01', MIN(station_first_usage), DAY) AS days_in_operation
    FROM (
        SELECT * FROM station_out_start_date
        UNION ALL
        SELECT * FROM station_in_start_date
    )
    GROUP BY 1
),
out_trips AS (
    SELECT 
        start_station_id AS station_id,
        CASE 
            WHEN EXTRACT(DAYOFWEEK FROM starttime) = 1 THEN '0'
            WHEN EXTRACT(DAYOFWEEK FROM starttime) = 7 THEN '0'
            ELSE '1'
        END AS isweekday,
        AVG(start_station_latitude) AS latitude,
        AVG(start_station_longitude) AS longitude,
        COUNT(*) AS num_trips,
        COUNTIF(usertype = 'Subscriber') AS num_trips_by_sub,
        COUNTIF(usertype = 'Customer') AS num_trips_by_cust,

    FROM
        `bigquery-public-data.new_york_citibike.citibike_trips`
    WHERE
        starttime BETWEEN '2014-01-01' AND '2015-12-30'
    GROUP BY
        station_id,
        isweekday
), 
in_trips AS (
    SELECT 
        end_station_id AS station_id,
        CASE 
            WHEN EXTRACT(DAYOFWEEK FROM starttime) = 1 THEN '0'
            WHEN EXTRACT(DAYOFWEEK FROM starttime) = 7 THEN '0'
            ELSE '1'
        END AS isweekday,
        AVG(end_station_latitude) AS latitude,
        AVG(end_station_longitude) AS longitude,
        COUNT(*) AS num_trips,
        COUNTIF(usertype = 'Subscriber') as num_trips_by_sub,
        COUNTIF(usertype = 'Customer') as num_trips_by_cust
    FROM
        `bigquery-public-data.new_york_citibike.citibike_trips`
    WHERE
        starttime BETWEEN '2014-01-01' AND '2015-12-30'
    GROUP BY
        station_id,
        isweekday
), 
in_out_aggregated AS (
    SELECT 
        station_id,
        isweekday,
        ST_GEOGPOINT(AVG(latitude), AVG(longitude)) AS geo_point,
        SUM(num_trips) AS  num_trips,
        SUM(num_trips_by_sub) AS num_trips_by_sub,
        SUM(num_trips_by_cust) AS num_trips_by_cust
    FROM (
        SELECT * FROM out_trips 
        UNION ALL  
        SELECT * FROM in_trips
    ) 
    GROUP BY 1,2
),  
in_out_aggregated_joined AS (
    SELECT 
        a.* , 
        b.days_in_operation
    FROM 
        in_out_aggregated a 
    INNER JOIN 
        operation_day b 
    ON 
        a.station_id = b.station_id
), 
rank_station_by_num_trips AS (
    SELECT 
        station_id, 
        geo_point,
        days_in_operation,
        isweekday,
        num_trips, 
        num_trips_by_sub,
        num_trips_by_cust,
        PERCENT_RANK() OVER (ORDER BY num_trips/days_in_operation ASC) AS rank_trips, # ranking stations based on normalized number of trips
    FROM 
        in_out_aggregated_joined
), 
rank_station_by_user_type AS (
    SELECT 
        station_id, 
        geo_point,
        days_in_operation,
        num_trips_by_sub,
        num_trips_by_cust,
        PERCENT_RANK() OVER (ORDER BY num_trips_by_sub/days_in_operation ASC) AS rank_trips_sub, # ranking stations based on normalized number of trips
        PERCENT_RANK() OVER (ORDER BY num_trips_by_cust/days_in_operation ASC) AS rank_trips_cust # ranking stations based on normalized number of trips
    FROM (
        SELECT 
            station_id,
            ANY_VALUE(geo_point) AS geo_point,
            ANY_VALUE(days_in_operation) AS days_in_operation,
            SUM(num_trips_by_sub) AS num_trips_by_sub,
            SUM(num_trips_by_cust) AS num_trips_by_cust
        FROM 
            in_out_aggregated_joined
        GROUP BY 
            station_id
        )
), 
feature_weekend_traffic AS (
    SELECT 
        station_id, 
        CASE 
            WHEN rank_trips >= 0.75 THEN 'Weekend High Traffic'
            WHEN rank_trips < 0.25 THEN 'Weekend Low Traffic'
            ELSE 'Weekend-Medium Traffic'
        END AS station_traffic_weekend
    FROM 
        rank_station_by_num_trips
    WHERE 
        isweekday = '0'
),
feature_weekday_traffic AS (
    SELECT station_id, 
        CASE 
            WHEN rank_trips >= 0.75 THEN 'Weekday High Traffic'
            WHEN rank_trips < 0.25 THEN 'Weekday Low Traffic'
            ELSE 'Weekday-Medium Traffic'
        END AS station_traffic_weekday
    FROM 
        rank_station_by_num_trips
    WHERE 
        isweekday = '1'
), 
feature_traffic_subs AS (
    SELECT 
        station_id, 
        CASE 
            WHEN rank_trips_sub >= 0.75 THEN 'Subscriber High Demand'
            WHEN rank_trips_sub < 0.25 THEN 'Subscriber Low Demand'
            ELSE 'Subscriber Medium Demand'
        END AS subscriber_traffic
    FROM 
        rank_station_by_user_type
),
feature_traffic_cust AS (
    SELECT 
        station_id, 
        CASE 
            WHEN rank_trips_cust >= 0.75 THEN 'Customer High Demand'
            WHEN rank_trips_cust < 0.25 THEN 'Customer Low Demand'
            ELSE 'Customer Medium Demand'
        END AS customer_traffic
    FROM 
        rank_station_by_user_type
),
final_features AS (
    SELECT  
        a.station_id, 
        ANY_VALUE(geo_point) AS geo_point,
        ANY_VALUE(days_in_operation) AS days_in_operation,
        SUM(num_trips) AS num_trips, 
        SUM(num_trips_by_sub) AS num_trips_by_sub,
        SUM(num_trips_by_cust) AS num_trips_by_cust,
        ANY_VALUE(station_traffic_weekend) AS station_traffic_weekend,
        ANY_VALUE(station_traffic_weekday) AS station_traffic_weekday,
        ANY_VALUE(subscriber_traffic) AS subscriber_traffic,
        ANY_VALUE(customer_traffic) AS customer_traffic
    FROM 
        rank_station_by_num_trips a
    INNER JOIN 
        feature_weekend_traffic f1
    ON 
        a.station_id = f1.station_id
    INNER JOIN 
        feature_weekday_traffic f2  
    ON 
        a.station_id = f2.station_id
    INNER JOIN 
        feature_traffic_subs f3 
    ON 
        a.station_id = f3.station_id
    INNER JOIN 
        feature_traffic_cust f4
    ON 
        a.station_id = f4.station_id
    GROUP BY 
        station_id
)

SELECT * 
FROM final_features 
ORDER BY station_id
LIMIT 300;

