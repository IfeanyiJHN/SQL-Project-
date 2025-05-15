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




