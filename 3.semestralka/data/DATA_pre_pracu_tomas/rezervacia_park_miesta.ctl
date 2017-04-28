LOAD DATA
INFILE 'rezervacia_park_miesta.unl'
INTO TABLE rezervacia_park_miesta
FIELDS TERMINATED BY '|'
(
  id_rezervacia_park_miesto,
  ID_REZERVACIA,
  ID_MIESTA
)

