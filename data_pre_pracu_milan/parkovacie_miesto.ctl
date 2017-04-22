LOAD DATA
INFILE 'parkovacie_miesto.unl'
INTO TABLE parkovacie_miesto
FIELDS TERMINATED BY '|'
(
  ID_MIESTA,
  ID_ZONA
)

