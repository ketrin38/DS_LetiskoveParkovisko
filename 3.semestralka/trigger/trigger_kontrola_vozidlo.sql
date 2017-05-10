create or replace TRIGGER t_zona_vozidlo
    BEFORE INSERT
    ON historia_parkovania
    FOR EACH ROW
    declare vozidlo_typ vozidlo.typ_vozidla%TYPE;
            zona_vozidlo zona.typ_vozidlo%TYPE;
        BEGIN
           select typ_vozidla into vozidlo_typ
           from vozidlo where spz=:new.spz;
           
           select typ_vozidlo into zona_vozidlo from zona join parkovacie_miesto using(id_zona) 
           where id_miesta=:new.id_miesta;
           
            IF (vozidlo_typ != zona_vozidlo) THEN
                RAISE_APPLICATION_ERROR(-20000, 'Nemoze parkovat na danom parkovacom mieste');
            END IF;
        END;
        /

INSERT INTO historia_parkovania(id_historia, id_miesta, spz, odkedy) 
VALUES (500,640, 'BA621NA',sysdate);

DELETE FROM historia_parkovania
WHERE id_historia = 500;