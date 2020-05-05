CREATE OR REPLACE PROCEDURE ujalapanyag (alapanyag VARCHAR2, tipus VARCHAR2) AS
    p_tipus_name alapa_tipus.tipus_name%TYPE;
    p_tipus_id alapa_tipus.tipus_id%TYPE;
    maxID NUMBER(3);
    eredmeny NUMBER(3);
    talalat NUMBER(3);
    Letezo_Alapanyag EXCEPTION;
BEGIN
    SELECT tipus_id, tipus_name
        INTO p_tipus_id, p_tipus_name
        FROM alapa_tipus
        WHERE UPPER(tipus_name)=UPPER(tipus);
    SELECT count(*)
        INTO talalat
        FROM alapanyag
        WHERE UPPER(alapa_name)=UPPER(alapanyag);
    IF talalat > 0 THEN
        RAISE Letezo_Alapanyag;
    END IF;
    SELECT MAX(alapa_id)
        INTO maxID
        FROM alapanyag;
    maxid:=maxid+1;
    INSERT INTO alapanyag VALUES (maxid, alapanyag, null, null, p_tipus_id );
    SELECT count(*)
    INTO eredmeny
    FROM alapanyag INNER JOIN alapa_tipus USING (tipus_id)
    WHERE UPPER(tipus_name)=UPPER(tipus);
    DBMS_OUTPUT.PUT_LINE(eredmeny);
EXCEPTION
    WHEN No_Data_Found
        THEN DBMS_OUTPUT.PUT_LINE('Nem létezõ tipus');
    WHEN Letezo_Alapanyag
        THEN DBMS_OUTPUT.PUT_LINE('Már létezõ termék');
END ujalapanyag;
/