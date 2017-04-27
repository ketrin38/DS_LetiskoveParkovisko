LOAD DATA
INFILE 'vozidlo.csv'
INTO TABLE vozidlo
FIELDS TERMINATED BY ';'
(
  spz,
  id_preukaz,
typ_vozidla
)

