CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Position NVARCHAR(100),
    OrgNode HIERARCHYID,
    OrgLevel AS OrgNode.GetLevel()
);
Go
INSERT INTO Employees (EmployeeID, Name, Position, OrgNode)
VALUES (1, 'CEO', 'CEO', hierarchyid::GetRoot())
Go
INSERT INTO Employees (EmployeeID, Name, Position, OrgNode)
VALUES (2, 'CTO', 'CTO', hierarchyid::GetRoot().GetDescendant(NULL, NULL))
Go
INSERT INTO Employees (EmployeeID, Name, Position, OrgNode)
VALUES (3, 'CFO', 'CFO', hierarchyid::GetRoot().GetDescendant(NULL, NULL))
Go
INSERT INTO Employees (EmployeeID, Name, Position, OrgNode)
VALUES (4, 'Dev Manager', 'Manager', hierarchyid::GetRoot().GetDescendant('/1/', NULL))
Go
INSERT INTO Employees (EmployeeID, Name, Position, OrgNode)
VALUES (5, 'Finance Manager', 'Manager', hierarchyid::GetRoot().GetDescendant('/2/', NULL))
Go
INSERT INTO Employees (EmployeeID, Name, Position, OrgNode)
VALUES (6, 'Developer', 'Developer', hierarchyid::GetRoot().GetDescendant('/1/1/', NULL))
Go
INSERT INTO Employees (EmployeeID, Name, Position, OrgNode)
VALUES (7, 'Accountant', 'Accountant', hierarchyid::GetRoot().GetDescendant('/2/1/', NULL))
Go
Select *, Cast(OrgNode as NVARCHAR(MAX))--, hierarchyid::GetRoot().GetDescendant(Cast(OrgNode as VARCHAR(MAX)), Null) 
FRom Employees
Go
-- Get all employees under the CTO
SELECT *, Cast(OrgNode as NVARCHAR(MAX)), OrgNode.ToString()
FROM Employees
WHERE OrgNode.IsDescendantOf(hierarchyid::Parse('/1/')) = 1;
Go
SELECT *, Cast(OrgNode as NVARCHAR(MAX)) 
FROM Employees
WHERE OrgNode.IsDescendantOf(hierarchyid::GetRoot()) = 1;
Go
Select hierarchyid::GetRoot().GetDescendant('/1/', NULL).ToString()