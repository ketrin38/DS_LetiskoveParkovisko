

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

create or replace procedure uprav_spz(p_old_spz IN vozidlo.spz%type, p_new_spz IN vozidlo.spz%type)
    as
    pocet number;
    begin
    
    select count(*) into pocet from vozidlo where spz=p_old_spz;
        if pocet>0 then
                select count(*) into pocet from vozidlo where spz=p_new_spz;
                if pocet=0 then
                        insert into vozidlo 
                            select p_new_spz,id_preukaz,typ_vozidla from vozidlo where spz=p_old_spz;
                        update historia_parkovania set spz=p_new_spz
                              where spz=p_old_spz;
                        delete from vozidlo where spz=p_old_spz;
                             dbms_output.put_line('SPZ bola upravená');
                 elsif pocet>0 then
                        dbms_output.put_line('Takéto vozidlo už existuje !');
               end if;
        else 
            dbms_output.put_line('Takéto vozidlo neexistuje !');
            
            
        end if;
    end;
    /
    select * from vozidlo;
    show errors;
    execute UPRAV_SPZ('BA540ME','BA540ME');
    SET SERVEROUTPUT ON;
    create or replace procedure vymaz_zlavu(p_nazov in zlava.nazov%type)
        as
         pocet number;
            begin
            select count(*) into pocet from zlava where nazov=p_nazov;
            if pocet!=0 then
                update rezervacia r
                    set id_kupon=null
                         where
                    exists(
                    select 'x' from kupon k
                        join zlava z using(id_zlava) 
                        where z.nazov=p_nazov
                            and k.id_kupon=r.id_kupon);
                     
                     delete from  kupon k where 
                     exists(select 'x' from zlava z
                        where z.nazov=p_nazov
                        and z.id_zlava=k.id_zlava) ;
                      delete from zlava_na_preukaz   znp
                       where 
                     exists(select 'x' from zlava z
                        where z.nazov=p_nazov
                        and z.id_zlava=znp.id_zlava) ;
                        delete from zlava where nazov=p_nazov;
                      dbms_output.put_line('Z¾ava vymazaná! ');
                else
                  dbms_output.put_line('Takáta z¾ava neexistuje !');
                  end if;
                        
            
end;
/
select * from zlava;
execute VYMAZ_ZLAVU('Zfdlava5');
rollback;
    SET SERVEROUTPUT ON;
    


CREATE OR REPLACE PROCEDURE majitel_auta
(v_spz IN vozidlo.spz%TYPE,
v_meno_priezvisko OUT VARCHAR2)
IS
BEGIN
SELECT meno||' '|| priezvisko
INTO v_meno_priezvisko
FROM vozidlo vo 
    JOIN preukaz pr USING (id_preukaz)
    JOIN zakaznik za using(id_zakaznik)
WHERE vo.spz = v_spz;
END majitel_auta;
/
VARIABLE p_meno VARCHAR2(30);

EXECUTE majitel_auta('BA292UH', :p_meno);
PRINT p_meno;


