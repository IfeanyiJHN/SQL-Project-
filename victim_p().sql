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