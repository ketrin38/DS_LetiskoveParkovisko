/* V�pis sumy platieb be�n�ch z�kazn�kov za dne�n� de�*/
select sum(cena) from platba 
    join historia_parkovania hp using(id_historia)
        where exists
            (select 'x' from vozidlo vo
                where
                 vo.spz=hp.spz
                 and vo.id_preukaz is null)
                 and platba.datum=sysdate
                ;
                
   
   