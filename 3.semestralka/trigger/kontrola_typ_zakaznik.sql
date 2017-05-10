create or replace trigger tr_kontrola_typ
    before insert on historia_parkovania
        for each row
        declare 
           preukaz number;
           typ_zakaznik number;
            typ_zona zona.typ_zona%TYPE;
          begin
                select id_preukaz,typ into preukaz,typ_zakaznik  from zakaznik 
        join preukaz using(id_zakaznik) 
            right join vozidlo using(id_preukaz)
            where spz=:new.spz;
                 
                  select typ_zona into typ_zona from zona 
                join parkovacie_miesto using(id_zona)
                    where id_miesta=:new.id_miesta;
                    if  typ_zakaznik is not null then
                     if typ_zona='Z' and typ_zakaznik!='Z'  then
       RAISE_APPLICATION_ERROR(-20001, 'Toto miesto nie je urèené pre vás !'); 
       end if;
     elsif typ_zona='Z' then
            RAISE_APPLICATION_ERROR(-20001, 'Toto miesto nie je urèené pre vás !'); 
     end if;
      end;  
      /
       insert into historia_parkovania values(50000,11,'BL323BA',null,sysdate,null);
 rollback;