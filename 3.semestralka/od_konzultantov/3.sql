select zak.meno,zak.priezvisko
   from (
   select meno,priezvisko,count(*) 
   from zakaznik
  
    join preukaz using(id_zakaznik)
        join vozidlo using(id_preukaz)
         join historia_parkovania using(spz)
          where 
           to_char(odkedy,'YYYY')=to_char(sysdate,'YYYY')
          or  to_char(nvl(dokedy,sysdate),'YYYY')=to_char(sysdate,'YYYY')
         group by meno,priezvisko,id_zakaznik
        
         order by count(*) desc
         )  zak where rownum<=5
         
         ;