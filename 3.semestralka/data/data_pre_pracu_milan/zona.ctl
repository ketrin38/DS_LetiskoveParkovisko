LOAD DATA
INFILE 'zona.csv'
INTO TABLE zona
FIELDS TERMINATED BY ';'
(
  ID_ZONA,
  maximalna_doba,
 typ_vozidlo,
typ_zona
)

