LOAD DATA
INFILE 'platba.csv'
INTO TABLE platba
FIELDS TERMINATED BY ';'
(
  ID_HISTORIA,
  DATUM DATE 'YYYY-MM-DD',
  CENA
)
