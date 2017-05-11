

--###################################################################################################################################

create or replace TRIGGER trig_his_parkovania
BEFORE INSERT OR UPDATE ON HISTORIA_PARKOVANIA
FOR EACH ROW
BEGIN
  IF (:NEW.dokedy IS NOT NULL) THEN
    KONTROLA_DATUMU(:NEW.odkedy ,:NEW.dokedy);
  END IF;
END;

--###################################################################################################################################

create or replace TRIGGER trig_platnost_preukaz
BEFORE INSERT OR UPDATE ON PREUKAZ
FOR EACH ROW
BEGIN
  KONTROLA_DATUMU(:NEW.zaciatok_platnosti ,:NEW.koniec_platnosti);
END;

--###################################################################################################################################

create or replace TRIGGER trig_platnost_tarifa
BEFORE INSERT OR UPDATE ON TARIFA
FOR EACH ROW
BEGIN
  KONTROLA_DATUMU(:NEW.platnost_od ,:NEW.platnost_do);
END;

--###################################################################################################################################

create or replace TRIGGER trig_platnost_zlava
BEFORE INSERT OR UPDATE ON ZLAVA
FOR EACH ROW
BEGIN
  KONTROLA_DATUMU(:NEW.odkedy ,:NEW.dokedy);
END;

--###################################################################################################################################

create or replace TRIGGER trig_platnost_zlava_preukaz
BEFORE INSERT OR UPDATE ON zlava_na_preukaz
FOR EACH ROW
BEGIN
  KONTROLA_DATUMU(:NEW.zaciatok_platnosti ,:NEW.dokedy);
END;

--###################################################################################################################################

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

create or replace TRIGGER t_zona_vozidlo
    BEFORE INSERT
    ON historia_parkovania
    FOR EACH ROW
    declare vozidlo_typ vozidlo.typ_vozidla%TYPE;
            zona_vozidlo zona.typ_vozidlo%TYPE;
        BEGIN
           select typ_vozidla into vozidlo_typ
           from vozidlo where spz=:new.spz;
           
           select typ_vozidlo into zona_vozidlo from zona join parkovacie_miesto using(id_zona) 
           where id_miesta=:new.id_miesta;
           
            IF (vozidlo_typ != zona_vozidlo) THEN
                RAISE_APPLICATION_ERROR(-20000, 'Nemoze parkovat na danom parkovacom mieste');
            END IF;
        END;
        /

INSERT INTO historia_parkovania(id_historia, id_miesta, spz, odkedy) 
VALUES (500,640, 'BA621NA',sysdate);

DELETE FROM historia_parkovania
WHERE id_historia = 500;

-- ak je rezervácia na nejaké parkovacie miesto, iné si to nemôže rezervova
CREATE OR REPLACE TRIGGER REZERVACIA_OBSADENA
BEFORE INSERT ON REZERVACIA_PARK_MIESTA
FOR EACH ROW
DECLARE POCET INTEGER;
BEGIN
    SELECT COUNT(*) INTO POCET
      FROM REZERVACIA_PARK_MIESTA RPM
INNER JOIN  REZERVACIA REZ
        ON RPM.ID_REZERVACIA = REZ.ID_REZERVACIA
     WHERE RPM.ID_MIESTA = :NEW.ID_MIESTA
       AND EXISTS(SELECT 'X' 
              FROM REZERVACIA_PARK_MIESTA RPMNEW 
        INNER JOIN REZERVACIA REZNEW
                ON RPMNEW.ID_REZERVACIA = REZNEW.ID_REZERVACIA
             WHERE RPMNEW.ID_MIESTA != RPM.ID_MIESTA
               AND RPMNEW.ID_REZERVACIA NOT IN RPM.ID_REZERVACIA
               AND (REZNEW.ZACIATOK >= REZ.ZACIATOK
               AND REZNEW.ZACIATOK <= (REZ.ZACIATOK + REZ.DLZKA))
                OR ((REZNEW.ZACIATOK + REZNEW.DLZKA) >= REZ.ZACIATOK
               AND (REZNEW.ZACIATOK + REZNEW.DLZKA) <= (REZ.ZACIATOK + REZ.DLZKA))
        );
    IF(POCET != 0)
        THEN RAISE_APPLICATION_ERROR(-20001, 'Rezervácia na danom mieste sa prekrýva s už existujúcou rezerváciou.'); 
    END IF;
END;
/

SHOW ERROR;

INSERT INTO REZERVACIA_PARK_MIESTA 
    VALUES (21,21,517);
    
INSERT INTO REZERVACIA
    VALUES (21,226,NULL,'09.06.2017','SCH','+02 00:00:00.000000');
    
--trigger aby sa nezadali percentá iné ako od 0 po 100
CREATE OR REPLACE TRIGGER CHECK_NA_PERCENTA
BEFORE INSERT ON ZLAVA
DECLARE PERCENTO INTEGER;
BEGIN
    SELECT :NEW.PERCENTO INTO PERCENTO
      FROM DUAL;
    IF (PERCENTO <= 0 OR PERCENTO > 100)
        THEN RAISE_APPLICATION_ERROR(-20001, 'Vo vstupe sa nachádza neplatný rozsah pre percentá (0-100)'); 
    END IF;
