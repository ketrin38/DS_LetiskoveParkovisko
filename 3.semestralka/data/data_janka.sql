-- zakaznik
INSERT INTO zakaznik
VALUES (1, 'Jan', 'Franek', 'S');

INSERT INTO zakaznik
VALUES (2, 'Andrej', 'Gregus', 'S');

INSERT INTO zakaznik
VALUES (3, 'Alexander', 'Velky', 'F');

INSERT INTO zakaznik
VALUES (4, 'Rastislav', 'Stefanik', 'Z');

INSERT INTO zakaznik
VALUES (5, 'Ferdinand', 'Lehotsky', 'Z');


-- preukaz
INSERT INTO preukaz
VALUES (1, 1, '10.4.2013', '10.4.2018');

INSERT INTO preukaz
VALUES (2, 2, '3.7.2015', '3.7.2020');

INSERT INTO preukaz
VALUES (3, 3, '24.12.2015', '24.12.2020');

INSERT INTO preukaz
VALUES (4, 4, '29.8.2016', '29.8.2021');

INSERT INTO preukaz
VALUES (5, 5, '1.1.2017', '1.1.2022');

-- vozidlo
INSERT INTO vozidlo
VALUES ('ZA123AA', 1, '0');

INSERT INTO vozidlo
VALUES ('ZA321BB', 2, 'A');

INSERT INTO vozidlo
VALUES ('BA456AA', 3, '0');

INSERT INTO vozidlo
VALUES ('BA456AB', 3, 'N');

INSERT INTO vozidlo
VALUES ('BA456AC', 3, 'N');

INSERT INTO vozidlo
VALUES ('BA456AD', 3, 'A');

INSERT INTO vozidlo
VALUES ('ZA789EQ', 4, '0');

INSERT INTO vozidlo
VALUES ('ZA555FE', 5, '0');


-- zlava
INSERT INTO zlava
VALUES (1, 'Jarna zlava', 25, '20.3.2013', '20.6.2013');

INSERT INTO zlava
VALUES (2, 'Prazdninova zlava', 20, '1.7.2015', '31.8.2015');

INSERT INTO zlava
VALUES (3, 'Vianocna zlava', 30, '20.12.2015', '6.1.2016');

INSERT INTO zlava
VALUES (4, 'Prazdninova zlava', 20, '1.7.2016', '31.8.2016');

INSERT INTO zlava
VALUES (5, 'Vianocna zlava', 30, '20.12.2016', '6.1.2017');


-- zlava na preukaz
INSERT INTO zlava_na_preukaz(id_preukaz, id_zlava, zaciatok_platnosti)
VALUES (1, 1, '10.4.2013');

INSERT INTO zlava_na_preukaz(id_preukaz, id_zlava, zaciatok_platnosti)
VALUES (2, 2, '3.7.2015');

INSERT INTO zlava_na_preukaz(id_preukaz, id_zlava, zaciatok_platnosti)
VALUES (3, 3, '24.12.2015');

INSERT INTO zlava_na_preukaz(id_preukaz, id_zlava, zaciatok_platnosti)
VALUES (4, 4, '29.8.2016');

INSERT INTO zlava_na_preukaz(id_preukaz, id_zlava, zaciatok_platnosti)
VALUES (5, 5, '1.1.2017');


-- zona
INSERT INTO zona
VALUES (1, 50, 'O', 'V');

INSERT INTO zona
VALUES (2, 100, 'O', 'Z');

INSERT INTO zona
VALUES (3, 50, 'A', 'V');

INSERT INTO zona
VALUES (4, 50, 'N', 'V');

INSERT INTO zona
VALUES (5, 100, 'N', 'Z');

-- tarifa
INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (1, 1, '1.1.2015', '1.1.2020', 3, 'PRC');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (2, 2, '1.1.2015', '1.1.2020', 0, 'PRC');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (3, 3, '1.1.2015', '1.1.2020', 5, 'PRC');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (4, 4, '1.1.2015', '1.1.2020', 7, 'PRC');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (5, 5, '1.1.2015', '1.1.2020', 0, 'PRC');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (6, 1, '1.1.2015', '1.1.2020', 2, 'SOB');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (7, 2, '1.1.2015', '1.1.2020', 0, 'SOB');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (8, 3, '1.1.2015', '1.1.2020', 4, 'SOB');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (9, 4, '1.1.2015', '1.1.2020', 5, 'SOB');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (10, 5, '1.1.2015', '1.1.2020', 0, 'SOB');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (11, 1, '1.1.2015', '1.1.2020', 1, 'NED');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (12, 2, '1.1.2015', '1.1.2020', 0, 'NED');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (13, 3, '1.1.2015', '1.1.2020', 4, 'NED');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (14, 4, '1.1.2015', '1.1.2020', 4, 'NED');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (15, 5, '1.1.2015', '1.1.2020', 0, 'NED');


-- parkovacie_miesta
INSERT INTO parkovacie_miesta
VALUES (1, 1);

INSERT INTO parkovacie_miesta
VALUES (2, 1);

INSERT INTO parkovacie_miesta
VALUES (3, 1);

