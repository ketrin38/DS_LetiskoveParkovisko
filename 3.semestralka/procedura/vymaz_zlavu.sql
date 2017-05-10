    create or replace procedure vymaz_zlavu(p_nazov in zlava.nazov%type)
        as
         pocet number;
            begin
            select count(*) into pocet from zlava where nazov=p_nazov;
            if pocet!=0 then
                update rezervacia r
                    set id_kupon=null
                         where
                    exists(
                    select 'x' from kupon k
                        join zlava z using(id_zlava) 
                        where z.nazov=p_nazov
                            and k.id_kupon=r.id_kupon);
                     
                     delete from  kupon k where 
                     exists(select 'x' from zlava z
                        where z.nazov=p_nazov
                        and z.id_zlava=k.id_zlava) ;
                      delete from zlava_na_preukaz   znp
                       where 
                     exists(select 'x' from zlava z
                        where z.nazov=p_nazov
                        and z.id_zlava=znp.id_zlava) ;
                        delete from zlava where nazov=p_nazov;
                      dbms_output.put_line('Z¾ava vymazaná! ');
                else
                  dbms_output.put_line('Takáta z¾ava neexistuje !');
                  end if;
                        
            
end;
/
select * from zlava;
execute VYMAZ_ZLAVU('Zfdlava5');
rollback;
    SET SERVEROUTPUT ON;