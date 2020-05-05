CREATE OR REPLACE FUNCTION holvan (alapneve varchar2) RETURN VARCHAR2 IS eredmeny VARCHAR2(20);
talalt_db_alapa number;
talalt_db_hely number;
alapa_helye alapa_tipus.helyseg%TYPE;

BEGIN
    SELECT COUNT(*) INTO talalt_db_alapa
        FROM alapanyag
        WHERE alapa_name=alapneve;
        IF talalt_db_alapa =0 then
            return -1; --nincs ilyen alapanyag
        ELSIF talalt_db_alapa >1 then
            return -2; --több ilyen nevü alapanyag is létezik
        ELSIF talalt_db_alapa=1 then
            SELECT COUNT(*) INTO talalt_db_hely
            FROM alapanyag INNER JOIN alapa_tipus USING(tipus_id)
            WHERE UPPER(alapanyag.alapa_name)=UPPER(alapneve);
            IF talalt_db_hely =0 then
                RETURN -3; --nem tároljuk sehol a terméket 
            ELSIF talalt_db_hely>1 then
                RETURN -4; --több helyen is tárolva van az alapanyag
            ELSE
                SELECT helyseg INTO alapa_helye
                FROM alapanyag INNER JOIN alapa_tipus USING (tipus_id)
                WHERE UPPER(alapanyag.alapa_name)=UPPER(alapneve);
                RETURN alapa_helye;
            END IF;
        END IF;
END holvan;
/