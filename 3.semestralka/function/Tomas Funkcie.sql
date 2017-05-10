--###################################################################################################################################
-- Pomocna funkcia pri vypise faktury pre vypocet ceny jedneho parkovania ktore nie je zaplatene v dnom obdobii pre daneho zakaznika

create or replace FUNCTION get_cena_jednotkova
  (p_spz IN VOZIDLO.SPZ%TYPE, p_odkedy IN DATE, p_dokedy IN DATE)
RETURN integer
  IS 
   r_cena integer;
   h_miesto integer;
   h_preukaz integer;
   h_rezervacia integer;
   h_pocet integer;
BEGIN
  SELECT id_miesta, id_rezervacia_park_miesto
    INTO h_miesto, h_rezervacia FROM historia_parkovania
      WHERE spz = p_spz
        AND dokedy = p_dokedy
          AND odkedy = p_odkedy;
 
  r_cena := GET_CENA_PARKOVANIA(p_odkedy, p_dokedy, h_miesto);
  
  return r_cena;
  
  IF (TYP_ZAKAZNIK(p_spz) = 'Z' AND TYP_ZONA(h_miesto) = 'Z') THEN
    return 0;
  END IF;
  
  SELECT ID_PREUKAZ INTO h_preukaz FROM vozidlo
    WHERE spz = p_spz;
  
  IF (h_preukaz IS NULL) THEN
    return r_cena;
  END IF;
  
  
  IF (h_rezervacia IS NULL) THEN
    r_cena := r_cena - (r_cena * (GET_ZLAVA_NA_PREUKAZ(h_preukaz, p_odkedy, p_dokedy)/ 100));
    IF(GET_ZLAVA_KUPON(h_rezervacia, p_odkedy) > 0) THEN
      r_cena := r_cena - (r_cena * (GET_ZLAVA_KUPON(h_rezervacia, p_odkedy) / 100));
    END IF;
  END IF;

  return r_cena;
END;


--###################################################################################################################################
-- Vrati cenu parkovacieho miesta v danom case

create or replace FUNCTION get_cena_par_miesta
	(p_id_miesto IN PARKOVACIE_MIESTO.ID_MIESTA%TYPE,
    p_odkedy IN DATE)
RETURN INTEGER
IS 
r_cena integer;
BEGIN
  SELECT SUMA_ZA_HODINU INTO r_cena FROM TARIFA
    JOIN ZONA USING (ID_ZONA)
      JOIN PARKOVACIE_MIESTO USING (ID_ZONA)  
      WHERE ID_MIESTA = p_id_miesto
      AND p_odkedy BETWEEN PLATNOST_OD AND PLATNOST_DO;
      
  return r_cena;
END;


--###################################################################################################################################
-- vrati cenu parkovania pri odchode zakaznika z parkoviska

create or replace FUNCTION get_aktualna_cena
  (p_spz IN VOZIDLO.SPZ%TYPE)
RETURN integer
  IS 
   r_cena integer;
   h_odkedy date;
   h_miesto integer;
   h_preukaz integer;
   h_rezervacia integer;
   h_pocet integer;
BEGIN
  SELECT count(*) into h_pocet
  FROM historia_parkovania
      WHERE spz = p_spz
        AND dokedy is NULL
          AND odkedy < sysdate;
          
  IF (h_pocet = 0) THEN
    return 0;
  END IF;

  SELECT id_miesta, odkedy, id_rezervacia_park_miesto
    INTO h_miesto, h_odkedy, h_rezervacia FROM historia_parkovania
      WHERE spz = p_spz
        AND dokedy is NULL
          AND odkedy < sysdate; 
 
  r_cena := GET_CENA_PARKOVANIA(h_odkedy, sysdate, h_miesto);
  
  return r_cena;
  
  IF (TYP_ZAKAZNIK(p_spz) = 'Z' AND TYP_ZONA(h_miesto) = 'Z') THEN
    return 0;
  END IF;
  
  SELECT ID_PREUKAZ INTO h_preukaz FROM vozidlo
    WHERE spz = p_spz;
  
  IF (h_preukaz IS NULL) THEN
    return r_cena;
  END IF;
  
  
  IF (h_rezervacia IS NULL) THEN
    r_cena := r_cena - (r_cena * (GET_ZLAVA_NA_PREUKAZ(h_preukaz, h_odkedy, sysdate)/ 100));
    IF(GET_ZLAVA_KUPON(h_rezervacia, h_odkedy) > 0) THEN
      r_cena := r_cena - (r_cena * (GET_ZLAVA_KUPON(h_rezervacia, h_odkedy) / 100));
    END IF;
  END IF;

  return r_cena;
END;


--###################################################################################################################################
-- Vrati zakladnu sumu za parkovanie. Bez odpocitania vsetkych zliav

create or replace FUNCTION get_cena_parkovania
  (p_date_from IN DATE, p_date_to IN DATE, p_miesto IN NUMBER)
RETURN integer
  IS 
  h_cena_hodina integer;
  h_platena_doba char(8);
  r_cena integer;
