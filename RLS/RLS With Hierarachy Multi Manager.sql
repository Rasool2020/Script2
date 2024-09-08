CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Position NVARCHAR(100),
    OrgNode HierarchyID,
    OrgLevel AS OrgNode.GetLevel()
);

CREATE TABLE EmployeeAdditionalManagers (
    EmployeeID INT,
    ManagerID INT,
    PRIMARY KEY (EmployeeID, ManagerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);
Go
INSERT INTO Employees (EmployeeID, Name, Position, OrgNode)
VALUES 
(1, 'CEO', 'CEO', HierarchyID::GetRoot()),
(2, 'CTO', 'CTO', HierarchyID::GetRoot().GetDescendant(NULL, NULL)),
(3, 'CFO', 'CFO', HierarchyID::GetRoot().GetDescendant(NULL, NULL)),
(4, 'Dev Manager', 'Manager', HierarchyID::GetRoot().GetDescendant('/1/', NULL)),
(5, 'Finance Manager', 'Manager', HierarchyID::GetRoot().GetDescendant('/2/', NULL)),
(6, 'Developer', 'Developer', HierarchyID::GetRoot().GetDescendant('/1/1/', NULL)),
(7, 'Accountant', 'Accountant', HierarchyID::GetRoot().GetDescendant('/2/1/', NULL));
Go
INSERT INTO EmployeeAdditionalManagers (EmployeeID, ManagerID)
VALUES 
(6, 2), -- Developer also reports to CTO
(7, 3); -- Accountant also reports to CFO
Go
CREATE FUNCTION dbo.fn_securitypredicate(@OrgNode HierarchyID, @EmployeeID INT)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN 
    SELECT 1 AS fn_securitypredicate_result
    WHERE @OrgNode.IsDescendantOf(USER_ORG_NODE()) = 1
    OR EXISTS (
        SELECT 1 
        FROM EmployeeAdditionalManagers em
        WHERE em.EmployeeID = @EmployeeID
        AND em.ManagerID = USER_ID() -- Replace USER_ID() with the appropriate user mapping
    );
Go
CREATE SECURITY POLICY EmployeeSecurityPolicy
ADD FILTER PREDICATE dbo.fn_securitypredicate(OrgNode, EmployeeID) ON dbo.Employees
WITH (STATE = ON);