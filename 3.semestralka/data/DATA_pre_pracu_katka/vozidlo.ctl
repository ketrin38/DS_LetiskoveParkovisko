LOAD DATA
INFILE 'vozidlo.unl'
INTO TABLE vozidlo
FIELDS TERMINATED BY ';'
(
  spz,
  id_preukaz,
typ_vozidla
)