BEGIN
  SELECT suma_za_hodinu, platena_doba INTO h_cena_hodina, h_platena_doba 
    FROM tarifa
     JOIN ZONA USING(id_zona)
      JOIN PARKOVACIE_MIESTO USING(id_zona)
        WHERE id_miesta = p_miesto;
    
  return GET_PAYS_HOURS(p_date_from, p_date_to, h_platena_doba) * h_cena_hodina;
END;


--###################################################################################################################################
-- pomocna funkcia pre vypocet poctu hodin pri parkovani.. Vrati pocet dni medzi datumami

create or replace FUNCTION get_days_between
  (p_date_from IN DATE, p_date_to IN DATE)
RETURN integer
IS 
  h_date_from date;
  r_days integer;
BEGIN
  h_date_from := p_date_from;
  r_days := 0;
  IF (to_char(h_date_from, 'YYYYMMDD') = to_char(p_date_to, 'YYYYMMDD')) THEN
    return 0;
  END IF;
  
  WHILE to_char(h_date_from, 'YYYYMMDD') <> to_char(p_date_to, 'YYYYMMDD') LOOP
       IF (IS_WEEKEND(h_date_from) = 1) THEN
          h_date_from := h_date_from + interval '1' day;
          CONTINUE;
       END IF;
       r_days := r_days + 1;
       h_date_from := h_date_from + interval '1' day;
  END LOOP;
  
  return r_days;
END;

--###################################################################################################################################
-- Vrati id_preukazu na ktory je prihlasena spz

create or replace FUNCTION get_id_preukaz
	(p_spz IN VOZIDLO.SPZ%TYPE)
RETURN integer
IS 
r_id_preukaz integer;
BEGIN
  SELECT ID_PREUKAZ INTO r_id_preukaz FROM VOZIDLO
    WHERE p_spz = SPZ;
  
  RETURN r_id_preukaz;
END;


--###################################################################################################################################
-- Vrati pocet platenych hodin medzi datumamy

create or replace FUNCTION get_pays_hours
  (p_date_from IN DATE, p_date_to IN DATE, p_platena IN CHAR)
RETURN integer
IS 
h_platena char(8);
platena_od integer;
platena_do integer;
parkuje_od date;
parkuje_do date;
pocet_dni integer;
BEGIN
  pocet_dni  := GET_DAYS_BETWEEN(p_date_from, p_date_to);
  platena_od := to_number(substr(p_platena,1,2));
  platena_do := to_number(substr(p_platena,5,2));
  parkuje_od := SET_DATE_FROM(p_date_from, p_platena); 
  parkuje_do := SET_DATE_TO(p_date_to, p_platena);
  
  IF (pocet_dni = 0) THEN
    IF (IS_WEEKEND(p_date_from) = 1) THEN
      return 0;
    END IF;
    return trunc((p_date_to - parkuje_od) * 24) + 1;
  END IF;
  
  IF (pocet_dni > 0) THEN
    pocet_dni := pocet_dni - 1;
  END IF;
  
  return (platena_do - to_number(to_char(parkuje_od, 'HH24')))
          + ((platena_do - platena_od) * pocet_dni)
          + (to_number(to_char(parkuje_do, 'HH24')) - platena_od);
END;


--###################################################################################################################################
-- Vrati kuponovu zlavu, ak je parkovanie na rezervaciu. Ak sa kupon nepouziva, vrati 0

create or replace FUNCTION get_zlava_kupon
	( p_id_rezervacia_miesto IN NUMBER,
    p_zaciatok IN DATE)
RETURN INTEGER
IS 
r_percenta integer;
h_kupon integer;
BEGIN
  SELECT count(*) INTO h_kupon
      FROM rezervacia JOIN rezervacia_park_miesta
        USING(id_rezervacia) 
          WHERE id_rezervacia_park_miesto = p_id_rezervacia_miesto;

 IF (h_kupon = 0) THEN
    return 0;
  END IF;
  
  SELECT id_kupon INTO h_kupon
    FROM rezervacia JOIN rezervacia_park_miesta
      USING(id_rezervacia) 
        WHERE id_rezervacia_park_miesto = p_id_rezervacia_miesto;
        
  SELECT percenta INTO r_percenta
    FROM ZLAVA JOIN KUPON USING (id_zlava)
      WHERE id_kupon = h_kupon;
      
  return r_percenta;
END;


--###################################################################################################################################
-- vrti lavu na preukaz, ak nejaka je. Ak nie je vrati 0

create or replace FUNCTION get_zlava_na_preukaz
	(p_id_preukaz IN PREUKAZ.ID_PREUKAZ%TYPE,
    p_odkedy IN DATE,
    p_dokedy IN DATE)
RETURN integer
IS 
r_zlava_percent integer;
h_id_zlava integer;
h_pomocna integer;
BEGIN         
  SELECT count(*) into h_pomocna 
    FROM ZLAVA_NA_PREUKAZ
      WHERE id_preukaz = p_id_preukaz
        AND ZACIATOK_PLATNOSTI <= p_odkedy
      AND DOKEDY >= p_dokedy;
      
  IF (h_pomocna = 0) THEN
    return 0;
  END IF;
  
  SELECT id_zlava into h_id_zlava 
    FROM ZLAVA_NA_PREUKAZ
      WHERE p_id_preukaz = id_preukaz
        AND ZACIATOK_PLATNOSTI <= p_odkedy
      AND DOKEDY >= p_dokedy;
      
  SELECT percenta into r_zlava_percent 
    FROM ZLAVA
      WHERE id_zlava = h_id_zlava;
      
  RETURN nvl(r_zlava_percent,0);
