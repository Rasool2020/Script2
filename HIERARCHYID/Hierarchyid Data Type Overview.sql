/* 

	SQL Server HIERARCHYID Data Type Overview and Examples
	https://www.mssqltips.com/sqlservertip/6048/sql-server-HIERARCHYID-data-type-overview-and-examples/

*/

DROP TABLE if Exists SIMPLEDEMO

-- create a table with HIERARCHYID data type column
-- and two other columns
Create Table SimpleDemo  
(Node HIERARCHYID not null,  
[Geographical Name] NVARCHAR(30) not null,  
[Geographical Type] NVARCHAR(9) NULL);
 
insert SimpleDemo  
values
-- second level data 
 ('/1/1/','China','Country')
,('/1/2/','Japan','Country')
,('/1/3/','South Korea','Country')
,('/2/1/','South Africa','Country')
,('/2/2/','Egypt','Country')
,('/3/1/','Australia','Country')
 
-- first level data
,('/1/','Asia','Continent')
,('/2/','Africa','Continent')
,('/3/','Oceania','Continent')
 
-- third level data
,('/1/1/1/','Beijing','City')
,('/1/2/1/','Tokyo','City')
,('/1/3/1/','Seoul','City')
,('/2/1/1/','Pretoria','City')
,('/2/2/1/','Cairo','City')
,('/3/1/1/','Canberra','City')
-- root level data
,('/', 'Earth', 'Planet')  
 
 
-- display without sort order returns 
-- rows in input order
Select 
 Node
,Node.ToString() AS [Node Text]
,Node.GetLevel() [Node Level]
,[Geographical Name]
,[Geographical Type]   
From SimpleDemo	
Order By Node

-- sort by Node Text or Node to get depth-first order of nodes
Select 
 Node
,Node.ToString() AS [Node Text]
,Node.GetLevel() [Node Level]
,[Geographical Name]
,[Geographical Type]   
From SimpleDemo
Order By [Node Text]  -- Order By Node Text or Node to get depth-first list	


-- hex_to_int conversion of Node values
-- for Order By Node
Select 
 Node
, Convert(INT, convert(varbinary, Node, 1)) hex_to_int
,Node.ToString() AS [Node Text]
,Node.GetLevel() [Node Level]
,[Geographical Name]
,[Geographical Type]  
From SimpleDemo
Order By [Node]

--	=======================================================================


Drop Table IF Exists SimpleDemo
  
-- Create a Table With Node HIERARCHYID Data type column
-- (primary key)l also add a Node Level column
Create Table SimpleDemo  
(Node HIERARCHYID primary key clustered not null,
[Node Level] As Node.GetLevel() Persisted,
[Geographical Name] NVARCHAR(30) not null,  
[Geographical Type] NVARCHAR(9) null);
 
-- insert data out of Order By Node Level, but in 
-- Order By Node
Insert SimpleDemo(Node, [Geographical Name], [Geographical Type])
Values
-- Second Level Data 
 ('/1/1/','China','Country')
,('/1/2/','Japan','Country')
,('/1/3/','South Korea','Country')
,('/2/1/','South Africa','Country')
,('/2/2/','Egypt','Country')
,('/3/1/','Australia','Country')
 -- First Level Data
,('/1/', 'Asia','Continent')
,('/2/', 'Africa','Continent')
,('/3/', 'Oceania','Continent')
 
-- Third Level Data
,('/1/1/1/', 'Beijing','City')
,('/1/2/1/', 'Tokyo','City')
,('/1/3/1/', 'Seoul','City')
,('/2/1/1/', 'Pretoria','City')
,('/2/2/1/', 'Cairo','City')
,('/3/1/1/', 'Canberra','City')
 
-- Root Level Data
,('/', 'Earth', 'Planet') 
Go
Select *
From SimpleDemo
Go
-- add new continent (Europe) row after root level
Declare @planet HIERARCHYID = HIERARCHYID::GetRoot()

 = (Select Max(Node) From SimpleDemo Where [Geographical Type] = 'Continent')
INSERT SimpleDemo (Node, [Geographical Name], [Geographical Type]) 
Values(@planet.GetDescendant(@last_continent,null), 'Europe','Continent')

Declare @last_continent HIERARCHYID 
-- add first new country (Germany) row belonging to the new continent
Select @last_continent=Node From SimpleDemo Where [Geographical Type] = 'Continent' And [Geographical Name]='Europe'
Select @last_continent.GetDescendant(null,null)
Insert SimpleDemo (Node, [Geographical Name], [Geographical Type]) 
Values (@last_continent.GetDescendant(null,null), 'Germany','Country')
 
-- add second new country (France) row belonging to the new continent
Declare @last_country HIERARCHYID 
= (Select Max(Node) From SimpleDemo Where [Geographical Type] = 'Country' And [Geographical Name]='Germany')
Insert SimpleDemo (Node, [Geographical Name], [Geographical Type]) 
Values (@last_continent.GetDescendant(@last_country,null), 'France','Country')
 
-- add third new country (United Kingdom) row belonging to the new continent
Set @last_country = (Select Max(Node) From SimpleDemo Where [Geographical Type] = 'Country')
Insert SimpleDemo (Node, [Geographical Name], [Geographical Type]) 
Values(@last_continent.GetDescendant(@last_country,null), 'United Kingdom','Country')
 
Select *,Node.ToString() From SimpleDemo Order By [Node Level], Node	

-- add new city (Berlin) to country of Germany
Declare @country HIERARCHYID = (Select node From SimpleDemo Where [Geographical Name] = 'Germany')
Insert SimpleDemo (Node, [Geographical Name], [Geographical Type]) 
Values(@country.GetDescendant(null,null), 'Berlin', 'City')
 
-- add new city (Paris) to country of France
Set @country = (Select node From SimpleDemo Where [Geographical Name] = 'France')
Insert SimpleDemo (Node, [Geographical Name], [Geographical Type]) 
Values(@country.GetDescendant(null,null), 'Paris', 'City')
 
 
-- add new city (London) to country of United Kingdom
Set @country = (Select node From SimpleDemo Where [Geographical Name] = 'United Kingdom')
Select @country.GetDescendant(null,null)
Insert SimpleDemo (Node, [Geographical Name], [Geographical Type]) 
Values(@country.GetDescendant(null,null), 'London', 'City')
 
Select *,Node.ToString() From SimpleDemo Order By [Node Level], Node	

Select *,Node.ToString() 
From SimpleDemo 
WHERE Node.IsDescendantOf('/4/') = 1;