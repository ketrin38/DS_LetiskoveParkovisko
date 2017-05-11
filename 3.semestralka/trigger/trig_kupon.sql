
-- TRIGER KONTROLUJUCI POUZITIE KUPONU
create or replace TRIGGER trig_kupon
BEFORE INSERT OR UPDATE ON rezervacia
FOR EACH ROW
DECLARE
  pocet integer;
  zlava integer;
  existuje_kupon integer;
BEGIN  
    SELECT count(*) INTO existuje_kupon
       FROM kupon
          WHERE :new.id_kupon = kupon.id_kupon;
          
    IF (existuje_kupon > 0) THEN
      RAISE_APPLICATION_ERROR(-20001, 'Kupon neexistuje.');
    END IF;
    
    SELECT count(*) INTO pocet
      FROM rezervacia
        WHERE :new.id_kupon = rezervacia.id_kupon;
        
    IF (pocet > 0) THEN
      RAISE_APPLICATION_ERROR(-20002, 'Kupon bol uz pouzity.');
    END IF;
    
    SELECT id_zlava INTO zlava
      FROM kupon
        WHERE kupon.id_kupon = :new.id_kupon;
    
    IF (func_skontroluj_platnost_zlavy(zlava,:old.zaciatok) = 0) THEN
      RAISE_APPLICATION_ERROR(-20003, 'Narok na zlavu uz vyprsal');
    END IF;
END;
