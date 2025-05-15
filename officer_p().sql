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
