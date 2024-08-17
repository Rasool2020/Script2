Select db.name, db.user_access_desc, db.state_desc, Sum(mf.size) size, left(mf.physical_name, 2) Partition
FROM 
     sys.master_files AS mf
     JOIN sys.databases AS db ON
            db.database_id = mf.database_id
--Where db.name='IPA_booking_ir'
Group by db.name, db.user_access_desc, db.state_desc, left(mf.physical_name, 2)
Order by Sum(mf.size) desc
Go
Select db.name, db.user_access_desc, db.state_desc, mf.size, mf.physical_name
FROM 
     sys.master_files AS mf
     JOIN sys.databases AS db ON
            db.database_id = mf.database_id
--Where db.name='IPA_booking_ir'
Order by db.name, mf.physical_name
Go
Select d.name, database_id, d.*
From sys.databases d
Join sys.database_files f
	ON d.database_id = 1
Go
