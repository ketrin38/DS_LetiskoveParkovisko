CREATE OR REPLACE PROCEDURE majitel_auta
(v_spz IN vozidlo.spz%TYPE,
v_meno_priezvisko OUT VARCHAR2)
IS
BEGIN
SELECT meno||' '|| priezvisko
INTO v_meno_priezvisko
FROM vozidlo vo 
    JOIN preukaz pr USING (id_preukaz)
    JOIN zakaznik za using(id_zakaznik)
WHERE vo.spz = v_spz;
END majitel_auta;
/
VARIABLE p_meno VARCHAR2(30);

EXECUTE majitel_auta('BA292UH', :p_meno);
PRINT p_meno;


