CREATE OR REPLACE PROCEDURE leltár (helyszin VARCHAR2) AS
CURSOR cur IS
SELECT alapa_name
    FROM alapanyag INNER JOIN alapa_tipus USING (tipus_id)
    WHERE UPPER(alapa_tipus.helyseg)=UPPER(helyszin);
darab_termek number;
al_name alapanyag.alapa_name%TYPE;
ures_helyseg EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO darab_termek
    FROM alapanyag INNER JOIN alapa_tipus USING (tipus_id)
    WHERE alapa_tipus.helyseg=helyszin;
    IF darab_termek < 1 THEN
        RAISE ures_helyseg;
    END IF;
    OPEN cur;
    LOOP
        FETCH CUR INTO al_name;
        EXIT WHEN cur%notfound;
        DBMS_OUTPUT.PUT_LINE ('Alapanyag: ' || LPAD(al_name, 25));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(darab_termek ||' féle termék van a ' || helyszin);
    CLOSE cur;
       
EXCEPTION
    WHEN ures_helyseg
       THEN DBMS_OUTPUT.PUT_LINE('Nincs termék a helységben');
END leltár;
/