

-- [1] To begin with the project, you need to create the database first
-- Write the Query below to create a Database

create database crime;


-- [2] Now, after creating the database, you need to tell MYSQL which database is to be used.
-- Write the Query below to call your Database

use crime;

DROP DATABASE CRIME;

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Tables Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [3] Creating the tables:

DROP TABLE IF EXISTS  crime_t; -- Change the name of table_name to the name you have given.                             


create table crime_t(
report_no int,
incident_time time,
complaint_type varchar(10),
cctv_flag varchar(5),
precinct_code int,
area_code int,
area_name varchar(20),
cctv_count int,
population_density int,
rounds_per_day int,
crime_code int,
crime_type varchar(30),
weapon_code int,
weapon_desc varchar(30),
case_status_code int,
case_status_desc varchar(10),
victim_code int,
victim_name varchar(20),
victim_sex char(1),
victim_age int,
was_victim_alone varchar(3),
is_victim_insured varchar(3),
offender_code int,
offender_name varchar(20),
offender_sex char(1),
offender_age int,
repeated_offender varchar(3),
no_of_offences int,
offender_relation varchar(3),
officer_code int,
officer_name varchar(30),
officer_sex char(1),
avg_close_days int,
week_number int,
primary key(area_code,victim_code,officer_code,report_no));

drop table crime_t;

select*from crime_t;  


create table location_t(
area_code int,
area_name varchar(20),
cctv_count int,
population_density int,
rounds_per_day int,
primary key(area_code));



create table officer_t(
officer_code int,
officer_name varchar(30),
officer_sex char (1),
avg_close_days int,
precinct_code int,
primary key(officer_code));


create table report_t(
report_no int,
incident_time time,
complaint_type varchar(10),
cctv_flag varchar(5),
area_code int,
victim_code int,
officer_code int,
offender_code int,
offender_name varchar(20),
offender_age int,
offender_sex char(1),
repeated_offender varchar(3),
no_of_offences int,
offender_relation varchar(3),
crime_code int,
crime_type varchar (30),
weapon_code int,
weapon_desc varchar(30),
case_status_code char(2),
case_status_desc varchar(10),
week_number int,
primary key(report_no));

drop table report_t;


create table victim_t(
victim_code int,
victim_name varchar(20),
victim_age int,
victim_sex char(1),
was_victim_alone varchar(3),
is_victim_insured varchar(3),
primary key(victim_code));


create table temp_t(
report_no int,
incident_time time,
complaint_type varchar(10),
cctv_flag varchar(5),
precinct_code int,
area_code int,
area_name varchar(20),
cctv_count int,
population_density int,
rounds_per_day int,
crime_code int,
crime_type varchar(30),
weapon_code int,
weapon_desc varchar(30),
case_status_code int,
case_status_desc varchar(10),
victim_code int,
victim_name varchar(20),
victim_sex char(1),
victim_age int,
was_victim_alone varchar(3),
is_victim_insured varchar(3),
offender_code int,
offender_name varchar(20),
offender_sex char(1),
offender_age int,
repeated_offender varchar(3),
no_of_offences int,
offender_relation varchar(3),
officer_code int,
officer_name varchar(30),
officer_sex char(1),
avg_close_days int,
week_number int,
primary key(area_code,victim_code,officer_code,report_no));

drop table temp_t;








                                                          



/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Stored Procedures Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [4] Creating the Stored Procedures:

 
DROP PROCEDURE IF EXISTS crime.crime_p;

-- Syntax to create a stored procedure-
DELIMITER $$ 
CREATE PROCEDURE crime.crime_p()
BEGIN
	INSERT INTO crime_t (
		report_no,
incident_time,
complaint_type,
cctv_flag ,
precinct_code ,
area_code,
area_name,
cctv_count,
population_density,
rounds_per_day,
crime_code,
crime_type,
weapon_code,
weapon_desc,
case_status_code,
case_status_desc,
victim_code,
victim_name,
victim_sex,
victim_age,
was_victim_alone,
is_victim_insured,
offender_code,
offender_name,
offender_sex,
offender_age,
repeated_offender,
no_of_offences,
offender_relation ,
officer_code,
officer_name,
officer_sex,
avg_close_days,
week_number
	) SELECT * FROM crime.temp_t;
END;


DELIMITER $$
CREATE PROCEDURE location_p()
BEGIN
	INSERT INTO location_t (
   area_code ,
area_name,
cctv_count,
population_density,
rounds_per_day
    )
    SELECT DISTINCT 
	 area_code,
area_name,
cctv_count,
population_density,
rounds_per_day
	FROM crime_t WHERE area_code NOT IN (SELECT DISTINCT area_code FROM location_t);
END;


