CREATE OR REPLACE TRIGGER alapanyag_felvetel
INSTEAD OF INSERT ON alapa_nez
FOR EACH ROW
DECLARE
    nincs_ilyen_tipus EXCEPTION;
    mar_letezo_alapa EXCEPTION;
    tip_db NUMBER;
    tip_id alapa_tipus.tipus_id%TYPE;
    al_id alapanyag.alapa_id%TYPE;
    tip_name alapa_tipus.tipus_name%TYPE;
BEGIN
    SELECT COUNT(*) INTO tip_db
        FROM alapa_tipus
        WHERE tipus_name=:new.tipus;
        IF tip_db < 1 THEN
            RAISE nincs_ilyen_tipus;
        END IF;
        SELECT COUNT(*) INTO tip_db
            FROM  alapa_tipus INNER JOIN alapanyag USING (tipus_id)
            WHERE :new.tipus=tipus_name AND alapanyag.alapa_name=:new.alapanyag;
        IF tip_db>0 THEN
            RAISE mar_letezo_alapa;
        END IF;
        SELECT tipus_id INTO tip_id
        FROM alapa_tipus
        WHERE tipus_name=:new.tipus;
        SELECT MAX(alapa_id) INTO al_id
            FROM alapanyag;
        INSERT INTO alapanyag VALUES(al_id+1, :new.alapanyag, null, null, tip_id);
        DBMS_OUTPUT.PUT_LINE('Beillesztés sikeres: ' || :new.alapanyag || ' - ' || :new.tipus);
EXCEPTION
    WHEN nincs_ilyen_tipus THEN
        dbms_output.put_line('Hiba! A megadott tipus nem létezik!');
    WHEN mar_letezo_alapa THEN
        dbms_output.put_line('Hiba! A megadott tipusból már van ilyen termék!');
end; 
/