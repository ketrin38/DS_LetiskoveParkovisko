LOAD DATA
INFILE 'preukaz.unl'
INTO TABLE preukaz
FIELDS TERMINATED BY '|'
(
  ID_PREUKAZ,
  ID_ZAKAZNIK,
  ZACIATOK_PLATNOSTI DATE 'MM/DD/YYYY',
  KONIEC_PLATNOSTI DATE 'MM/DD/YYYY'
)