END;
/ 

SHOW ERROR;

-- na tabu¾ke historii parkovania zamedzi aby sa dátum od dal zada do budúcnosti
CREATE OR REPLACE TRIGGER NEZADAT_DATUM_DO_BUDUCNA
BEFORE INSERT ON HISTORIA_PARKOVANIA
FOR EACH ROW
BEGIN
    IF(:NEW.ODKEDY > SYSDATE)
        THEN RAISE_APPLICATION_ERROR(-20001, 'Dátum odkedy nieje možné zada do budúcnosti.'); 
    END IF;
END;
/

INSERT INTO HISTORIA_PARKOVANIA
    VALUES(132,632,'BL437GZ',null,'15.05.2017',null);
    
SELECT * 
  FROM historia_parkovania 
 WHERE id_historia = 132;


 create or replace trigger logovanie
    after update on historia_parkovania
    for each row
    begin
         insert into log values(user,sysdate,:new.id_historia,:new.id_miesta,:new.spz,:new.id_rezervacia_park_miesto,:new.odkedy,:new.dokedy,
         :old.id_historia,:old.id_miesta,:old.spz,:old.id_rezervacia_park_miesto,:old.odkedy,:old.dokedy);
    end;
    /
    
     CREATE TABLE "STANO23"."LOG" 
   (	"POUZIVATEL" CHAR(30 BYTE), 
	"DATUM" date, 
	"ID_HISTORIA" NUMBER NOT NULL ENABLE, 
	"ID_MIESTA" NUMBER NOT NULL ENABLE, 
	"SPZ" CHAR(7 BYTE) NOT NULL ENABLE, 
	"ID_REZERVACIA_PARK_MIESTO" NUMBER, 
	"ODKEDY" DATE NOT NULL ENABLE, 
	"DOKEDY" DATE, 
	"ID_HISTORIA_OLD" NUMBER NOT NULL ENABLE, 
	"ID_MIESTA_OLD" NUMBER NOT NULL ENABLE, 
	"SPZ_OLD" CHAR(7 BYTE) NOT NULL ENABLE, 
	"ID_REZERVACIA_PARK_MIESTO_OLD" NUMBER, 
	"ODKEDY_OLD" DATE NOT NULL ENABLE, 
	"DOKEDY_OLD" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
 

  
    
    
    select * from log;
    drop table log;
    select * from historia_parkovania;
    update  historia_parkovania set id_historia=129 where id_historia=129;


create or replace trigger tr_kontrola_typ
    before insert on historia_parkovania
        for each row
        declare 
           preukaz number;
           typ_zakaznik number;
            typ_zona zona.typ_zona%TYPE;
          begin
                select id_preukaz,typ into preukaz,typ_zakaznik  from zakaznik 
        join preukaz using(id_zakaznik) 
            right join vozidlo using(id_preukaz)
            where spz=:new.spz;
                 
                  select typ_zona into typ_zona from zona 
                join parkovacie_miesto using(id_zona)
                    where id_miesta=:new.id_miesta;
                    if  typ_zakaznik is not null then
                     if typ_zona='Z' and typ_zakaznik!='Z'  then
       RAISE_APPLICATION_ERROR(-20001, 'Toto miesto nie je urèené pre vás !'); 
       end if;
     elsif typ_zona='Z' then
            RAISE_APPLICATION_ERROR(-20001, 'Toto miesto nie je urèené pre vás !'); 
     end if;
      end;  
      /
       insert into historia_parkovania values(50000,11,'BL323BA',null,sysdate,null);
 rollback;


/** nastavenie konca platnosti  preukazu/*/

create or replace trigger koniec_platnosti
before  insert on preukaz
for each row
begin
if :new.koniec_platnosti is null then
     :new.koniec_platnosti:=add_months(sysdate,12);
end if;
end;
/


/**testovanie*/
insert into preukaz values(8000,2,sysdate,null);
select * from preukaz where id_preukaz=8000;
delete from preukaz where id_preukaz=8000;
commit;
create or replace trigger je_volne_miesto
    before insert  on historia_parkovania
     for each row
      declare pocet integer;
        begin
    
            select count(*) into pocet from historia_parkovania 
                where id_miesta=:new.id_miesta
                and (   
                                odkedy>=:new.odkedy and odkedy<:new.dokedy
                            or 
                                 nvl(dokedy,sysdate)<=nvl(:new.dokedy,sysdate)  and nvl(dokedy,sysdate) >:new.odkedy 
                            or
                              odkedy<=:new.odkedy and  nvl(dokedy,sysdate) >= nvl(:new.dokedy,sysdate)
                             );
                
                    if pocet!=0 then
                        RAISE_APPLICATION_ERROR(-20001, 'Prepáète, ale toto miesto je obsadené');               
            
                    end if;
                    
      
    end;
/
select * from historia_parkovania where spz='BA292UH';
rollback;
insert into HISTORIA_PARKOVANIA values(5000,629,'BA292UH',null,to_date('11.12.2016','DD.MM.YYYY'),null);
