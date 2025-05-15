
-- QUESTIONS RELATED TO CUSTOMERS
-- [Q1] Which was the most frequent crime committed each week? 
-- Hint: Use a subquery and the windows function to find out the number of 
---- crimes reported each week and assign a rank. 
-- Then find the highest crime committed each week

--- Note: For reference, refer to question number 3 - mls_week-1_gl-beats_solution.sql. 
 --     You'll get an overview of how to use subquery and windows function from this question

q1. find the highest crime committed each week

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



-- -- [Q2] Is crime more prevalent in areas with a higher population density, 
-- fewer police personnel, and a larger precinct area? 
-- Hint: Add the population density, count the total areas, 
--- total officers and cases reported in each precinct code and check the trend*/

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

-- [Q3] At what points of the day is the crime rate at its peak? 
-- Group this by the type of crime.
select week_number,
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


-- [Q4] At what point in the day do more crimes occur in a different locality?
select area_name,day_time,no_of_crimes
from
(select area_name,time_f(incident_time) as day_time,
count(*) as no_of_crimes,
rank() over( partition by area_name order by count(*) desc)as rnk
from rep_loc_off_v
group by 1,2) as ranked_crimes
where rnk=1;



-- [Q5] Which age group of people is more likely to fall victim to 
-- crimes at certain points in the day?
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



-- [Q6] What is the status of reported crimes?.
-- Hint: Count the number of crimes for different case statuses. */
select case_status_desc,
count(*) as reported_crime_status
from rep_loc_off_v
group by case_status_desc
order by reported_crime_status desc;




-- -- [Q7] Does the existence of CCTV cameras deter crimes from happening?
select distinct area_name,cctv_count,
count(*) as no_of_crimes,
count(cctv_count) over (partition by area_name) as no_of_cctv
from rep_loc_off_v
group by 1,2;


-- -- [Q8] How much footage has been recovered from the CCTV at the crime scene?
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



-- [Q9] Is crime more likely to be committed by relation of victims than strangers?
select distinct crime_type,
sum(offender_relation ='yes') as crimes_by_relation,
sum(offender_relation ='no') as crimes_by_strangers,
if(sum(offender_relation ='yes') >sum(offender_relation ='no'),
'likely_by_relation','likely_by_strangers') as crime_probability
from rep_vict_v
group by crime_type;

--  [Q10] What are the methods used by the public to report a crime? 
select complaint_type,
crime_type,
count(*)as no_of_crimes_reported
from rep_loc_off_v
group by 1,2;
