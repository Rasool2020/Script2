--TSQL مدیریت کارهای پکیج با دستورات 
GO
--------------------------------------------------------------------
--TSQL کردن پکیج ها با دستورات Deploy بررسی نحوه 
USE SSISDB
GO
--SSISDB Catalog ایجاد یک فولدر در 
DECLARE @fid bigint
Exec SSISDB.Catalog.Create_folder 
	@folder_name=N'Avijeh_Deploy',
	@folder_id=@fid output

Declare @projectBinary varbinary (max)
Declare @operation_id int
--ispac خواندن محتوای فایل 
Set @projectBinary=
(
	SELECT * FROM OPENROWSET
	(
		--ispac مسیر فایل 
		Bulk 'C:\Dump\Session08.ispac', single_blob
	) as binary_data
)
Exec SSISDB.catalog.deploy_project
	@folder_name='Avijeh_Deploy',
	@project_name='Session08',
	@project_stream=@projectBinary,
	@operation_id=@operation_id out
--Environmentایجاد 
EXEC [SSISDB].[catalog].[create_environment]
	@environment_name=N'Enviroment_Deploy',
	@environment_description=N'',
	@folder_name=N'Avijeh_Deploy'
GO
--Environment Variablesایجاد 
DECLARE @var sql_variant = N'Hello Avijeh-Deploy'
EXEC [SSISDB].[catalog].[create_environment_variable] 
	@variable_name=N'V4P1',
	@sensitive=False, @description=N'',
	@environment_name=N'Enviroment_Deploy', 
	@folder_name=N'Avijeh_Deploy', 
	@value=@var, 
	@data_type=N'String'
GO
--Environment ایجاد ارتباط پروجکت با 
Declare @reference_id bigint
EXEC [SSISDB].[catalog].[create_environment_reference] 
	@environment_name=N'Enviroment_Deploy', 
	@reference_id=@reference_id OUTPUT, 
	@project_name=N'Session08', 
	@folder_name=N'Avijeh_Deploy', 
	@reference_type=R
Select @reference_id
GO
--Environment تخصیص مقدار پارامتر با استفاده از 
EXEC [SSISDB].[catalog].[set_object_parameter_value] 
	@object_type=30, @parameter_name=N'P1', 
	@object_name=N'Package.dtsx', 
	@folder_name=N'Avijeh_Deploy', 
	@project_name=N'Session08', 
	@value_type=R, @parameter_value=N'V4P1'
GO
--------------------------------------------------------------------
--Version مشاهده قسمت 
--شود Deploy پروژه مربوطه چند بار 
Declare @projectBinary varbinary (max)
Declare @operation_id int
--ispac خواندن محتوای فایل 
Set @projectBinary=
(
	Select * from openrowset
	(
		--ispac مسیر فایل 
		Bulk 'C:\Dump\Session08.ispac', single_blob
	) as binary_data
)
Exec SSISDB.catalog.deploy_project
	@folder_name='Avijeh_Deploy',
	@project_name='Session08',
	@project_stream=@projectBinary,
	@operation_id=@operation_id out
GO
--SSMS مشاهده نسخه ها در 
GO
--TSQL مشاهده نسخه ها با دستورات 
SELECT 
	folders.folder_id,
	folders.name AS FolderName,
	projects.project_id,
	projects.project_id,
	projects.name AS ProjectName,
	vers.object_version_lsn,
	vers.object_id AS ObjectId,
	vers.object_type AS ObjectType,
	vers.object_name AS ObjectName,
	vers.description AS Description,
	vers.created_by AS CreatedBy,
	CAST (vers.created_time AS datetime) AS created_time,
	CAST (vers.last_restored_time AS datetime) AS last_restored_time,
	vers.restored_by AS RestoredBy
FROM SSISDB.catalog.folders AS folders
	INNER JOIN SSISDB.catalog.projects AS projects ON 
		projects.folder_id=folders.folder_id
	INNER JOIN SSISDB.catalog.object_versions AS vers ON 
		vers.object_id=projects.project_id
WHERE 
	projects.name='Session08'
GO
--------------------------------------------------------------------
--TSQL اجرای پکیج با استفاده از دستورات 
GO
--اجرای پکیج با تخصیص مقدار دلخواه به عنوان پارامتر ورودی
Declare @execution_id bigint
EXEC [SSISDB].[catalog].[create_execution] 
	@package_name=N'Package.dtsx', 
	@execution_id=@execution_id OUTPUT, 
	@folder_name=N'Avijeh_Deploy',
	@project_name=N'Session08', 
	@use32bitruntime=False, 
	@reference_id=Null
