LOAD DATA
INFILE 'parkovacie_miesto.csv'
INTO TABLE parkovacie_miesto
FIELDS TERMINATED BY ';'
(
  ID_MIESTA,
  ID_ZONA
)

