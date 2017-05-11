-- FUNKCIA KONTOLUJUCA PLATNOST ZLAVY
create or replace FUNCTION func_skontroluj_platnost_zlavy
( p_id_zlava rezervacia.id_kupon%TYPE,
  p_datum DATE
)
RETURN integer
AS
  pom integer;
BEGIN
  SELECT count(*) INTO pom
    FROM  zlava 
      WHERE  p_id_zlava = id_zlava
        AND p_datum BETWEEN odkedy AND dokedy;
      
   IF ( pom = 0 ) THEN
      RETURN 0;
   END IF;
   RETURN 1;
END;
