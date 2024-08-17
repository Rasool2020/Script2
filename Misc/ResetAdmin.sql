Update t00t_user Set Password = '048042032049042049' Where user_code = 1
--Delete From t00user_form Where User_Code = 1

UPDATE [t00user_form]
SET [ins_able]=1, [del_able]=1, [print_able]=1, [update_able]=1, [access_able]=1, [view_able]=1
Where User_Code = 1


insert into t00user_form
Select 1 User_Code,form_code,ins_able,del_able,print_able,update_able,access_able,view_able,0 as shortcutid 
From t00t_permision Where form_code not in (Select form_code From t00user_form Where User_Code = 1)

