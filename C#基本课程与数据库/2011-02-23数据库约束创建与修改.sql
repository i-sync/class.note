


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
	stu_sex nchar(1) check(stu_sex like '[女男]') default('男'),
	stu_address nvarchar(50) default('地址不详'),
	stu_guid uniqueidentifier default(newid()) unique ,
	stu_seat int identity(1,1),
	class_id int foreign key references class(class_id)
)
go

insert into class values(1,'MSD1102')

insert into student(stu_id,stu_name,class_id) values(1,'zhangsan',1)
insert into student(stu_id,stu_name,stu_age,stu_sex,stu_address,class_id) values (3,'wangwu',25,'女','北京',2)

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

--为班级表添加主键
alter table class
	add constraint PK_class_id primary key (class_id)
--为学生添加主键	
alter table student
	add constraint PK_stu_id primary key (stu_id)
--为学生年龄添加范围
alter table student
	add constraint CH_stu_age check (stu_age>=18 and stu_age<=50)
--为学生年龄添加默认值	
alter table student
	add constraint DF_stu_age default (18) for stu_age			
--为学生性别添加范围
alter table student 
	add constraint CH_stu_sex check(stu_sex like '[男女]')
--为学生家庭地址添加默认值
alter table student 
	add constraint DF_stu_address default ('地址不详') for stu_address
--为学生表添加外键
alter table student 
	add constraint FK_class_id_student foreign key (class_id) references class(class_id)

--
alter table student 
	add constraint DF_stu_guid default (newid()) for stu_guid
	
--为学生座位添加唯一约束
alter table student 
	add constraint UQ_stu_seat unique (stu_seat)

--删除约束
alter table student 
	drop constraint UQ_stu_seat

--查看某个表的约束
exec sp_helpconstraint student
--查看数据库中的所有对象
exec sp_help 
exec sp_help student 

了解
--约束分类：
--列级约束和表级约束
--列级约束：应用于单列
--表级约束：应用于多列
--	1)alter table 表名 add constraint...
--	2)create table class
--	(
--		class_id int not null ,
--		class_name nvarchar(8) not null,
--		primary key(class_id)    --这就是一个表级约束
--	)
--	go	
	
--声明式约束：作为对象定义的一部分进行定义的，系统自动强制完整性
--	基本的灵气完整性约束使用声明式约束
--	例如：域完整性约束，实体完整性约束，引用完整性约束
--过程式约束：在脚本中强制完整性。	
--	复杂的，大量的，声明式约束不能实现的，才使用过程式约束
--	例如：自定义完整性约束
	--约束的创建要综合考虑，要优先考虑性能问题
	--约束会降低程序的性能

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
	stu_sex char(2) default ('男') check(stu_sex like '[男女]') not null,
	stu_address nvarchar(50) default ('地址不详'),
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
	add constraint DF_stu_sex default ('男') for stu_sex
go

alter table student 
	add constraint CK_stu_sex check(stu_sex like '[男女]')
go
	
alter table student 
	add constraint	DF_stu_address default ('地址不详') for stu_address
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
	check(stu_sex like '[男女]'),
	foreign key (class_id) references class(class_id)
)	

alter table student 
	add constraint DF_stu_age default (18) for stu_age
go
	
alter table student
	add constraint DF_stu_sex default ('男') for stu_sex
go	

alter table student 
	add constraint DF_stu_addresss default ('地址不详') for stu_address

alter table student
	drop constraint	