

--###################################################################################################################################
-- Procedura vypise faktura za dane csove obdobie spolu s cenami a datumami

create or replace PROCEDURE procedure_get_faktura
  (p_preukaz IN NUMBER, p_date_from IN DATE, p_date_to IN DATE) 
IS
 celkova_cena integer;
 cena_jedneho integer;
BEGIN
  celkova_cena := 0;
  dbms_output.put_line('Faktura pre zakaznika s preukazom ' || to_char(p_preukaz) 
                      || ' pre obdobie od ' || TO_CHAR(p_date_from, 'YYYY.MM.DD') 
                      || ' do ' || TO_CHAR(p_date_to, 'YYYY.MM.DD'));
  dbms_output.put_line('-----------------------------------------------------------------------------------');
  FOR rec IN (SELECT id_preukaz, spz, odkedy, dokedy, id_historia
             from VOZIDLO
             JOIN HISTORIA_PARKOVANIA USING(spz)
              WHERE VOZIDLO.ID_PREUKAZ = p_preukaz
                AND odkedy > p_date_from
                AND dokedy is not null
                AND dokedy < p_date_to + INTERVAL '1' DAY
                AND NOT EXISTS (
                  select 'x' from platba
                    WHERE HISTORIA_PARKOVANIA.ID_HISTORIA = platba.ID_HISTORIA))
  LOOP
    cena_jedneho := GET_CENA_JEDNOTKOVA(rec.spz, rec.odkedy, rec.dokedy);
    procedure_vloz_platbu(rec.id_historia, cena_jedneho); 
    celkova_cena := celkova_cena + cena_jedneho;
    dbms_output.put_line('Parkovanie : ' 
          || TO_CHAR(rec.odkedy, 'YYYY.MM.DD HH24:MI:SS') || ' - '
          || TO_CHAR(rec.dokedy, 'YYYY.MM.DD HH24:MI:SS')
          || ' Cena parkovania: '  || cena_jedneho || ' eur.'); 
  END LOOP;
  dbms_output.put_line('-----------------------------------------------------------------------------------');
  dbms_output.put_line('Celkova cena parkovania je ' || celkova_cena || ' eur.');
END;


--###################################################################################################################################
-- procedura vlozi platbu do platieb ak tam este neexistuje

create or replace PROCEDURE procedure_vloz_platbu
  (p_id_historia IN NUMBER, p_cena IN INTEGER)
  IS
  vlozena integer;
BEGIN
  SELECT COUNT(*) INTO vlozena FROM PLATBA
    WHERE ID_HISTORIA = p_id_historia;

  IF (vlozena = 0) THEN
    INSERT INTO PLATBA VALUES(p_id_historia, sysdate, p_cena); 
  END IF;
END;

--###################################################################################################################################
-- Procedura pre kontrolu vkladania datumu
create or replace PROCEDURE kontrola_datumu
	(p_odkedy IN DATE, p_dokedy IN DATE)
IS 
BEGIN
  IF (p_odkedy > p_dokedy)
	THEN
		RAISE_APPLICATION_ERROR(-20001, 'Nespravna platnost datumu');
	END IF;
END;

