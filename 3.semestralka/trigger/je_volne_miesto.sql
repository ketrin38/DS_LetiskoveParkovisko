create or replace trigger je_volne_miesto
    before insert  on historia_parkovania
     for each row
      declare pocet integer;
        begin
    
            select count(*) into pocet from historia_parkovania 
                where id_miesta=:new.id_miesta
                and (   
                                odkedy>=:new.odkedy and odkedy<:new.dokedy
                            or 
                                 nvl(dokedy,sysdate)<=nvl(:new.dokedy,sysdate)  and nvl(dokedy,sysdate) >:new.odkedy 
                            or
                              odkedy<=:new.odkedy and  nvl(dokedy,sysdate) >= nvl(:new.dokedy,sysdate)
                             );
                
                    if pocet!=0 then
                        RAISE_APPLICATION_ERROR(-20001, 'Prepáète, ale toto miesto je obsadené');               
            
                    end if;
                    
      
    end;
/
select * from historia_parkovania where spz='BA292UH';
rollback;
insert into HISTORIA_PARKOVANIA values(5000,629,'BA292UH',null,to_date('11.12.2016','DD.MM.YYYY'),null);