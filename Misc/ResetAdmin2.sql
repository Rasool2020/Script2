Update t00t_user Set Password = '048042032049042049' Where user_code = 1

UPDATE [t00user_form]
SET [ins_able]=1, [del_able]=1, [print_able]=1, [update_able]=1, [access_able]=1, [view_able]=1
Where User_Code = 1

insert into t00user_form
Select 1 User_Code,form_code,ins_able,del_able,print_able,update_able,access_able,view_able,0 as shortcutid 
From t00t_permision Where form_code not in (Select form_code From t00user_form Where User_Code = 1)

insert into t00UserProject(projectID,t00UserID,isDenied)
Select t00Project.id ProjectID,t00t_user.id UserID,0 isDenied From t00Project cross join t00t_user
Where t00t_user.user_code=1 And t00Project.id not in 
	(Select ProjectID From t00UserProject 
	 inner join t00t_user on t00t_user.id = t00UserProject.t00UserID
	 Where t00t_user.user_code=1)
