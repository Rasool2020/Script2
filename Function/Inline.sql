Select OBJECT_NAME(object_id), is_inlineable
from sys.all_sql_modules
Where 1=1
	--And object_id=OBJECT_ID('dbo.FlightBuyPrice')
	And is_inlineable=1