Select @execution_id
DECLARE @var0 sql_variant = N'Hello Masoud Taheri'
EXEC [SSISDB].[catalog].[set_execution_parameter_value] 
	@execution_id,  
	@object_type=30, --30 is Package Parameters, you can also use 20 for Project parameters or 50 for Environment
	@parameter_name=N'P1', 
	@parameter_value=@var0
EXEC [SSISDB].[catalog].[start_execution] @execution_id
GO
--Environment اجرا به همراه تخصیص مقدار
Declare @execution_id bigint
EXEC [SSISDB].[catalog].[create_execution] 
	@package_name=N'Package.dtsx', 
	@execution_id=@execution_id OUTPUT, 
	@folder_name=N'Avijeh_Deploy', 
	@project_name=N'DeployWithTSQL',
	@use32bitruntime=False,
	@reference_id=null -- Environment
Select @execution_id
...
.
....
EXEC [SSISDB].[catalog].[start_execution] @execution_id
GO
--------------------------------------------------------------------
--DTExec اجرای پکیج با استفاده از  
GO
/*
C:\Program Files\Microsoft SQL Server\140\DTS\Binn

DTExec /ISServer "\SSISDB\Avijeh_Deploy\Session08\Package.dtsx"

DTExec /ISServer "\SSISDB\Avijeh_Deploy\DeployWithTSQL\Package.dtsx" /Par "P1(String)";"Hello Farid Taheri"

DTExec /ISSERVER "\SSISDB\Avijeh_Deploy\Session08\Package.dtsx" /SERVER ".\sqlserver2017" /Par "P1(String)";"Hello Farid Taheri"

DTExec /ISSERVER "\SSISDB\Avijeh_Deploy\Session08\Package.dtsx" /SERVER ".\sqlserver2017" /Envreference 2 /Par "$Project::ProjectParameter(Int32)";1 /Par "Parameter(Int32)";21 /Par "CM.sqlcldb2.SSIS_repro.InitialCatalog";ssisdb /Par "$ServerOption::SYNCHRONIZED(Boolean)";True  
*/
--------------------------------------------------------------------
--اجرای پکیج و مشاهده لاگ اجرا
Declare @execution_id bigint
EXEC [SSISDB].[catalog].[create_execution] 
	@package_name=N'Package.dtsx', 
	@execution_id=@execution_id OUTPUT, 
	@folder_name=N'Avijeh_Deploy',
	@project_name=N'Session08', 
	@use32bitruntime=False, 
	@reference_id=Null
Select @execution_id
DECLARE @var0 sql_variant = N'Hello Masoud Taheri'
EXEC [SSISDB].[catalog].[set_execution_parameter_value] 
	@execution_id,  
	@object_type=30, --30 is Package Parameters, you can also use 20 for Project parameters or 50 for Environment
	@parameter_name=N'P1', 
	@parameter_value=@var0
EXEC [SSISDB].[catalog].[start_execution] @execution_id

SELECT @execution_id AS execution_id

WAITFOR DELAY '00:00:10'

--مشاهده لاگ اجرا
SELECT 
	e.execution_id
	,e.folder_name
	,e.environment_name
	,e.project_name
	,e.package_name
	,exc.executable_name
	,exs.execution_duration
	,exs.start_time
	,exs.end_time
	,CASE exs.execution_result 
		WHEN 0 THEN 'success'
		WHEN 1 THEN 'failure'
		WHEN 2 THEN 'completion'
		WHEN 3 THEN 'cancelled'
		ELSE 'unknown' 
	END AS execution_result
FROM ssisdb.internal.executions e
INNER JOIN ssisdb.internal.executable_statistics exs
	ON e.execution_id = exs.execution_id
INNER JOIN ssisdb.internal.executables exc
	ON exs.executable_id = exc.executable_id
WHERE 
	e.execution_id = @execution_id
ORDER BY 
	exs.start_time
GO
--------------------------------------------------------------------
--Project Deployment
--کرده ایم و می خواهیم سورس آن را مشاهده کنیم Deploy یک پکیج 
--کنیم Deploy کرده ایم و می خواهیم آن را در ماشینی دیگر  Deploy یک پکیج 
GO
--------------------------------------------------------------------
--حذف فولدر ** ترتیب حذف آبجکت های موجود در فولدر مهم است
--environment پاک کردن 
EXEC [SSISDB].[catalog].[delete_environment] 
	@environment_name=N'Enviroment_Deploy', 
	@folder_name=N'Avijeh_Deploy'
GO
--پاک کردن پکیج
EXEC [SSISDB].[catalog].[delete_project] 
	@project_name=N'Session08', 
	@folder_name=N'Avijeh_Deploy'
GO
--پاک کردن فولدر
EXEC [SSISDB].[catalog].[delete_folder] 
	@folder_name=N'Avijeh_Deploy'
GO
--------------------------------------------------------------------
