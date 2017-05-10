create or replace procedure uprav_spz(p_old_spz IN vozidlo.spz%type, p_new_spz IN vozidlo.spz%type)
    as
    pocet number;
    begin
    
    select count(*) into pocet from vozidlo where spz=p_old_spz;
        if pocet>0 then
                select count(*) into pocet from vozidlo where spz=p_new_spz;
                if pocet=0 then
                        insert into vozidlo 
                            select p_new_spz,id_preukaz,typ_vozidla from vozidlo where spz=p_old_spz;
                        update historia_parkovania set spz=p_new_spz
                              where spz=p_old_spz;
                        delete from vozidlo where spz=p_old_spz;
                             dbms_output.put_line('SPZ bola upravená');
                 elsif pocet>0 then
                        dbms_output.put_line('Takéto vozidlo už existuje !');
               end if;
        else 
            dbms_output.put_line('Takéto vozidlo neexistuje !');
            
            
        end if;
    end;
    /
    select * from vozidlo;
    show errors;
    execute UPRAV_SPZ('BA540ME','BA540ME');
    SET SERVEROUTPUT ON;

    