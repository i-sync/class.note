------------视图---------------
select * from view_dept_emp
use tarena
select * from view_stu_course_mark
drop view view_stu_course_mark

create view view_student_info
as 
	select top 10 * from student
go

drop view view_student_info

select * from view_student_info
	where stu_sex ='女'

create view view_st
 as 
	select stu_id ,stu_name from student
go			

drop view view_st

select * from view_st

delete from view_st

insert into view_st
select 201106 ,'heheh'

update view_st
set stu_name='hello'
where stu_id=201105

create view view_info_mark
as 
	select student.stu_id ,stu_name ,lab_exam,written_exam
	from student 
	join mark
	on student.stu_id = mark.stu_id
go	

select * from view_info_mark

update view_info_mark
set stu_name='liuda'
where stu_id=201105

insert into view_info_mark
select 201106,'hehe',72,45

drop view view_info_mark
create view view_info_mark
as 
	select student.*,mark.lab_exam,mark.written_exam
	from student 
	join mark
	on student.stu_id = mark.stu_id
go	
select * from view_info_mark


-----------------触发器--------------

use bank
go
select* from customer
create table customer
(
	customer_id int primary key,
	customer_name nvarchar (20) not null,
	customer_balance money 
)

create table transinfo
(
	trans_id int identity(1,1) primary key,
	customer_id int ,
	trans_type nvarchar(30) not null,
	trans_money money,
	trans_date datetime
)

drop table transinfo

alter table transinfo
	add constraint FK_customer_id foreign key (customer_id) references customer(customer_id)

alter table transinfo
	drop constraint FK_customer_id

insert into customer
	select 'wangwu' ,1000 union
	select 'liuda', 1000	

select * from customer
select * from transinfo

---创建insert触发器
create trigger tri_transinfo_insert
on transinfo
for insert 
as
	declare @customer_id int 
	declare @trans_type nvarchar(20)
	declare @trans_money money 
	
	select @customer_id = customer_id,@trans_type= trans_type ,@trans_money= trans_money
	from inserted
	
	if(@trans_type='存款')
	begin 
		update customer
		set customer_balance=customer_balance+@trans_money
		where customer_id=@customer_id
	end
	else
	begin
		update customer
		set customer_balance=customer_balance-@trans_money
		where customer_id=@customer_id
	end
go	

--执行insert 语句
insert into transinfo
	select 4,'取款',500,getdate()

select * from customer
select * from transinfo	


--创建delete触发器

create trigger tri_customer_delete
on customer
for delete 
as 
	declare @customer_id int 
	select @customer_id = customer_id from deleted
	delete from transinfo 
	where customer_id= @customer_id
go

drop trigger tri_customer_delete

--删除customer中的数据
delete from customer 
	where customer_id=3


--创建update触发器
create trigger tri_customer_update
on customer
for update 
as
	declare @customer_idold int 
	declare @customer_idnew int 
	select @customer_idold =customer_id from deleted
	select @customer_idnew = customer_id from inserted
	
	update transinfo
	set customer_id =@customer_idnew 
	where customer_id=@customer_idold
go

update customer 
set customer_id =3
where customer_id=4

--为transinfo表添加delete 触发器,要求最多删除两条数据
create trigger tri_transinfo_delete
on transinfo
for delete 
as
	declare @count int 
	select @count = count(*) from deleted
	if(@count>2)
	begin 
		rollback transaction
	end
go

select * from customer
select * from transinfo

insert into customer
	select 4,'wangwu',1000 union
	select 5 ,'hello',1000

insert into transinfo	
	select 3,'存款',10000,getdate() union
	select 4,'取款',100,getdate()

delete from customer
	where customer_id=1	
	