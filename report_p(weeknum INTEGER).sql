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


