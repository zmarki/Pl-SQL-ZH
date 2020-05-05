CREATE OR REPLACE TRIGGER naplozas
AFTER INSERT OR DELETE OR UPDATE ON alapanyag
FOR EACH ROW
DECLARE
    akt_id NUMBER;
BEGIN
    SELECT MAX(id) INTO akt_id From naplo;
    IF akt_id IS NULL THEN
        akt_id := 1;
    ELSE
        akt_id := akt_id + 1;
    END IF;
    IF inserting THEN
        INSERT INTO naplo VALUES(akt_id, sysdate, user, :new.alapa_id, :new.alapa_name, 'beszúrás', null, :new.mennyiseg);
    ELSIF deleting THEN
        INSERT Into naplo VALUES(akt_id, sysdate, user, :old.alapa_id, :old.alapa_name, 'törlés', :old.mennyiseg, null);
    ELSIF updating THEN
        INSERT INTO naplo VALUES(akt_id, sysdate, user, :new.alapa_id,  :new.alapa_name,'változtatás', :old.mennyiseg, :new.mennyiseg);
    END IF;
END;
/