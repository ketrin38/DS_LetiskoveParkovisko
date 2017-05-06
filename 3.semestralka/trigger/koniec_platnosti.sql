/** nastavenie konca platnosti  preukazu/*/

create or replace trigger koniec_platnosti
before  insert on preukaz
for each row
begin
if :new.koniec_platnosti is null then
     :new.koniec_platnosti:=add_months(sysdate,12);
end if;
end;
/


/**testovanie*/
insert into preukaz values(8000,2,sysdate,null);
select * from preukaz where id_preukaz=8000;
delete from preukaz where id_preukaz=8000;
commit;