DELIMITER $$
CREATE PROCEDURE officer_p()
BEGIN
	INSERT INTO officer_t (
    officer_code,
officer_name,
officer_sex,
avg_close_days,
precinct_code
    )
    SELECT DISTINCT 
	officer_code,
officer_name,
officer_sex,
avg_close_days,
precinct_code
	FROM crime_t WHERE officer_code NOT IN (SELECT DISTINCT officer_code FROM officer_t);
END;


DELIMITER $$
CREATE PROCEDURE report_p(weeknum INTEGER)
BEGIN
	INSERT INTO report_t(
	report_no,
incident_time,
complaint_type,
cctv_flag,
area_code,
victim_code,
officer_code,
offender_code,
offender_name,
offender_age,
offender_sex,
repeated_offender,
no_of_offences,
offender_relation,
crime_code,
crime_type,
weapon_code,
weapon_desc,
case_status_code,
case_status_desc,
week_number)
 
 select distinct
 report_no,
incident_time,
complaint_type,
cctv_flag,
area_code,
victim_code,
officer_code,
offender_code,
offender_name,
offender_age,
offender_sex,
repeated_offender,
no_of_offences,
offender_relation,
crime_code,
crime_type,
weapon_code,
weapon_desc,
case_status_code,
case_status_desc,
week_number
 

	FROM crime_t WHERE WEEK_NUMBER = weeknum;
END;


DELIMITER $$
CREATE PROCEDURE victim_p()
BEGIN
	INSERT INTO victim_t (
    victim_code,
victim_name,
victim_age,
victim_sex,
was_victim_alone,
is_victim_insured
    )
    SELECT DISTINCT 
	victim_code,
victim_name,
victim_age,
victim_sex,
was_victim_alone,
is_victim_insured
	FROM crime_t WHERE victim_code NOT IN (SELECT DISTINCT victim_code FROM victim_t);
END;



/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Data Ingestion
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [5] Ingesting the data:
-- Note: Revisit the video: Week-2: Data Modeling and Architecture: Ingesting data into the main table

TRUNCATE temp_t;
LOAD DATA LOCAL INFILE "C:/Users/USER/Desktop/sql projest/Data/crime_la_w1.csv"
INTO TABLE temp_t
FIELDS TERMINATED by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

call crime_p();
call report_p(n);
call officer_p();
call location_p();
call victim_p();


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Views Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [6] Creating the views:


-- Syntax to create view-

-- To drop the views if already exists- 
DROP VIEW IF EXISTS rep_loc_off_v;

-- To create a view-
CREATE VIEW rep_loc_off_v AS
    SELECT 
        rep.report_no,
        loc.area_code,
        rep.incident_time,
        rep.complaint_type,
        rep.cctv_flag,
        rep.crime_code,
        rep.crime_type,
        rep.week_number,
        rep.case_status_desc,
        rep.case_status_code,
        loc.area_name,
        loc.cctv_count,
        loc.population_density,
        off.officer_code,
        off.precinct_code
    FROM location_t loc 
        JOIN report_t rep
            using (area_code)
            join officer_t off
            using (officer_code);


CREATE VIEW rep_vict_v AS
    SELECT 
        rep.report_no,
        vict.victim_code,
        rep.offender_relation,
        rep.crime_type,
        rep.incident_time,
        vict.victim_age
    FROM victim_t vict 
        JOIN report_t rep
            using (victim_code);



/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Functions Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [7] Creating the functions:
-- Create the function age_f

-- DROP FUNCTION age_f;

DELIMITER $$  
CREATE FUNCTION age_f(victim_age INT)  
RETURNS varchar(20) 
DETERMINISTIC  
BEGIN  
    DECLARE age_group varchar(20);
    IF victim_age between 0 and 12 THEN  
        SET age_group= 'kids';  
    ELSEIF victim_age between 13 and 23 then 
        SET age_group = 'teenager';  
         ELSEIF victim_age between 24 and 35 then 
        SET age_group = 'middle age';  
         ELSEIF victim_age between 36 and 55 then 
        SET age_group = 'adults';  
         ELSEIF victim_age between 56 and 120 then 
        SET age_group = 'old';  
    END IF;  
    RETURN (age_group);  
END;

-- Create the function time_f-
drop FUNCTION TIME_F;
DELIMITER $$
CREATE FUNCTION TIME_F (INCIDENT_TIME TIME) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN  
	 DECLARE TIME_DAY VARCHAR(20);
	 IF INCIDENT_TIME BETWEEN "00:00:00" AND "05:00:00" THEN
		    SET TIME_DAY = "MIDNIGHT";
	ELSEIF INCIDENT_TIME BETWEEN "05:01:00" AND "12:00:00" THEN  
			SET TIME_DAY = "MORNING";  
	ELSEIF INCIDENT_TIME BETWEEN "12:01:00" AND "18:00:00" THEN  
			SET TIME_DAY = "AFTERNOON";  
	ELSEIF INCIDENT_TIME BETWEEN "18:01:00" AND "21:00:00" THEN   
		SET TIME_DAY = "EVENING";
	ELSEIF INCIDENT_TIME BETWEEN "21:01:00" AND "24:00:00" THEN   
		SET TIME_DAY = "NIGHT"; 
		END IF;  
		RETURN (TIME_DAY);  
