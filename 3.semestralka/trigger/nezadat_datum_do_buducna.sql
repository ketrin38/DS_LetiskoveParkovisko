-- na tabuæke historii parkovania zamedziù aby sa d·tum od dal zadaù do bud˙cnosti
CREATE OR REPLACE TRIGGER NEZADAT_DATUM_DO_BUDUCNA
BEFORE INSERT ON HISTORIA_PARKOVANIA
FOR EACH ROW
BEGIN
    IF(:NEW.ODKEDY > SYSDATE)
        THEN RAISE_APPLICATION_ERROR(-20001, 'D·tum odkedy nieje moûnÈ zadaù do bud˙cnosti.'); 
    END IF;
END;
/

INSERT INTO HISTORIA_PARKOVANIA
    VALUES(132,632,'BL437GZ',null,'15.05.2017',null);
    
SELECT * 
  FROM historia_parkovania 
 WHERE id_historia = 132;