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

commit;
-- preukaz
INSERT INTO preukaz
VALUES (1, 1, to_date('10.04.2013','DD.MM.YYYY'), to_date('10.4.2018','DD.MM.YYYY'));

INSERT INTO preukaz
VALUES (2, 2, to_date('03.07.2015','DD.MM.YYYY'), to_date('03.07.2020','DD.MM.YYYY'));

INSERT INTO preukaz
VALUES (3, 3, to_date('24.12.2015','DD.MM.YYYY'), to_date('24.12.2020','DD.MM.YYYY'));

INSERT INTO preukaz
VALUES (4, 4, to_date('29.08.2016','DD.MM.YYYY'), to_date('29.8.2021','DD.MM.YYYY'));

INSERT INTO preukaz
VALUES (5, 5, to_date('01.01.2017','DD.MM.YYYY'), to_date('01.01.2022','DD.MM.YYYY'));
commit;
-- vozidlo

INSERT INTO vozidlo
VALUES ('ZA123AA', 1, 'O');

INSERT INTO vozidlo
VALUES ('ZA321BB', 2, 'A');

INSERT INTO vozidlo
VALUES ('BA456AA', 3, 'O');

INSERT INTO vozidlo
VALUES ('BA456AB', 3, 'N');

INSERT INTO vozidlo
VALUES ('BA456AC', 3, 'N');

INSERT INTO vozidlo
VALUES ('BA456AD', 3, 'A');

INSERT INTO vozidlo
VALUES ('ZA789EQ', 4, 'O');

INSERT INTO vozidlo
VALUES ('ZA555FE', 5, 'O');

commit;
-- zlava
INSERT INTO zlava
VALUES (1, 'Jarna zlava', 25, to_date('20.03.2013','DD.MM.YYYY'), to_date('20.06.2013','DD.MM.YYYY'));

INSERT INTO zlava
VALUES (2, 'Prazdninova zlava', 20, to_date('01.07.2015','DD.MM.YYYY'), to_date('31.08.2015','DD.MM.YYYY'));

INSERT INTO zlava
VALUES (3, 'Vianocna zlava', 30, to_date('20.12.2015','DD.MM.YYYY'), to_date('06.01.2016','DD.MM.YYYY'));

INSERT INTO zlava
VALUES (4, 'Prazdninova zlava', 20, to_date('01.07.2016','DD.MM.YYYY'), to_date('31.08.2016','DD.MM.YYYY'));

INSERT INTO zlava
VALUES (5, 'Vianocna zlava', 30, to_date('20.12.2016','DD.MM.YYYY'), to_date('06.01.2017','DD.MM.YYYY'));
commit;

-- zlava na preukaz
INSERT INTO zlava_na_preukaz(id_preukaz, id_zlava, zaciatok_platnosti)
VALUES (1, 1, to_date('10.04.2013','DD.MM.YYYY'));

INSERT INTO zlava_na_preukaz(id_preukaz, id_zlava, zaciatok_platnosti)
VALUES (2, 2, to_date('03.07.2015','DD.MM.YYYY'));

INSERT INTO zlava_na_preukaz(id_preukaz, id_zlava, zaciatok_platnosti)
VALUES (3, 3, to_date('24.12.2015','DD.MM.YYYY'));

INSERT INTO zlava_na_preukaz(id_preukaz, id_zlava, zaciatok_platnosti)
VALUES (4, 4, to_date('29.08.2016','DD.MM.YYYY'));

INSERT INTO zlava_na_preukaz(id_preukaz, id_zlava, zaciatok_platnosti)
VALUES (5, 5, to_date('01.01.2017','DD.MM.YYYY'));

