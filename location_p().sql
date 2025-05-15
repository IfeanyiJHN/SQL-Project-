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
