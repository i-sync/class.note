


create table class
(
	class_id int primary key ,
	class_name nvarchar(8) not null,
)
go

create table student
(
	stu_id int primary key,
	stu_name nvarchar(8) not null,
	stu_age int default(18) check(stu_age>=18 and stu_age<=50),
	stu_sex nchar(1) check(stu_sex like '[Ů��]') default('��'),
	stu_address nvarchar(50) default('��ַ����'),
	stu_guid uniqueidentifier default(newid()) unique ,
	stu_seat int identity(1,1),
	class_id int foreign key references class(class_id)
)
go

insert into class values(1,'MSD1102')

insert into student(stu_id,stu_name,class_id) values(1,'zhangsan',1)
insert into student(stu_id,stu_name,stu_age,stu_sex,stu_address,class_id) values (3,'wangwu',25,'Ů','����',2)

select * from class
select * from student 


drop table student
go

drop table class
go

create table class
(
	class_id int not null ,
	class_name nvarchar(8) not null,
)
go

create table student
(
	stu_id int not null,
	stu_name nvarchar(8) not null,
	stu_age int not null,
	stu_sex nchar(1) not null,
	stu_address nvarchar(50),
	stu_guid uniqueidentifier ,
	stu_seat int identity(1,1),
	class_id int not null
)
go

--Ϊ�༶���������
alter table class
	add constraint PK_class_id primary key (class_id)
--Ϊѧ���������	
alter table student
	add constraint PK_stu_id primary key (stu_id)
--Ϊѧ��������ӷ�Χ
alter table student
	add constraint CH_stu_age check (stu_age>=18 and stu_age<=50)
--Ϊѧ���������Ĭ��ֵ	
alter table student
	add constraint DF_stu_age default (18) for stu_age			
--Ϊѧ���Ա���ӷ�Χ
alter table student 
	add constraint CH_stu_sex check(stu_sex like '[��Ů]')
--Ϊѧ����ͥ��ַ���Ĭ��ֵ
alter table student 
	add constraint DF_stu_address default ('��ַ����') for stu_address
--Ϊѧ����������
alter table student 
	add constraint FK_class_id_student foreign key (class_id) references class(class_id)

--
alter table student 
	add constraint DF_stu_guid default (newid()) for stu_guid
	
--Ϊѧ����λ���ΨһԼ��
alter table student 
	add constraint UQ_stu_seat unique (stu_seat)

--ɾ��Լ��
alter table student 
	drop constraint UQ_stu_seat

--�鿴ĳ�����Լ��
exec sp_helpconstraint student
--�鿴���ݿ��е����ж���
exec sp_help 
exec sp_help student 

�˽�
--Լ�����ࣺ
--�м�Լ���ͱ�Լ��
--�м�Լ����Ӧ���ڵ���
--��Լ����Ӧ���ڶ���
--	1)alter table ���� add constraint...
--	2)create table class
--	(
--		class_id int not null ,
--		class_name nvarchar(8) not null,
--		primary key(class_id)    --�����һ����Լ��
--	)
--	go	
	
--����ʽԼ������Ϊ�������һ���ֽ��ж���ģ�ϵͳ�Զ�ǿ��������
--	����������������Լ��ʹ������ʽԼ��
--	���磺��������Լ����ʵ��������Լ��������������Լ��
--����ʽԼ�����ڽű���ǿ�������ԡ�	
--	���ӵģ������ģ�����ʽԼ������ʵ�ֵģ���ʹ�ù���ʽԼ��
--	���磺�Զ���������Լ��
	--Լ���Ĵ���Ҫ�ۺϿ��ǣ�Ҫ���ȿ�����������
	--Լ���ή�ͳ��������

drop table student 
go 
drop table class
go	

create table class
(
	class_id int primary key ,
	class_name nvarchar(20) not null,
)
go 

create table student 
(
	stu_id int primary key,
	stu_name nvarchar(20) not null ,
	stu_age int default (18) check(stu_age>=18 and stu_age<=50) not null,
	stu_sex char(2) default ('��') check(stu_sex like '[��Ů]') not null,
	stu_address nvarchar(50) default ('��ַ����'),
	stu_seat int identity (1,1) ,
	stu_guid uniqueidentifier default (newid()) unique ,
	class_id int not null foreign key references class(class_id)
)
go 

create table class
(
	class_id int not null,
	class_name nvarchar(10) not null
)
go

create table student 
(	
	stu_id int not null,
	stu_name char(8) not null,
	stu_age int not null,
	stu_sex char(2) not null,
	stu_address nvarchar(50),
	stu_seat int identity(1,1),
	stu_guid uniqueidentifier not null,
	class_id int not null
)
go

drop table student

alter table class 
	add constraint PK_class_id primary key (class_id)
go	
	
alter table student 
	add constraint PK_stu_id primary key (stu_id)
go

alter table student 
	add constraint DF_stu_age default (18) for stu_age 
go

alter table student 
	add constraint CK_stu_age check(stu_age>=18 and stu_age<=50)
go

alter table student
	add constraint DF_stu_sex default ('��') for stu_sex
go

alter table student 
	add constraint CK_stu_sex check(stu_sex like '[��Ů]')
go
	
alter table student 
	add constraint	DF_stu_address default ('��ַ����') for stu_address
go
	
alter table student 
	add constraint DF_stu_guid default (newid()) for stu_guid	
go

alter table student
	add constraint UQ_stu_guid unique (stu_guid)
go

alter table student 
	add constraint FK_class_id_student foreign key (class_id) references class(class_id)
go

drop table student

create table student
(
	stu_id int,
	stu_name char(8) not null,
	stu_age int not null,
	stu_sex char(2) not null,
	stu_address nvarchar(50),
	class_id int not null,
	primary key (stu_id) ,
	check(stu_age>=18 and stu_age <=50),
	check(stu_sex like '[��Ů]'),
	foreign key (class_id) references class(class_id)
)	

alter table student 
	add constraint DF_stu_age default (18) for stu_age
go
	
alter table student
	add constraint DF_stu_sex default ('��') for stu_sex
go	

alter table student 
	add constraint DF_stu_addresss default ('��ַ����') for stu_address

alter table student
	drop constraint	