commit;
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
commit;
-- tarifa
INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (1, 1, to_date('01.01.2015','DD.MM.YYYY'), to_date('01.01.2020','DD.MM.YYYY'), 3, 'PRC');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (2, 2, to_date('01.01.2015','DD.MM.YYYY'), to_date('01.01.2020','DD.MM.YYYY'), 0, 'PRC');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (3, 3, to_date('01.01.2015','DD.MM.YYYY'), to_date('01.01.2020','DD.MM.YYYY'), 5, 'PRC');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (4, 4, to_date('01.01.2015','DD.MM.YYYY'), to_date('01.01.2020','DD.MM.YYYY'), 7, 'PRC');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (5, 5, to_date('01.01.2015','DD.MM.YYYY'), to_date('01.01.2020','DD.MM.YYYY'), 0, 'PRC');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (6, 1, to_date('01.01.2015','DD.MM.YYYY'), to_date('01.01.2020','DD.MM.YYYY'), 2, 'SOB');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (7, 2, to_date('01.01.2015','DD.MM.YYYY'), to_date('01.01.2020','DD.MM.YYYY'), 0, 'SOB');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (8, 3, to_date('01.01.2015','DD.MM.YYYY'), to_date('01.01.2020','DD.MM.YYYY'), 4, 'SOB');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (9, 4, to_date('01.01.2015','DD.MM.YYYY'), to_date('01.01.2020','DD.MM.YYYY'), 5, 'SOB');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (10, 5, to_date('01.01.2015','DD.MM.YYYY'), to_date('01.01.2020','DD.MM.YYYY'), 0, 'SOB');
commit;
INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (11, 1, to_date('01.01.2015','DD.MM.YYYY'), to_date('01.01.2020','DD.MM.YYYY'), 1, 'SVI');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (12, 2, to_date('01.01.2015','DD.MM.YYYY'), to_date('01.01.2020','DD.MM.YYYY'), 0, 'SVI');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (13, 3, to_date('01.01.2015','DD.MM.YYYY'), to_date('01.01.2020','DD.MM.YYYY'), 4, 'SVI');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (14, 4, to_date('01.01.2015','DD.MM.YYYY'), to_date('01.01.2020','DD.MM.YYYY'), 4, 'SVI');

INSERT INTO tarifa(id_tarifa, id_zona, platnost_od, platnost_do, suma, den)
VALUES (15, 5, to_date('01.01.2015','DD.MM.YYYY'), to_date('01.01.2020','DD.MM.YYYY'), 0, 'SVI');

commit;
-- parkovacie_miesta
INSERT INTO parkovacie_miesto
VALUES (1, 1);

INSERT INTO parkovacie_miesto
VALUES (2, 1);

INSERT INTO parkovacie_miesto
VALUES (3, 1);

INSERT INTO parkovacie_miesto
VALUES (4, 1);

INSERT INTO parkovacie_miesto
VALUES (5, 1);

INSERT INTO parkovacie_miesto
VALUES (6, 1);

INSERT INTO parkovacie_miesto
VALUES (7, 1);

INSERT INTO parkovacie_miesto
VALUES (8, 1);

INSERT INTO parkovacie_miesto
VALUES (9, 1);

INSERT INTO parkovacie_miesto
VALUES (10, 1);

INSERT INTO parkovacie_miesto
VALUES (11, 2);

INSERT INTO parkovacie_miesto
VALUES (12, 2);

INSERT INTO parkovacie_miesto
VALUES (13, 2);

INSERT INTO parkovacie_miesto
VALUES (14, 2);

INSERT INTO parkovacie_miesto
VALUES (15, 3);

INSERT INTO parkovacie_miesto
VALUES (16, 3);

INSERT INTO parkovacie_miesto
VALUES (17, 4);

INSERT INTO parkovacie_miesto
VALUES (18, 4);

INSERT INTO parkovacie_miesto
VALUES (19, 5);

INSERT INTO parkovacie_miesto
VALUES (20, 5);
commit;

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
VALUES (301, 1, 1, to_date('07.12.2016 20:30:14','DD.MM.YYYY HH24:MI:SS'), 'SCH', INTERvAL '1' hour);

INSERT INTO rezervacia
VALUES (302, 2, 2, to_date('08.08.2017 15:12:01','DD.MM.YYYY HH24:MI:SS'), 'NES',INTERvAL '4' hour);

INSERT INTO rezervacia
VALUES (303, 3, 3, to_date('20.04.2017 17:45:00','DD.MM.YYYY HH24:MI:SS'), 'ZRU',INTERVAL  '3' hour);

INSERT INTO rezervacia(id_rezervacia, id_preukaz, zaciatok, stav, dlzka)
VALUES (304, 3, to_date('20.07.2017 21:19:01', 'DD.MM.YYYY HH24:MI:SS'), 'NES', INTERVAL '5' hour);

