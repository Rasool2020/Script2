alter table document disable trigger all
Update document Set exchangerateversa02=0,exchangerateversa03=0,exchangerateversa04=0,exchangerateversa05=0,exchangerateversa06=0,exchangerateversa07=0 
where code=89
alter table document enable trigger all