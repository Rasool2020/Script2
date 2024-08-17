select o.name,c.* 
from syscolumns c
Join sysobjects o on o.id=c.id
where c.xtype=231 and not o.name like 'sys%' and o.xtype='U' and not o.name like 'temp%' 
Order by o.name