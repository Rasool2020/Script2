USE [BPMS]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ViolationStudent]    Script Date: 8/17/2024 4:04:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER FUNCTION [dbo].[fn_ViolationStudent](@username AS varchar(50))
    RETURNS TABLE
WITH SCHEMABINDING
AS
    RETURN SELECT 1 AS fn_ViolationStudent_Result
    -- Logic for filter predicate
    WHERE CAST(SESSION_CONTEXT(N'isAdmin') AS bit) = 1
    OR (
		@username = SESSION_CONTEXT(N'username')
		--AND @tenant IN (SELECT value FROM STRING_SPLIT(CAST(SESSION_CONTEXT(N'userTenants') AS nvarchar(max)), ','))
	);

