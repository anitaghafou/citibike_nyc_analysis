DROP TABLE IF EXISTS citi_bike.trips_1;
CREATE TABLE citi_bike.trips_1(
trip_duration INT,
start_time TEXT,
stop_time TEXT,
start_station_id TEXT,
start_station_name TEXT,
start_station_latitude TEXT,
start_station_longitude TEXT,
end_station_id TEXT,
end_station_name TEXT,
end_station_latitude TEXT,
end_station_longitude TEXT,
bike_id TEXT,
user_type TEXT,
birth_year TEXT,
gender TEXT) ENGINE=InnoDB;

DROP TABLE IF EXISTS citi_bike.trips_2;
CREATE TABLE citi_bike.trips_2(
trip_duration INT,
start_time TEXT,
stop_time TEXT,
start_station_id TEXT,
start_station_name TEXT,
start_station_latitude TEXT,
start_station_longitude TEXT,
end_station_id TEXT,
end_station_name TEXT,
end_station_latitude TEXT,
end_station_longitude TEXT,
bike_id TEXT,
user_type TEXT,
birth_year TEXT,
gender TEXT) ENGINE=InnoDB;


DROP TABLE IF EXISTS citi_bike.trips_3;
CREATE TABLE citi_bike.trips_3(
trip_duration INT,
start_time DATETIME,
stop_time DATETIME,
start_station_id INT,
start_station_name TEXT,
start_station_latitude DECIMAL(11,8),
start_station_longitude DECIMAL(11,8),
end_station_id INT,
end_station_name TEXT,
end_station_latitude DECIMAL(11,8),
end_station_longitude DECIMAL(11,8),
bike_id INT,
user_type INT,
birth_year INT,
gender INT) ENGINE=InnoDB;

LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201601-citibike-tripdata.csv' INTO TABLE citi_bike.trips_1 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201602-citibike-tripdata.csv' INTO TABLE citi_bike.trips_1 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201603-citibike-tripdata.csv' INTO TABLE citi_bike.trips_1 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201604-citibike-tripdata.csv' INTO TABLE citi_bike.trips_1 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201605-citibike-tripdata.csv' INTO TABLE citi_bike.trips_1 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201606-citibike-tripdata.csv' INTO TABLE citi_bike.trips_1 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201607-citibike-tripdata.csv' INTO TABLE citi_bike.trips_1 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201608-citibike-tripdata.csv' INTO TABLE citi_bike.trips_1 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201609-citibike-tripdata.csv' INTO TABLE citi_bike.trips_1 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201610-citibike-tripdata.csv' INTO TABLE citi_bike.trips_2 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201611-citibike-tripdata.csv' INTO TABLE citi_bike.trips_2 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201612-citibike-tripdata.csv' INTO TABLE citi_bike.trips_2 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201701-citibike-tripdata.csv' INTO TABLE citi_bike.trips_2 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201702-citibike-tripdata.csv' INTO TABLE citi_bike.trips_2 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201703-citibike-tripdata.csv' INTO TABLE citi_bike.trips_2 FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201704-citibike-tripdata.csv' INTO TABLE citi_bike.trips_2 FIELDS TERMINATED BY ',' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201705-citibike-tripdata.csv' INTO TABLE citi_bike.trips_2 FIELDS TERMINATED BY ',' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201706-citibike-tripdata.csv' INTO TABLE citi_bike.trips_2 FIELDS TERMINATED BY ',' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201707-citibike-tripdata.csv' INTO TABLE citi_bike.trips_2 FIELDS TERMINATED BY ',' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201708-citibike-tripdata.csv' INTO TABLE citi_bike.trips_2 FIELDS TERMINATED BY ',' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201709-citibike-tripdata.csv' INTO TABLE citi_bike.trips_2 FIELDS TERMINATED BY ',' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201710-citibike-tripdata.csv' INTO TABLE citi_bike.trips_2 FIELDS TERMINATED BY ',' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201711-citibike-tripdata.csv' INTO TABLE citi_bike.trips_2 FIELDS TERMINATED BY ',' IGNORE 1 ROWS;
LOAD DATA LOCAL INFILE '~/Desktop/citi_bike/201712-citibike-tripdata.csv' INTO TABLE citi_bike.trips_2 FIELDS TERMINATED BY ',' IGNORE 1 ROWS;

UPDATE citi_bike.trips_2 SET start_time = REPLACE(start_time, '"', ''), stop_time = REPLACE(stop_time, '"', ''), user_type = REPLACE(user_type, '"', '');

INSERT INTO citi_bike.trips_3
SELECT
trip_duration,
STR_TO_DATE(start_time, '%m/%d/%Y %H:%i:%s') as start_time,
STR_TO_DATE(stop_time, '%m/%d/%Y %H:%i:%s') as stop_time,
start_station_id,
start_station_name,
CAST(start_station_latitude AS DECIMAL(11,8)) as start_station_latitude,
CAST(start_station_longitude AS DECIMAL(11,8)) as start_station_longitude,
end_station_id,
end_station_name,
CAST(end_station_latitude AS DECIMAL(11,8)) as end_station_latitude,
CAST(end_station_longitude AS DECIMAL(11,8)) as end_station_longitude,
bike_id,
CASE user_type WHEN 'Customer' THEN 1 WHEN 'Subscriber' THEN 2 ELSE 0 END as user_type,
IF (birth_year = '' OR birth_year = 'NULL' , null, birth_year),
gender
FROM citi_bike.trips_1;


INSERT INTO citi_bike.trips_3
SELECT
trip_duration,
STR_TO_DATE(start_time, '%Y-%m-%d %H:%i:%s') as start_time,
STR_TO_DATE(stop_time, '%Y-%m-%d %H:%i:%s') as stop_time,
start_station_id,
start_station_name,
CAST(start_station_latitude AS DECIMAL(11,8)) as start_station_latitude,
CAST(start_station_longitude AS DECIMAL(11,8)) as start_station_longitude,
end_station_id,
end_station_name,
CAST(end_station_latitude AS DECIMAL(11,8)) as end_station_latitude,
CAST(end_station_longitude AS DECIMAL(11,8)) as end_station_longitude,
bike_id,
CASE user_type WHEN 'Customer' THEN 1 WHEN 'Subscriber' THEN 2 ELSE 0 END as user_type,
IF (birth_year = '' OR birth_year = 'NULL' , null, birth_year),
gender
FROM citi_bike.trips_2;

DROP TABLE IF EXISTS citi_bike.trips_1;
DROP TABLE IF EXISTS citi_bike.trips_2;

CREATE INDEX start_time_indx ON citi_bike.trips_3  (start_time);
CREATE INDEX stop_time_indx ON citi_bike.trips_3  (stop_time);
CREATE INDEX start_station_id_indx ON citi_bike.trips_3 (start_station_id);
CREATE INDEX end_station_id_indx ON citi_bike.trips_3 (end_station_id);
CREATE INDEX gender_indx ON citi_bike.trips_3 (gender);
CREATE INDEX user_type_indx ON citi_bike.trips_3 (user_type);
