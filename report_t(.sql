
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

