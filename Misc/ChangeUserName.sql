Select u.user_code,c.customer_code,* 
From t00t_user u
Inner Join t00Customer c on u.user_code = c.userCode
where userCode=79

Select * From t00Customer where userCode=79
Select * From personel where customerCode=493
Go
alter table personel disable Trigger all
update personel set name='⁄·Ì',family='«Â—«»Ì' where customerCode=493
alter table personel Enable Trigger all
alter table t00t_user disable Trigger all
alter table t00Customer disable Trigger all
update t00t_user set user_name='⁄·Ì_«Â—«»Ì',name='⁄·Ì',family='«Â—«»Ì',deleted=0,enabled=1,showOnLoginForm=1,isDeleted=0,password='048042032049042049' where user_code=79
update t00Customer set customer_name='⁄·Ì «Â—«»Ì',bed=0,firstremind=0 where userCode=79
alter table t00t_user Enable Trigger all
alter table t00Customer Enable Trigger all
Go
Alter Table t00t_user disable Trigger all
Update t00t_user Set 
	user_name = Replace(user_name ,CHAR(152),CHAR(223)),
	family = Replace(family ,CHAR(152),CHAR(223))
Where user_name like '%' + char(152) + '%' or family like '%' + char(152) + '%'
Alter Table t00t_user Enable Trigger all
Go
Alter Table personel disable Trigger all
Update personel Set 
	name = Replace(name ,CHAR(152),CHAR(223)),
	family = Replace(family ,CHAR(152),CHAR(223))
Where name like '%' + char(152) + '%' or family like '%' + char(152) + '%'
Alter Table personel Enable Trigger all
Go
Alter Table t00Customer disable Trigger all
Update t00Customer Set 
	Customer_name = Replace(Customer_name ,CHAR(152),CHAR(223))
Where Customer_name like '%' + char(152) + '%'
Alter Table t00Customer Enable Trigger all
Go