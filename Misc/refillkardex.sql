alter table kardex disable trigger all
delete from kardex	
		
    INSERT INTO kardex(kala_code, dateks, customer_code, ss, r, mr, f, mf, rem, des, type, page_time, st_code, rem_kol, tr, tf,rem1,rem1_kol )
    Select detailexport.kala_code,export.export_date_shamsi AS dateks,
     export.customer_code,detailexport.serial_code AS ss, 0 AS r, 0 AS mr, 
     detailexport.export_tedad AS f, 0 AS mf, detailexport.fee AS rem, STR(export.code) + ' ÕÊ«·Â ' + export_type.name AS des,
     1 AS type, export.export_time AS page_time, detailexport.st_code, 0 AS rem_kol,
     0 AS tr, detailexport.radif_no AS tf,detailexport.fee_kol+detailexport.cost_kol as rem1,0 as rem1_kol From export RIGHT OUTER JOIN detailexport ON export.serial_code = detailexport.serial_code  left outer join export_type on export.type_page=export_type.code 

    INSERT INTO kardex(kala_code, dateks, customer_code, ss, r, mr, f, mf, rem, des, type, page_time, st_code, rem_kol, tr, tf,rem1,rem1_kol )
    Select detailimport.kala_code,import.import_date_shamsi AS dateks,
     import.customer_code,detailimport.serial_code AS ss, detailimport.import_tedad  AS r, 0 AS mr, 
     0 as f, 0 AS mf, 0 AS rem, STR(import.code)+ ' —”Ìœ ' + import_type.name AS des,
     3 AS type, import.import_time AS page_time, detailimport.st_code, detailimport.fee AS rem_kol,
     0 AS tr, detailimport.radif_no AS tf,0 as rem1,detailimport.fee_kol+detailimport.cost_kol as rem1_kol  From import RIGHT OUTER JOIN detailimport ON import.serial_code = detailimport.serial_code left outer join import_type on import.type_page=import_type.code
alter table kardex enable trigger all

alter table kala_st disable trigger all
update kala_st set tedad = isnull(v.tedad ,0)
from kala_st left join (
select sum(r-f) as tedad,st_code,kala_code from kardex group by st_code,kala_code 
) v
on kala_st.st_code = v.st_code and kala_st.kala_code = v.kala_code
update kala set tedad = isnull(v.tedad ,0)
from kala left join (
select sum(tedad) as tedad,kala_code from kala_st group by kala_code 
) v
on kala.kala_code = v.kala_code
alter table kala_st enable trigger all

-- select kala_st.kala_code from kala_st inner join
-- (select sum(r-f) tedad,kala_code,st_code  from  kardex
-- group by kala_code,st_code) v
-- on v.kala_code = kala_st.kala_code and v.st_code = kala_st.st_code
-- where kala_st.tedad <> v.tedad

alter table kala disable trigger all
update kala set tedad = v.tedad from kala join 
(select sum(tedad) tedad,kala_code from kala_st group by kala_code) v
on kala.kala_code = v.kala_code
alter table kala enable trigger all
