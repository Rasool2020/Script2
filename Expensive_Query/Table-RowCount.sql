CREATE TABLE #TableSpaceUsed(
[name] [nvarchar](120) NULL,
[rows] [nvarchar](120) NULL,
[reserved] [nvarchar](120) NULL,
[data] [nvarchar](120) NULL,
[index_size] [nvarchar](120) NULL,
[unused] [nvarchar](120) NULL
) ON [PRIMARY]

Insert Into #TableSpaceUsed
EXEC sys.sp_MSforeachtable 'sp_spaceused ''?''';

Select left(data,len(data)-3),* from #TableSpaceUsed
--Order by CAST([rows] as int) desc
Order by CAST(left(data,len(data)-3) as int) desc



Drop table #TableSpaceUsed