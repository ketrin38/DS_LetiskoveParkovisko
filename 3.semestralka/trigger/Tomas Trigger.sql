

--###################################################################################################################################

create or replace TRIGGER trig_his_parkovania
BEFORE INSERT OR UPDATE ON HISTORIA_PARKOVANIA
FOR EACH ROW
BEGIN
  IF (:NEW.dokedy IS NOT NULL) THEN
    KONTROLA_DATUMU(:NEW.odkedy ,:NEW.dokedy);
  END IF;
END;

--###################################################################################################################################

create or replace TRIGGER trig_platnost_preukaz
BEFORE INSERT OR UPDATE ON PREUKAZ
FOR EACH ROW
BEGIN
  KONTROLA_DATUMU(:NEW.zaciatok_platnosti ,:NEW.koniec_platnosti);
END;

--###################################################################################################################################

create or replace TRIGGER trig_platnost_tarifa
BEFORE INSERT OR UPDATE ON TARIFA
FOR EACH ROW
BEGIN
  KONTROLA_DATUMU(:NEW.platnost_od ,:NEW.platnost_do);
END;

--###################################################################################################################################

create or replace TRIGGER trig_platnost_zlava
BEFORE INSERT OR UPDATE ON ZLAVA
FOR EACH ROW
BEGIN
  KONTROLA_DATUMU(:NEW.odkedy ,:NEW.dokedy);
END;

--###################################################################################################################################

create or replace TRIGGER trig_platnost_zlava_preukaz
BEFORE INSERT OR UPDATE ON zlava_na_preukaz
FOR EACH ROW
BEGIN
  KONTROLA_DATUMU(:NEW.zaciatok_platnosti ,:NEW.dokedy);
END;

--###################################################################################################################################