END;

/*-- QUESTIONS RELATED TO CUSTOMERS
-- [Q1] Which was the most frequent crime committed each week? 
-- Hint: Use a subquery and the windows function to find out the number of crimes reported each week and assign a rank. 
Then find the highest crime committed each week

Note: For reference, refer to question number 3 - mls_week-1_gl-beats_solution.sql. 
      You'll get an overview of how to use subquery and windows function from this question */
select
 crime_type,
week_number,
crime_code,
no_of_crimes
from
(select
crime_type,
week_number,
crime_code,
count(*) as no_of_crimes,
rank()over(partition by week_number order by count(*) desc)as rnk
from rep_loc_off_v
group by
crime_type,
week_number,
crime_code) as frequent_crimes
where rnk=1
order by week_number;


-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q2] Is crime more prevalent in areas with a higher population density, fewer police personnel, and a larger precinct area? 
-- Hint: Add the population density, count the total areas, total officers and cases reported in each precinct code and check the trend*/
select area_name,
population_density,
precinct_code,
count(distinct officer_code) as no_of_officer,
count(distinct crime_code)as no_of_crimes,
rank()over(order by population_density desc)as pd_rnk,
rank()over(order by count(distinct officer_code)desc) as officer_rank,
rank()over(order by count(distinct crime_code)desc) as crime_rnk
from rep_loc_off_v
group by area_name,population_density,precinct_code
order by crime_rnk;

-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q3] At what points of the day is the crime rate at its peak? Group this by the type of crime.
-select week_number,
crime_type,
day_time,
no_of_crimes
from(
select week_number,crime_type,time_f(incident_time) as day_time,
count(*) as no_of_crimes,
rank() over (partition by week_number order by count(*)desc)as rnk
from rep_loc_off_v
group by 1,2,3) as crime_rate
where rnk=1;
      
-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q4] At what point in the day do more crimes occur in a different locality?
select area_name,day_time,no_of_crimes
from
(select area_name,time_f(incident_time) as day_time,
count(*) as no_of_crimes,
rank() over( partition by area_name order by count(*) desc)as rnk
from rep_loc_off_v
group by 1,2) as ranked_crimes
where rnk=1;





-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q5] Which age group of people is more likely to fall victim to crimes at certain points in the day?
select age_group,day_time,
no_of_victims
from
(select age_f(victim_age) age_group,
time_f(incident_time)day_time,
count(*) as no_of_victims,
rank () over (partition by age_f(victim_age) order by count(*) desc) rank_position
from rep_vict_v
group by 1,2)  ddd
where rank_position = 1;
-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q6] What is the status of reported crimes?.
select case_status_desc,
count(*) as reported_crime_status
from rep_loc_off_v
group by case_status_desc
order by reported_crime_status desc;
-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q7] Does the existence of CCTV cameras deter crimes from happening?
select distinct area_name,cctv_count,
count(*) as no_of_crimes,
count(cctv_count) over (partition by area_name) as no_of_cctv
from rep_loc_off_v
group by 1,2;
-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q8] How much footage has been recovered from the CCTV at the crime scene?
SELECT
sum(recovered_footage) as footage_recovered,
sum(unrecovered_footage) as footage_unrecovered
from
(select area_name,
sum(case when cctv_flag= 'true' then 1 
else 0
end) as recovered_footage,
sum(case when cctv_flag ='false'then 1 else 0
end) as unrecovered_footage
from rep_loc_off_v
group by area_name
order by recovered_footage,unrecovered_footage) as cc;
-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q9] Is crime more likely to be committed by relation of victims than strangers?
select distinct crime_type,
sum(offender_relation ='yes') as crimes_by_relation,
sum(offender_relation ='no') as crimes_by_strangers,
if(sum(offender_relation ='yes') >sum(offender_relation ='no'),
'likely_by_relation','likely_by_strangers') as crime_probability
from rep_vict_v
group by crime_type;
-- ---------------------------------------------------------------------------------------------------------------------------------

/* -- [Q10] What are the methods used by the public to report a crime? 
select complaint_type,
crime_type,
count(*)as no_of_crimes_reported
from rep_loc_off_v
group by 1,2;
-- --------------------------------------------------------Done----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------



