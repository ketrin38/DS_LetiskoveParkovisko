LOAD DATA
INFILE 'rezervacia_park_miesta.unl'
INTO TABLE rezervacia_park_miesta
FIELDS TERMINATED BY '|'
(
  ID_REZERVACIA_PARK_MIESTA
  ID_REZERVACIA
  ID_MIESTA
)

