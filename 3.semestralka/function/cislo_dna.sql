/**Vracia cislo dna podla zadaneho datumu*/

create or replace function cislo_dna(datum IN DATE)
    return number
        IS vys NUMBER(1);
begin
  select  decode(trim(to_char(datum,'Day','nls_date_language=American')), 
        'Monday', 1, 
        'Tuesday', 2, 
        'Wednesday', 3, 
        'Thursday', 4, 
        'Friday', 5, 
        'Saturday', 6,
        'Sunday', 7)  into vys
                    from dual;
   return vys;
   
end;
/
/**testttt*/
SELECT cislo_dna(to_date('2017.05.07','YYYY.MM.DD')) FROM DUAL; 
