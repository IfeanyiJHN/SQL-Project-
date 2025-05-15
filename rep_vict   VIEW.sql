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
