LOAD DATA
INFILE 'tarifa.csv'
INTO TABLE tarifa
FIELDS TERMINATED BY ';'
(
  ID_tarifa,
  ID_Zona,
  platnost_od DATE 'DD.MM.YYYY',
  platnost_do DATE 'DD.MM.YYYY',
  suma,
  den,
  platena_doba
)