INSERT INTO parkovacie_miesta
VALUES (4, 1);

INSERT INTO parkovacie_miesta
VALUES (5, 1);

INSERT INTO parkovacie_miesta
VALUES (6, 1);

INSERT INTO parkovacie_miesta
VALUES (7, 1);

INSERT INTO parkovacie_miesta
VALUES (8, 1);

INSERT INTO parkovacie_miesta
VALUES (9, 1);

INSERT INTO parkovacie_miesta
VALUES (10, 1);

INSERT INTO parkovacie_miesta
VALUES (11, 2);

INSERT INTO parkovacie_miesta
VALUES (12, 2);

INSERT INTO parkovacie_miesta
VALUES (13, 2);

INSERT INTO parkovacie_miesta
VALUES (14, 2);

INSERT INTO parkovacie_miesta
VALUES (15, 3);

INSERT INTO parkovacie_miesta
VALUES (16, 3);

INSERT INTO parkovacie_miesta
VALUES (17, 4);

INSERT INTO parkovacie_miesta
VALUES (18, 4);

INSERT INTO parkovacie_miesta
VALUES (19, 5);

INSERT INTO parkovacie_miesta
VALUES (20, 5);


-- kupon
INSERT INTO kupon
VALUES (1, 1);

INSERT INTO kupon
VALUES (2, 2);

INSERT INTO kupon
VALUES (3, 3);

INSERT INTO kupon
VALUES (4, 1);

INSERT INTO kupon
VALUES (5, 3);

INSERT INTO kupon
VALUES (6, 3);

-- rezervacia
INSERT INTO rezervacia
VALUES (1, 1, 1, '7.12.2016', 'SCH', 1);

INSERT INTO rezervacia
VALUES (2, 2, 2, '8.8.2017', 'NES', 4);

INSERT INTO rezervacia
VALUES (3, 3, 3, '20.4.2017', 'ZRU', 3);

INSERT INTO rezervacia(id_rezervacia, id_preukaz, zaciatok, stav, dlzka)
VALUES (4, 3, '20.7.2017', 'NES', 5);

INSERT INTO rezervacia(id_rezervacia, id_preukaz, zaciatok, stav, dlzka)
VALUES (5, 3, '17.8.2017', 'NES', 7);

INSERT INTO rezervacia(id_rezervacia, id_preukaz, zaciatok, stav, dlzka)
VALUES (6, 2, '15.4.2017', 'ZRU', 2);

INSERT INTO rezervacia
VALUES (7, 1, 4, '10.9.2017', 'ZRU', 8);

INSERT INTO rezervacia
VALUES (8, 3, 6, '12.3.2017', 'SCH', 1);


-- rezervacia park miesta
INSERT INTO rezervacia_park_miesta
VALUES (1, 1, 3);

INSERT INTO rezervacia_park_miesta
VALUES (2, 2, 7);

INSERT INTO rezervacia_park_miesta
VALUES (3, 3, 15);

INSERT INTO rezervacia_park_miesta
VALUES (4, 4, 2);

INSERT INTO rezervacia_park_miesta
VALUES (5, 5, 18);

INSERT INTO rezervacia_park_miesta
VALUES (6, 6, 8);

INSERT INTO rezervacia_park_miesta
VALUES (7, 7, 9);

INSERT INTO rezervacia_park_miesta
VALUES (8, 8, 17);

-- historia parkovania
INSERT INTO historia_parkovania(id_historia, id_miesta, spz, odkedy)
VALUES (1, 5, 'ZA123AA', '14.4.2017');

INSERT INTO historia_parkovania(id_historia, id_miesta, spz, odkedy)
VALUES (2, 5, 'ZA123AA', '17.4.2017');

INSERT INTO historia_parkovania(id_historia, id_miesta, spz, odkedy)
VALUES (3, 18, 'BA456AB', '10.3.2017');

INSERT INTO historia_parkovania(id_historia, id_miesta, spz, odkedy)
VALUES (4, 16, 'BA456AD', '11.3.2017');

INSERT INTO historia_parkovania(id_historia, id_miesta, spz, odkedy)
VALUES (5, 16, 'BA456AD', '12.3.2017');

INSERT INTO historia_parkovania(id_historia, id_miesta, spz, id_rezervacia_park_miesto, odkedy)
VALUES (6, 17, 'BA456AC', 8, '12.3.2017');

INSERT INTO historia_parkovania(id_historia, id_miesta, spz, id_rezervacia_park_miesto, odkedy)
VALUES (7, 1, 'ZA123AA', 1, '7.12.2016');


-- platba
INSERT INTO platba
VALUES (1, '14.4.2017', 9);

INSERT INTO platba
VALUES (2, '17.4.2017', 12);

INSERT INTO platba
VALUES (3, '10.3.2017', 21);

INSERT INTO platba
VALUES (4, '14.4.2017', 8);

INSERT INTO platba
VALUES (5, '14.4.2017', 16);

INSERT INTO platba
VALUES (6, '12.3.2017', 7);

INSERT INTO platba
VALUES (7, '7.12.2016', 3);