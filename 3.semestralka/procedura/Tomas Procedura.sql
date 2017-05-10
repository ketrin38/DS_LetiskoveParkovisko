

--###################################################################################################################################
-- Procedura vypise faktura za dane csove obdobie spolu s cenami a datumami

create or replace PROCEDURE procedure_get_faktura
  (p_preukaz IN NUMBER, p_date_from IN DATE, p_date_to IN DATE) 
IS
BEGIN
  dbms_output.put_line('Faktura pre zakaznika s preukazom ' || to_char(p_preukaz));

  FOR rec IN (SELECT id_preukaz, spz, odkedy, dokedy
             from VOZIDLO
             JOIN HISTORIA_PARKOVANIA USING(spz)
              WHERE VOZIDLO.ID_PREUKAZ = p_preukaz
                AND odkedy >= p_date_from
                AND dokedy is not null
                AND dokedy <= p_date_to
                AND NOT EXISTS (
                  select 'x' from platba
                    WHERE HISTORIA_PARKOVANIA.ID_HISTORIA = platba.ID_HISTORIA))
  LOOP
    dbms_output.put_line('Parkovanie : ' 
          || TO_CHAR(rec.odkedy, 'YYYY.MM.DD HH24:MI:SS') || ' - '
          || TO_CHAR(rec.dokedy, 'YYYY.MM.DD HH24:MI:SS')
          || ' Cena parkovania: ' 
          || GET_CENA_JEDNOTKOVA(rec.spz, rec.odkedy, rec.dokedy)
          || ' eur.');
  END LOOP;
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

