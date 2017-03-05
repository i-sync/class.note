exec sp_detach_db @dbname=dbstu
exec sp_attach_db @dbname=dbstu,@filename1='D:\projects\dbstu.mdf',@filename2='D:\projects\dbstu_log.ldf'

backup database dbstu to disk ='D:\projects\backup\back.bak'

create database student
on primary
(
	name=student,
	filename='D:\project\student.mdf',
	size=5,
	maxsize=100,
	filegrowth=20%
)
log on 
(
	name=student_log,
	filename='D:\project\student_log.ldf'
)
go

create table class
(
	class_id int not null ,
	class_name char(10) not null
)
go

alter table class
	add constraint PK_class_id primary key(class_id)
go

create table student_info
(
	student_id int not null,
	student_name char(8) not null,
	student_sex char(2) not null,
	student_age int not null,
	student_address nvarchar(50) ,
	student_seat int identity(1,1) ,
	class_id int not null
)
go
drop table student_info

alter table student_info 
	add constraint PK_student_id primary key(student_id)
go

alter table student_info
	add constraint CK_student_sex check(student_sex like '[��Ů]')
go

alter table student_info
	add constraint DF_student_sex default ('��') for student_sex
go

alter table student_info 
	add constraint CK_student_age check(student_age>=0 and student_age<=100)
go

alter table student_info
	add constraint DF_student_address default ('��ַ����') for student_address	
go

alter table student_info
	add constraint FK_class_id_student foreign key (class_id) references class(class_id)
go	


alter table student_info
	drop constraint FK_class_id_student


select * from class
go

select * from student_info
go


insert into class
	select 1,'MSD1101' union
	select 2,'MSD1102' union
	select 3,'MSD1103'

insert into student_info 
	select 1,'zhangsan','��',18,'����',1 union
	select 2,'lisi','Ů',20,'����',1 union
	select 3,'wangwu','��',22,'ɽ��',2 union
	select 4,'liuda','Ů',21,'����',2 union
	select 5,'xiaoming','��',20,'�Ϻ�',3

select student_id as ѧ��,student_name ����,�Ա�=student_sex,student_age as ����,student_address ��ͥ��ַ,��λ��=student_seat,class_id as �༶�� 
	from student_info
	where student_sex='��' and student_age>=20
	order by student_age asc

create table a
(
	student_id int not null,
	student_name char(8) not null,
	student_sex char(2) not null,
	student_age int not null, 
	student_address nvarchar(50) ,
	student_seat int identity (1,1),
	class_id int not null
)	
go
	
insert into a select student_id,student_name,student_sex,student_age,student_address,class_id from student_info
go

select student_id,student_name,student_sex,student_age,student_address,student_seat,class_id from a	
go

select student_id,student_name,student_age,student_address,class_id 
	into b from student_info where class_id=1
go
	
select * from b
go

select * from student_info
go

update student_info 
	set student_name='hehe'
	where student_id=4

update student_info 
	set student_sex='Ů'
	
delete from student_info
	where student_id=5

truncate table b
	--truncate ˵��:��������ձ�����������,������������,ɾ����������ʱ,Ч��Ҫ��delete��,��Ϊ
	--�ڲ���:��ɾ���ñ�,Ȼ�����ع���,����ͬʱ�����Լ��������д�ͷ��ʼ
	--ȱ��:����ɾ�������Լ���ı�
	eg: truncate table student_info
	
select * from b

select * from student_info

select top 2 * from student_info




