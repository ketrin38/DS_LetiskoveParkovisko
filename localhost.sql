/*
Created		02/28/2017
Modified		03/28/2017
Project		
Model		
Company		
Author		
Version		
Database		Oracle 10g 
*/
/*
Drop table zlava_na_preukaz
/
Drop table platba
/
Drop table historia_parkovania
/
Drop table rezervacia_park_miesta
/
Drop table rezervacia
/
Drop table kupon
/
Drop table zlava
/
Drop table tarifa
/
Drop table vozidlo
/
Drop table preukaz
/
Drop table zakaznik
/
Drop table parkovacie_miesto
/
Drop table zona
/
*/



Create table zona (
	id_zona Integer NOT NULL ,
	maximalna_doba Integer NOT NULL ,
	typ_vozidlo Char (1) NOT NULL  Check (typ_vozidlo in ('O','A','N') ) ,
	typ_zona Char (1) NOT NULL  Check (typ_zona in ('Z','V') ),
primary key (id_zona) 
) 
/

Create table parkovacie_miesto (
	id_miesta Integer NOT NULL ,
	id_zona Integer NOT NULL ,
primary key (id_miesta) 
) 
/
Create table zakaznik (
	id_zakaznik Integer NOT NULL ,
	meno Varchar2 (30) NOT NULL ,
	typ Char (1) NOT NULL  Check (typ in ('S','F','Z') ) ,
primary key (id_zakaznik) 
) 
/

Create table preukaz (
	id_preukaz Integer NOT NULL ,
	zaciatok_platnosti Date NOT NULL ,
	koniec_platnosti Date NOT NULL ,
	id_zakaznik Integer NOT NULL ,
primary key (id_preukaz) 
) 
/



Create table vozidlo (
	spz Char (7) NOT NULL ,
	id_preukaz Integer,
	typ_vozidla Char (1) NOT NULL  Check (typ_vozidla in ('O','A,'N') ) ,
primary key (spz) 
) 
/

Create table tarifa (
	id_tarifa Integer NOT NULL ,
	id_zona Integer NOT NULL ,
	platnost_od Date NOT NULL ,
	platnost_do Date NOT NULL ,
	suma Integer NOT NULL ,
	den Char (3) NOT NULL  Check (den in ('PRS','SOB','SVI') ) ,
	platena_doba Char (8),
primary key (id_tarifa) 
) 
/

------------------
Create table zlava (
	id_zlava Integer NOT NULL ,
	nazov Varchar2 (30) NOT NULL ,
	percenta Integer NOT NULL ,
	odkedy Date NOT NULL ,
	dokedy Date NOT NULL ,
primary key (id_zlava) 
) 
/
Create table kupon (
	id_kupon Integer NOT NULL ,
	id_zlava Integer NOT NULL ,
primary key (id_kupon) 
) 
/
Create table rezervacia (
	id_rezervacia Integer NOT NULL ,
	id_preukaz Integer NOT NULL ,
	zaciatok Date NOT NULL ,
	stav Char (3) NOT NULL  Check (stav in ('SCH','NES','ZRU') ) ,
	dlzka Interval day (2) to second (6) NOT NULL ,
	id_kupon Integer UNIQUE ,
primary key (id_rezervacia) 
) 
/

Create table rezervacia_park_miesta (
	id_rezervacia_park_miesto Integer NOT NULL ,
	id_rezervacia Integer NOT NULL ,
	id_miesta Integer NOT NULL ,
primary key (id_rezervacia_park_miesto) 
) 
/

Create table historia_parkovania (
	id_historia Integer NOT NULL ,
	id_miesta Integer NOT NULL ,
	spz Char (7) NOT NULL ,
	id_rezervacia_park_miesto Integer,
	odkedy Date NOT NULL ,
	dokedy Date,
primary key (id_historia) 
) 
/

Create table platba (
	id_historia Integer NOT NULL ,
	datum Date NOT NULL ,
	cena Integer NOT NULL ,
primary key (id_historia) 
) 
/

Create table zlava_na_preukaz (
	id_preukaz Integer NOT NULL ,
	id_zlava Integer NOT NULL ,
	zaciatok_platnosti Date NOT NULL ,
	dokedy Date,
primary key (id_preukaz,id_zlava) 
) 
/




-- Create Foreign keys section

Alter table parkovacie_miesto add  foreign key (id_zona) references zona (id_zona) 
/

Alter table tarifa add  foreign key (id_zona) references zona (id_zona) 
/

Alter table rezervacia_park_miesta add  foreign key (id_miesta) references parkovacie_miesto (id_miesta) 
/

Alter table historia_parkovania add  foreign key (id_miesta) references parkovacie_miesto (id_miesta) 
/

Alter table vozidlo add  foreign key (id_preukaz) references preukaz (id_preukaz) 
/

Alter table rezervacia add  foreign key (id_preukaz) references preukaz (id_preukaz) 
/

Alter table zlava_na_preukaz add  foreign key (id_preukaz) references preukaz (id_preukaz) 
/

Alter table preukaz add  foreign key (id_zakaznik) references zakaznik (id_zakaznik) 
/

Alter table historia_parkovania add  foreign key (spz) references vozidlo (spz) 
/

Alter table platba add  foreign key (id_historia) references historia_parkovania (id_historia) 
/

Alter table rezervacia_park_miesta add  foreign key (id_rezervacia) references rezervacia (id_rezervacia) 
/

Alter table zlava_na_preukaz add  foreign key (id_zlava) references zlava (id_zlava) 
/

Alter table kupon add  foreign key (id_zlava) references zlava (id_zlava) 
/

Alter table historia_parkovania add  foreign key (id_rezervacia_park_miesto) references rezervacia_park_miesta (id_rezervacia_park_miesto) 
/

Alter table rezervacia add  foreign key (id_kupon) references kupon (id_kupon) 
/


-- Create Object Tables section


-- Create XMLType Tables section


-- Create Functions section


-- Create Sequences section


-- Create Packages section


-- Create Table comments section


-- Create Attribute comments section


