Select 1;
While(@@ROWCOUNT>0)
Begin
	Delete top(1000)
	From Dimension.CityTemp2
		OUTPUT 
			   Deleted.[City Key]
			  ,Deleted.[WWI City ID]
			  ,Deleted.[City]
			  ,Deleted.[State Province]
			  ,Deleted.[Country]
			  ,Deleted.[Continent]
			  ,Deleted.[Sales Territory]
			  ,Deleted.[Region]
			  ,Deleted.[Subregion]
			  ,Deleted.[Location]
			  ,Deleted.[Latest Recorded Population]
			  ,Deleted.[Valid From]
			  ,Deleted.[Valid To]
			  ,Deleted.[Lineage Key]
		INTO Dimension.CityTemp1([City Key]
           ,[WWI City ID]
           ,[City]
           ,[State Province]
           ,[Country]
           ,[Continent]
           ,[Sales Territory]
           ,[Region]
           ,[Subregion]
           ,[Location]
           ,[Latest Recorded Population]
           ,[Valid From]
           ,[Valid To]
           ,[Lineage Key])
End
Go