END;


--###################################################################################################################################
-- funkcia zisti ci je dany datum vykend

create or replace function is_weekend
   (datum IN DATE)
return number
IS 
vys NUMBER(1);
begin
  select  decode(trim(to_char(datum,'Day','nls_date_language=American')), 
        'Monday'   , 1, 
        'Tuesday'  , 2, 
        'Wednesday', 3, 
        'Thursday' , 4, 
        'Friday'   , 5, 
        'Saturday' , 6,
        'Sunday'   , 7
        )  into vys from dual;
                    
   IF (vys = 6 OR vys = 7) THEN
      return 1;
   END IF;

   return 0;
end;


--###################################################################################################################################
-- Funkcia zisti ci je parkovanie z historie parkovania zaplatene 

create or replace FUNCTION je_zaplatena_platba
	(p_id_historia IN HISTORIA_PARKOVANIA.ID_HISTORIA%TYPE)
RETURN INTEGER
IS 
r_platena integer;
BEGIN
  SELECT count(*) INTO r_platena FROM PLATBA 
    WHERE ID_HISTORIA = p_id_historia;
  IF (r_platena > 0) THEN
    return 1;
  END IF;
  
  return 0;
END;


--###################################################################################################################################
-- funkcia nastavy datum zaciatku parkovania na zaciatok najblissej platenej doby. Pomocna funkcia pre zistenie poctu platenych hodin

create or replace FUNCTION set_date_from
  (p_date_from IN DATE, p_pay_time IN CHAR)
RETURN date
IS 
  h_pay_from integer;
  h_pay_to integer;
  r_date date;
  h_start integer;
BEGIN
  r_date       := p_date_from;
  h_pay_from   := to_number(substr(p_pay_time,1,2));
  h_pay_to     := to_number(substr(p_pay_time,5,2));
  h_start      := to_number(to_char(p_date_from, 'HH24'));
  
  IF (h_start < h_pay_from ) THEN
    r_date := to_date((to_char(p_date_from,'YYYY.MM.DD') || ' ' 
              || h_pay_from), 'YYYY.MM.DD HH24');
  END IF;
  IF (h_start + 1  > h_pay_to) THEN
    r_date := to_date((to_char(p_date_from,'YYYY.MM.DD') 
              || ' ' || h_pay_from), 'YYYY.MM.DD HH24')  
              + INTERVAL '1' DAY;
  END IF;
  
  return r_date;
END;


--###################################################################################################################################
-- funkcia nastavy datum koniec parkovania na koniec najblissej platenej doby. Pomocna funkcia pre zistenie poctu platenych hodin

create or replace FUNCTION set_date_to
  (p_date_to IN DATE, p_pay_time IN CHAR)
RETURN date
IS 
  h_pay_from integer;
  h_pay_to integer;
  r_date date;
  h_start integer;
BEGIN
  r_date       := p_date_to;
  h_pay_from   := to_number(substr(p_pay_time,1,2));
  h_pay_to     := to_number(substr(p_pay_time,5,2));
  h_start      := to_number(to_char(p_date_to, 'HH24'));
  
  IF (h_start + 1 > h_pay_to) THEN
    r_date := to_date((to_char(p_date_to,'YYYY.MM.DD') || ' ' 
              || h_pay_to), 'YYYY.MM.DD HH24');
  END IF;
  IF (h_start < h_pay_from) THEN
    r_date := to_date((to_char(p_date_to,'YYYY.MM.DD') || ' ' 
              || h_pay_to), 'YYYY.MM.DD HH24')  
              - INTERVAL '1' DAY;
  END IF;
  
  return r_date;
END;


--###################################################################################################################################
-- funkcia vrati typ zakaznika

create or replace FUNCTION typ_zakaznik
	(p_spz IN VOZIDLO.SPZ%TYPE)
RETURN CHAR
IS 
r_typ char;
BEGIN
  SELECT TYP INTO r_typ FROM ZAKAZNIK 
    JOIN PREUKAZ USING (ID_ZAKAZNIK)
    JOIN VOZIDLO USING (ID_PREUKAZ)
      WHERE p_spz = SPZ;
  
  RETURN r_typ;
END;


--###################################################################################################################################
--  Funkcia vrati zonu do ktorej patri parkovacie miesto 
create or replace FUNCTION typ_zona
  (p_miesto IN NUMBER)
  RETURN char
  IS
  r_typ_zona char(1);
  BEGIN
    SELECT TYP_ZONA INTO r_typ_zona FROM ZONA
      JOIN PARKOVACIE_MIESTO USING(ID_ZONA)
        WHERE ID_MIESTA = p_miesto;
    
    return r_typ_zona;
  END;


--###################################################################################################################################



