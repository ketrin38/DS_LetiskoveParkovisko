--###################################################################################################################################
-- je zakaznik bezny ? funkcia zisti ci je zakaznik bezny zakaznik alebo nie
CREATE OR REPLACE FUNCTION typ_zakaznik
	(p_spz IN VOZIDLO.SPZ%TYPE)
RETURN INTEGER
IS 
bezny integer;
BEGIN
  SELECT ID_PREUKAZ INTO bezny FROM VOZIDLO
    WHERE p_spz = SPZ;
    
  IF (bezny IS NULL) THEN
    return 0;
  ELSE 
    return 1;
  END IF; 
END;
/

--###################################################################################################################################
-- vrati cenu parkovacieho miesta v danom obdobi
CREATE OR REPLACE FUNCTION get_cena_par_miesta
	(p_id_miesto IN PARKOVACIE_MIESTO.ID_MIESTA%TYPE,
    p_odkedy IN DATE)
RETURN INTEGER
IS 
r_cena integer;
BEGIN
  SELECT SUMA INTO r_cena FROM TARIFA
    JOIN ZONA USING (ID_ZONA)
      JOIN PARKOVACIE_MIESTO USING (ID_ZONA)  
      WHERE ID_MIESTO = p_id_miesto
      AND p_odkedy BETWEEN PLATNOST_OD AND PLATNOST_DO;
      
  return r_cena;
END;
/

--###################################################################################################################################
-- je zaplatena ? funkcia zisti ci je uz parkovanie (historia) zalplatene
CREATE OR REPLACE FUNCTION je_zaplatena_platba
	(p_id_historia IN HISTORIA_PARKOVANIA.ID_HISTORIA%TYPE)
RETURN INTEGER
IS 
r_platena integer;
BEGIN
  SELECT count(*) INTO r_platena FROM PLATBA 
    WHERE ID_HISTORIA = p_id_historia;
  IF (r_platena > 0) THEN
    return 1;
  END IF;
  
  return 0;
END;
/

--###################################################################################################################################
-- Funkcia vrati zlavu daneho kuponu
-- TODO TODO TODO TODO TODO TODO TODO TODO 
-- 
CREATE OR REPLACE FUNCTION get_zlava_kupon
	(p_id_kupon REZERVACIA.ID_PREUKAZ%TYPE,
    p_zaciatok IN DATE)
RETURN INTEGER
IS 
r_percenta integer;
BEGIN
  r_percenta := 0;

  SELECT PERCENTA INTO r_percenta FROM ZLAVA
    JOIN KUPON USING (ID_ZLAVA)
      WHERE ID_KUPON = p_id_kupon
       AND p_zaciatok BETWEEN ODKEDY AND DOKEDY;
	   
  return r_percenta;
END;
/

--###################################################################################################################################
-- vrati percenta zlavy na preukaz
CREATE OR REPLACE FUNCTION get_zlava_na_preukaz
	(p_id_preukaz IN PREUKAZ.ID_PREUKAZ%TYPE,
    p_odkedy IN DATE,
    p_dokedy IN DATE)
RETURN INTEGER
IS 
r_zlava_percent integer;
BEGIN
  SELECT PERCENTA INTO r_zlava_percent FROM ZLAVA
    JOIN ZLAVA_NA_PREUKAZ znp USING (ID_ZLAVA)
    WHERE znp.ZACIATOK_PLATNOSTI <= p_odkedy
      AND znp.DOKEDY >= p_dokedy;
  
  RETURN r_zlava_percent;
END;
/

--###################################################################################################################################
-- typ zakaznika
CREATE OR REPLACE FUNCTION typ_zakaznik
	(p_spz IN VOZIDLO.SPZ%TYPE)
RETURN INTEGER
IS 
r_typ char;
BEGIN
  SELECT TYP INTO r_typ FROM ZAKAZNIK 
    JOIN PREUKAZ USING (ID_ZAKAZNIK)
    JOIN VOZIDLO USING (ID_PREUKAZ)
    WHERE p_spz = SPZ;
  
  RETURN r_typ;
END;
/

--###################################################################################################################################
-- vrati id_preukazu na ktory je vozidlo
CREATE OR REPLACE FUNCTION get_id_preukaz
	(p_spz IN VOZIDLO.SPZ%TYPE)
RETURN INTEGER
IS 
r_id_preukaz char;
BEGIN
  SELECT ID_PREUKAZ INTO r_id_preukaz FROM VOZIDLO
    WHERE p_spz = SPZ;
  
  RETURN r_id_preukaz;
END;
/



