Select 'Backup Database [' + name + '] To Disk=''D:\Backup\' + name + '.bak'' With Compression, Stats=1'
From sys.databases
Where name in ('financialdb', 'invoice', 'notificationdb', 'paymentdb', 'studentdb', 'appversiondb', 'fooddb')
Go