Select OBJECT_SCHEMA_NAME(object_id) + '.' + OBJECT_NAME(object_id) , *
from sys.indexes
Where type_desc='HEAP'
Go
sp_spaceused 'basic.TbCountry_Test'
Go
DBCC IND('IPA_booking_ir', 'basic.TbCountry_Test', -1) WITH NO_INFOMSGS;

Select * From basic.TbCountry_Test