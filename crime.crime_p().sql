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


