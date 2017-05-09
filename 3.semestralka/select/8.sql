select ID_REZERVACIA from rezervacia rz
join rezervacia_park_miesta rp using(id_rezervacia)
where stav='SCH' or stav='NES'
and exists
(
select 'x' from historia_parkovania hp
    where hp.id_miesta=rp.id_miesta
    and rp.ID_REZERVACIA_PARK_MIESTO=hp.ID_REZERVACIA_PARK_MIESTO
    and(hp.odkedy>=rz.ZACIATOK and hp.odkedy<=rz.zaciatok+(dlzka/2))
    and hp.ID_REZERVACIA_PARK_MIESTO is null
   
);