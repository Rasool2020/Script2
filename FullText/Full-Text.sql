SELECT 
	CASE FULLTEXTSERVICEPROPERTY('IsFullTextInstalled')
		WHEN 1 THEN 'Full-Text installed.' 
		ELSE 'Full-Text is NOT installed.' 
	END
Go
-- Enable Full Text Search For Database
Exec sp_fulltext_database 'enable';
Go
SELECT 
	name,is_fulltext_enabled
FROM sys.databases
WHERE 
	database_id = DB_ID('SAloKetab')
Go
SELECT * FROM sys.fulltext_languages WHERE name='Neutral'
Go
--	List of Stop Words
SELECT * FROM sys.fulltext_system_stopwords WHERE language_id=0
Go
--Stop List
CREATE FULLTEXT STOPLIST PersianStoplist AUTHORIZATION [dbo];
GO
--Copying a full-text stoplist from the system full-text stoplist
--CREATE FULLTEXT STOPLIST StopList02 FROM SYSTEM STOPLIST;
Go
--DROP FULLTEXT STOPLIST PersianStoplist;
Go
ALTER FULLTEXT STOPLIST PersianStoplist ADD 'و' LANGUAGE 'Neutral';
ALTER FULLTEXT STOPLIST PersianStoplist ADD 'یا' LANGUAGE 'Neutral';
ALTER FULLTEXT STOPLIST PersianStoplist ADD 'از' LANGUAGE 'Neutral';
ALTER FULLTEXT STOPLIST PersianStoplist ADD 'شد' LANGUAGE 'Neutral';
ALTER FULLTEXT STOPLIST PersianStoplist ADD 'است' LANGUAGE 'Neutral';
ALTER FULLTEXT STOPLIST PersianStoplist ADD 'خ' LANGUAGE 'Neutral';
ALTER FULLTEXT STOPLIST PersianStoplist ADD N'تست' LANGUAGE 'Neutral';
ALTER FULLTEXT STOPLIST PersianStoplist ADD N'چند' LANGUAGE 'Neutral';
ALTER FULLTEXT STOPLIST PersianStoplist ADD 'hi' LANGUAGE 'Neutral';
Go
SELECT * FROM sys.fulltext_stoplists 
Go
SELECT * FROM sys.fulltext_stopwords 
Go
ALTER FULLTEXT STOPLIST PersianStoplist DROP 'hi' LANGUAGE 'Neutral'; 
SELECT * FROM sys.fulltext_stopwords 
Go
--ALTER FULLTEXT STOPLIST PersianStoplist DROP ALL;
Go
ALTER DATABASE [SAloKetab] ADD FILEGROUP [StorageFullText]
GO
ALTER DATABASE [SAloKetab] ADD FILE ( NAME = N'sPorAzKala3_FullTextA', FILENAME = N'K:\Site2017\SAloKetab\sPorAzKala3_FullTextA.ndf' , SIZE = 262144KB , FILEGROWTH = 262144KB ) TO FILEGROUP [StorageFullText]
GO
ALTER DATABASE [SAloKetab] ADD FILE ( NAME = N'sPorAzKala3_FullTextB', FILENAME = N'K:\Site2017\SAloKetab\sPorAzKala3_FullTextB.ndf' , SIZE = 262144KB , FILEGROWTH = 262144KB ) TO FILEGROUP [StorageFullText]
GO
sp_helpfile
Go
SELECT * FROM sys.filegroups
Go
CREATE FULLTEXT CATALOG PersianCatalog
ON FILEGROUP [StorageFullText] --File Group Name
	WITH ACCENT_SENSITIVITY = OFF
		AS DEFAULT
			AUTHORIZATION dbo
Go
sp_helpindex t00Product
Go
CREATE FULLTEXT INDEX
	ON t00Product ([baseName] LANGUAGE 'Neutral')
		KEY INDEX PK_t00Product 
			ON PersianCatalog 
				WITH CHANGE_TRACKING = AUTO,
					STOPLIST = PersianStoplist
Go
Select top 100 *
from t00Product
Go
--استخراج مقادیر موجود در ایندكس
SELECT * 
FROM sys.dm_fts_index_keywords(db_id('SAloKetab'), object_id('t00Product'))
Go
SET STATISTICS IO ON 
Go
Select top 100 * 
FROM t00Product 
Where baseName like '%حساب%'
Go
Select top 100 * 
FROM t00Product 
Where CONTAINS(*,N'حساب')
Go
SELECT baseName FROM t00Product WHERE CONTAINS(*,'حسین')
SELECT baseName FROM t00Product WHERE FREETEXT(*,'%حسین%')
SELECT baseName FROM t00Product WHERE baseName LIKE '%حسین%'
Go
--private void button1_Click(object sender, EventArgs e)
--{
--	listBox1.Items.Clear();
--	var source = textBox1.Text.Trim();

--	var strArray = source.Split(' ');
--	foreach (var str in strArray)
--	{
--		var items = Enumerable
--			.Range(0, str.Length)
--			.SelectMany(i => Enumerable.Range(2, str.Length - i - 1).Select(j => str.Substring(i, j)))
--			.Distinct()
--			.OrderBy(s => s.Length);
--		foreach (var item in items)
--		{
--			listBox1.Items.Add(item);
--		}
--	}
--}

