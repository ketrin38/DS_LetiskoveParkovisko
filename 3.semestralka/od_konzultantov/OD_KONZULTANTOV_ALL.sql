 -- 1.	V�pis �PZ z�kazn�kov, ktor� parkovali viac ako 5-kr�t za posledn� rok.
        SELECT SPZ, count(*)
          FROM HISTORIA_PARKOVANIA
         WHERE (ODKEDY >= ADD_MONTHS(sysdate, -12) 
            OR NVL(dokedy, sysdate) >= add_months(sysdate, -12))
      GROUP BY spz
        HAVING COUNT(*) > 5;

-- 2.	V�pis po�tu zamestnancov letiska, ktor� platili za parkovanie za minul� mesiac.
        SELECT COUNT(*)
          FROM ZAKAZNIK ZAK
    INNER JOIN PREUKAZ PR
         USING (ID_ZAKAZNIK)
    INNER JOIN VOZIDLO VOZ
         USING (ID_PREUKAZ)
    INNER JOIN HISTORIA_PARKOVANIA HP
         USING (SPZ)
    INNER JOIN PLATBA PL
         USING (ID_HISTORIA)
         WHERE TO_CHAR(PL.DATUM,'MM.YYYY') = TO_CHAR(SYSDATE - INTERVAL '1' MONTH,'MM.YYYY')
           AND ZAK.TYP = 'Z';
         
-- 3.	V�pis 5 naj�astej��ch z�kazn�kov za tento rok.
        SELECT ZAK.MENO,ZAK.PRIEZVISKO
          FROM (
                SELECT MENO,PRIEZVISKO,COUNT(*) 
                  FROM ZAKAZNIK
                  JOIN PREUKAZ 
                 USING (ID_ZAKAZNIK)
                  JOIN VOZIDLO 
                 USING (ID_PREUKAZ)
                  JOIN HISTORIA_PARKOVANIA 
                 USING (SPZ)
                 WHERE TO_CHAR(ODKEDY,'YYYY') = TO_CHAR(SYSDATE,'YYYY')
                    OR TO_CHAR(NVL(DOKEDY,SYSDATE),'YYYY') = TO_CHAR(SYSDATE,'YYYY')
              GROUP BY MENO,PRIEZVISKO,ID_ZAKAZNIK
              ORDER BY COUNT(*) DESC
              ) ZAK 
         WHERE ROWNUM <= 5;
         
-- 4.	V�pis po�tu z�kazn�kov/firiem ktor� sa registrovali tento mesiac.
        SELECT COUNT(*)
          FROM PREUKAZ
         WHERE ZACIATOK_PLATNOSTI BETWEEN TO_DATE('01.' || to_char(sysdate,'MM.YYYY'),'dd.mm.yyyy') AND SYSDATE;

-- 5.	V�pis sumy platieb be�n�ch z�kazn�kov za dne�n� de�.
        SELECT SUM(CENA) 
          FROM PLATBA 
          JOIN HISTORIA_PARKOVANIA HP 
         USING (ID_HISTORIA)
         WHERE EXISTS
                (SELECT 'x' 
                   FROM VOZIDLO VO
                  WHERE VO.SPZ = HP.SPZ
                    AND VO.ID_PREUKAZ IS NULL)
           AND PLATBA.DATUM = sysdate;
           
   