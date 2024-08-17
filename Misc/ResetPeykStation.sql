alter table t00OperationLog disable trigger all
Delete From t00OperationLog
alter table t00OperationLog enable trigger all
Go
alter table t00EnteranceLog disable trigger all
Delete From t00EnteranceLog
alter table t00EnteranceLog enable trigger all
Go
Delete From t00Station Where id>0
