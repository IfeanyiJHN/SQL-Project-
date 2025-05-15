TRUNCATE temp_t;
LOAD DATA LOCAL INFILE "C:/Users/Dell/Desktop/SQL PROJECT/crime_la_proj/Data/crime_la_w4.csv" -- change this location to load another week
INTO TABLE temp_t
FIELDS TERMINATED by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


-- C:/Users/Dell/Desktop/SQL PROJECT/crime_la_proj/Data
-- C:/Users/Dell/Desktop/SQL PROJECT/crime_la_proj/Data
-- C:/Users/Dell/Desktop/SQL PROJECT/crime_la_proj/Data

select*from crime_t;
truncate crime_t;