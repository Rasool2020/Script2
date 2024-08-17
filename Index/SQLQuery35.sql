Select OBJECT_SCHEMA_NAME(object_id) + '.' + OBJECT_NAME(object_id) , *
from sys.indexes
Where type_desc='HEAP'
Go
Select top 10 *
from flight.TbFlightSearchLogDW
Go


