create or replace TRIGGER alapanyag_felvetel_modositás
INSTEAD OF UPDATE ON alapa_nez
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
        WHERE UPPER(tipus_name)=UPPER(:new.tipus);
        IF tip_db < 1 THEN
            RAISE nincs_ilyen_tipus;
        END IF;
        SELECT COUNT(*) INTO tip_db
            FROM  alapa_tipus INNER JOIN alapanyag USING (tipus_id)
            WHERE UPPER(:new.tipus)=UPPER(tipus_name) AND UPPER(alapanyag.alapa_name)=UPPER(:new.alapanyag);
        IF tip_db>0 THEN
            RAISE mar_letezo_alapa;
        END IF;
        SELECT tipus_id INTO tip_id
        FROM alapa_tipus
        WHERE UPPER(tipus_name)=UPPER(:new.tipus);
        SELECT alapa_id INTO al_id
            FROM alapanyag
            WHERE UPPER(alapa_name)=UPPER(:old.alapanyag);
        UPDATE alapanyag SET alapanyag.alapa_name=:new.alapanyag, alapanyag.tipus_id=tip_id
            WHERE alapanyag.alapa_id=al_id;
        DBMS_OUTPUT.PUT_LINE('Modositás sikeres: ' || :new.alapanyag || ' - ' || :new.tipus);
 exception
    when nincs_ilyen_tipus then
        dbms_output.put_line('Hiba! A megadott tipus nem létezik!');
    when mar_letezo_alapa then
        dbms_output.put_line('Hiba! A megadott tipusból már van ilyen termék!');
end;