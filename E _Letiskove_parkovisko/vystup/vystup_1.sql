-- 1
SELECT id_miesta
FROM parkovacie_miesto pm
    JOIN zona 
    USING (id_zona)
    WHERE NOT EXISTS (
    SELECT 'x'
        FROM historia_parkovania hp
        WHERE hp.id_miesta = pm.id_miesta AND 
        (   
             odkedy>=sysdate and odkedy<sysdate
              or 
               nvl(dokedy,sysdate)<=nvl(sysdate,sysdate)  and nvl(dokedy,sysdate) >sysdate
               or
                odkedy<=sysdate and  nvl(dokedy,sysdate) >= nvl(sysdate,sysdate)
        )
        ) AND typ_vozidlo = &typ_vozidlo;
           

CREATE OR REPLACE PROCEDURE p_volne_miesta
    (PAR_ODKEDY IN DATE, 
     PAR_DOKEDY IN DATE, 
     PAR_TYP_VOZIDLO IN ZONA.TYP_VOZIDLO%TYPE,
     V_VOLNE_MIESTA OUT VARCHAR2)
IS
BEGIN 
dbms_output.put_line('Zoznam vo¾ných parkovacích miest');
   for a in (SELECT ID_MIESTA
      FROM PARKOVACIE_MIESTO PM
      JOIN ZONA 
     USING (ID_ZONA)
     WHERE NOT EXISTS (
            SELECT 'x'
              FROM historia_parkovania hp
             WHERE hp.id_miesta = pm.id_miesta 
               AND (ODKEDY>=PAR_ODKEDY 
                    AND ODKEDY < PAR_DOKEDY
                     OR NVL(DOKEDY,sysdate)<= NVL(PAR_DOKEDY,sysdate)  
                    AND NVL(DOKEDY,sysdate) > PAR_ODKEDY
                     OR ODKEDY <= PAR_ODKEDY 
                    AND  NVL(DOKEDY,sysdate) >= NVL(PAR_DOKEDY,sysdate)
                    )
                ) 
       AND typ_vozidlo = PAR_TYP_VOZIDLO
       
       )
       loop
        dbms_output.put_line(a.id_miesta);
        end loop;
      

END p_volne_miesta;
/
    
SHOW ERRORS;                         
   SET SERVEROUTPUT ON;
VARIABLE V_VOLNE_MIESTA VARCHAR2(30);                          
EXECUTE p_volne_miesta('08.05.2017', sysdate, 'O', :V_VOLNE_MIESTA);
PRINT V_VOLNE_MIESTA;
select * from zlava_na_preukaz;
select * from platba
join historia_parkovania using(id_historia)
join vozidlo using(spz)
join parkovacie_miesto using(id_miesta)
join zona using(id_zona);
