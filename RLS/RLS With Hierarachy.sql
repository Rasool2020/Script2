CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Position NVARCHAR(100),
    OrgNode HierarchyID,
    OrgLevel AS OrgNode.GetLevel()
);
Go
INSERT INTO Employees(EmployeeID, Name, Position, OrgNode)
VALUES 
(1, 'CEO', 'CEO', HierarchyID::GetRoot()),
(2, 'CTO', 'CTO', HierarchyID::GetRoot().GetDescendant(NULL, NULL)),
(3, 'CFO', 'CFO', HierarchyID::GetRoot().GetDescendant(NULL, NULL)),
(4, 'Dev Manager', 'Manager', HierarchyID::GetRoot().GetDescendant('/1/', NULL)),
(5, 'Finance Manager', 'Manager', HierarchyID::GetRoot().GetDescendant('/2/', NULL)),
(6, 'Developer', 'Developer', HierarchyID::GetRoot().GetDescendant('/1/1/', NULL)),
(7, 'Accountant', 'Accountant', HierarchyID::GetRoot().GetDescendant('/2/1/', NULL));
Go
CREATE FUNCTION dbo.fn_securitypredicate(@OrgNode HierarchyID)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN SELECT 1 AS fn_securitypredicate_result
Where @OrgNode.IsDescendantOf(USER_NAME()) = 1;
Go
