SELECT spz, id_miesta
  FROM vozidlo
  JOIN historia_parkovania
 USING (spz)
 JOIN parkovacie_miesto
 USING (id_miesta)
 JOIN zona
 USING (id_zona)
 WHERE TO_DATE(sysdate + (maximalna_doba/24),'DD.MM.YYYY HH24:MI:SS') > nvl(dokedy, sysdate);