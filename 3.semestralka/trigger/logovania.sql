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