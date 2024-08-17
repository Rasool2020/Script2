SELECT @@SERVERNAME, 
SERVERPROPERTY('ComputerNamePhysicalNetBIOS') AS [Local Machine Name],  
(cpu_count / hyperthread_ratio) AS [Physical CPUs],  
hyperthread_ratio AS [Hyperthread Ratio],  
cpu_count AS [Logical CPUs],  
softnuma_configuration AS [Soft-NUMA Configuration],  
softnuma_configuration_desc AS [Soft-NUMA Description],  
socket_count AS [Available Sockets],  
numa_node_count AS [Available NUMA Nodes]  
FROM  
sys.dm_os_sys_info;  