-- FUNKCIA, KTORA ZISTI, CI BOLA VYTVORENA REZERVACIA
-- AK ANO VRATI CISLO REZERVACIE
-- AK VRATI 0 REZERVACIA NEBOLA
create or replace FUNCTION func_daj_id_rezervacie
( p_id_preukaz preukaz.id_preukaz%TYPE,
  p_odkedy DATE)
RETURN integer
IS
 pom_existuje integer;
 r_id_rezervacie integer;
BEGIN
  SELECT COUNT(*) INTO pom_existuje
    FROM rezervacia
      WHERE p_id_preukaz = id_preukaz
        AND p_odkedy BETWEEN zaciatok AND zaciatok + dlzka;
        
  IF (pom_existuje = 0) THEN  -- nema rezervaciu
    RETURN 0;
  ELSE
    SELECT id_rezervacia INTO r_id_rezervacie
      FROM rezervacia
        WHERE p_id_preukaz = id_preukaz
          AND p_odkedy BETWEEN zaciatok AND zaciatok + dlzka;
    RETURN r_id_rezervacie;
  END IF;
END;