INSERT INTO rezervacia(id_rezervacia, id_preukaz, zaciatok, stav, dlzka)
VALUES (305, 3, to_date('17.08.2017 15:25:13','DD.MM.YYYY HH24:MI:SS'), 'NES', INTERVAL '7' hour);

INSERT INTO rezervacia(id_rezervacia, id_preukaz, zaciatok, stav, dlzka)
VALUES (306, 2, to_date('15.04.2017 12:14:00','DD.MM.YYYY HH24:MI:SS'), 'ZRU', INTERVAL '2' hour);

INSERT INTO rezervacia
VALUES (307, 1, 4, to_date('10.09.2017 22:00:15','DD.MM.YYYY HH24:MI:SS'), 'ZRU',INTERVAL '8' hour);

INSERT INTO rezervacia
VALUES (308, 3, 6, to_date('12.03.2017 03:01:05','DD.MM.YYYY HH24:MI:SS'), 'SCH',INTERVAL '1' hour);
commit;
-- rezervacia park miesta
INSERT INTO rezervacia_park_miesta
VALUES (301, 1, 3);

INSERT INTO rezervacia_park_miesta
VALUES (302, 2, 7);

INSERT INTO rezervacia_park_miesta
VALUES (303, 3, 15);

INSERT INTO rezervacia_park_miesta
VALUES (304, 4, 2);

INSERT INTO rezervacia_park_miesta
VALUES (305, 5, 18);

INSERT INTO rezervacia_park_miesta
VALUES (306, 6, 8);

INSERT INTO rezervacia_park_miesta
VALUES (307, 7, 9);

INSERT INTO rezervacia_park_miesta
VALUES (308, 8, 17);
commit;
-- historia parkovania
INSERT INTO historia_parkovania(id_historia, id_miesta, spz, odkedy)
VALUES (301, 5, 'ZA123AA', to_date('01.04.2017 03:05:11','DD.MM.YYYY HH24:MI:SS'));

INSERT INTO historia_parkovania(id_historia, id_miesta, spz, odkedy)
VALUES (302, 5, 'ZA123AA', to_date('17.04.2017 12:12:54','DD.MM.YYYY HH24:MI:SS'));

INSERT INTO historia_parkovania(id_historia, id_miesta, spz, odkedy)
VALUES (303, 18, 'BA456AB', to_date('10.03.2017 17:54:32','DD.MM.YYYY HH24:MI:SS'));

INSERT INTO historia_parkovania(id_historia, id_miesta, spz, odkedy)
VALUES (304, 16, 'BA456AD', to_date('11.03.2017 10:35:14','DD.MM.YYYY HH24:MI:SS'));

INSERT INTO historia_parkovania(id_historia, id_miesta, spz, odkedy)
VALUES (305, 16, 'BA456AD', to_date('12.03.2017 14:15:51','DD.MM.YYYY HH24:MI:SS'));

INSERT INTO historia_parkovania(id_historia, id_miesta, spz, id_rezervacia_park_miesto, odkedy)
VALUES (306, 17, 'BA456AC', 8, to_date('12.03.2017 17:54:14','DD.MM.YYYY HH24:MI:SS'));

INSERT INTO historia_parkovania(id_historia, id_miesta, spz, id_rezervacia_park_miesto, odkedy)
VALUES (307, 1, 'ZA123AA', 1, to_date('07.12.2016 12:54:32','DD.MM.YYYY HH24:MI:SS'));


-- platba
INSERT INTO platba
VALUES (301, to_date('14.04.2017','DD.MM.YYYY'), 9);

INSERT INTO platba
VALUES (302, to_date('17.04.2017','DD.MM.YYYY'), 12);

INSERT INTO platba
VALUES (303, to_date('10.03.2017','DD.MM.YYYY'), 21);

INSERT INTO platba
VALUES (304, to_date('14.04.2017','DD.MM.YYYY'), 8);

INSERT INTO platba
VALUES (305, to_date('14.04.2017','DD.MM.YYYY'), 16);

INSERT INTO platba
VALUES (306, to_date('12.03.2017','DD.MM.YYYY'), 7);

INSERT INTO platba
VALUES (307, to_date('07.12.2016','DD.MM.YYYY'), 3);




commit;






