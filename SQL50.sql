--创建数据库
create database sql50
on primary 
(
	name='sql50',
	filename='D:\sql50\sql50.mdf',
	size=3,
	filegrowth=2
)
log on 
(
	name='sql50_log',
	filename='D:\sql50\sql50_log.ldf'
)
go

--创建表
use sql50
go
create table dept
(
	deptno int primary key,		--部门编号	
	dname nvarchar(14) not null,	--部门名称
	loc nvarchar(13)		--部门所在地
)
go

create table emp
(
	empno int primary key,   --雇员编号
	ename nvarchar(10) not null,  --雇员姓名
	job nvarchar(9),     --雇员的职位
	mgr int,			--上级主管
	hiredate datetime,		--入职日期
	sal numeric(7,2),		--薪水
	comm numeric(7,2),		--佣金
	deptno int references dept(deptno)   --部门编号
)
go

--向dept表中插入数据
insert into dept
	select 10,'accounting','new york' union
	select 20,'research' ,'dallas' union
	select 30,'sales','chicago' union
	select 40,'operations','boston'

--删除数据重新插入
truncate table emp
--向emp 表中插入数据
insert into emp
	select 7369,'SMITH','clerk',7902,'2000-12-17',800,null,20 union
	select 7499,'allen','salesman',7698,'2001-2-20',1600,300,30 union
	select 7521,'WARD','salesman',7698,'2001-2-22',1250,500,30 union
	select 7566,'JONES','manager',7839,'2001-4-2',2975,null,20 union
	select 7654,'MARTIN','salesman',7698,'2001-9-28',1250,1400,30 union
	select 7698,'BLAKE','manager',7839,'2001-5-1',2850,null,30 union
	select 7782,'CLARK','manager',7839,'2001-6-9',2450,null,10 union
	select 7788,'scott','analyst',7566,'2002-12-9',3000,null,20 union
	select 7839,'king','president',null,'2001-11-17',5000,null,20 union
	select 7844 ,'TURNER','salesman',7698,'2001-9-8',1500,0,30 union
	select 7876,'ADAMS','clerk',7788,'2003-1-12',1100,null,20 union
	select 7900 ,'JAMES','clerk',7698,'2001-3-12',950,null,30 union
	select 7902, 'FORD','analyst',7566,'2001-3-12',3000,null,20 union
	select 7934,'MILLER','clerk',7782,'2002-01-23',1300,null,10

--基本查询
--1.查询所有雇员
select empno as 雇员编号,ename as 雇员姓名, job as 雇员职位,mgr as 上级主管编号,hiredate as 入职日期,sal as 薪金, comm as 佣金,deptno as 编号
	from emp	
--2.查询所有部门
select deptno as 部门编号,dname as 名称, loc as 部门所在地
	from dept

--3.查询没有佣金的所有雇员
select * from emp
	where comm is null	
	
--4.查询薪金和佣金总数大于2000的所有雇员
select * from emp
	where comm+sal>2000	

--5.选择部门30中的雇员
select * from emp
	where deptno=30

--6.列出所有办事员('clerk')的姓名
select * from emp
	where job='clerk'
--7.找出佣金高于薪金的雇员
select* from emp
	where comm>sal

--8.找出佣金高于薪金60%的雇员
select * from emp
	where comm>sal*0.6

--9.找出部门10中所有经理和部门20中的所有办事员的详细资料
select * from emp
	where job='manager' and deptno=10
	or
		job='clerk' and deptno=20

--2011-02-27
exec sp_detach_db sql50
exec sp_attach_db @dbname=sql50,@filename1='D:\sql50\sql50.mdf'
--10.找出部门10中所有经理,部门20中所有办事员,既不是经理也不是办事员
	--但薪金>=2000的所有雇员的详细地信息		
select * from emp
	where job='manager' and deptno=10
	or	job='clerk' and deptno=20
	or	job not in('manager','clerk') and sal>=2000

--11.找出收取佣金的雇员的不同工作
select distinct job from emp
	where comm is not null	

--12.查找不收取佣金或收取佣金低于100元的所有雇员
select * from emp	
	where comm is null
		or	comm<=100

--13.找出工龄大于8的所有雇员
select * from emp
	where datediff(year,hiredate,getdate())>10

--14.显示首字母大写的所有雇员的姓名
select ename from emp
	where ascii(substring(ename,1,1)) between 65 and 96

--15.显示姓名正好为5个字符的所有雇员
select ename from emp
	where len(ename)=5		

--16.显示带有R的雇员姓名		
select ename from emp
	where contains(ename ,'R')
select ename from emp
	where ename like '%R%'


--17.显示不带有R的雇员姓名
select ename from emp
	where ename like '[^R]'

--18显示包含A的所有雇员姓名及A在姓名字段中的位置
select ename from emp
	where ename like '_%A%_'
	
--19显示所有雇员的姓名,用a代替A
select replace(ename,'A','a') from emp
	

--20显示所有雇员姓名的前三个字符
select substring(ename,1,3) from emp

--21显示所有雇员的详细,按姓名排序
select * from emp
	order by ename desc

--22显示所有雇员的姓名,根据其工龄,将工龄最大的排在前面
select ename from emp
	order by datediff(year,hiredate,getdate()) desc

--23显示所有雇员的姓名,工作,薪金,按工作降序排,工作相同者再按薪金排
select ename,job,sal from emp
	order by job desc ,sal

--24显示在一月为30天的情况下所有雇员的日薪金,忽略小数
select ename as 姓名,cast(sal/30 as int) as 日薪金 from emp

--25找出在(任何年份)2月份受聘的所有雇员
select * from emp
	where datepart(month,hiredate)=2

--26对于每个雇员,显示其加入工司的天数
select ename as 姓名,datediff(day,hiredate,getdate()) as 入职天数 from emp

--27列出至少有一个雇员的所有部门
select distinct deptno  from emp

--28列出各种类别工作的最低工资
select job as 工作名,min(sal+ case when comm is null then 0 else comm end) as 最低工资 
	from emp
	group by job 
--select min(case when comm is null then 0 else comm end) from emp

--29列出各个部门经理的最低薪金	
select deptno as 部门编号, min(sal)  from emp
	where job ='manager'
	group by deptno
	
--30列出薪金高于公司平均水平的所有雇员
select * from emp
	where sal>(select avg(sal) from emp)

--31列出各工作类别的最低薪金,并且最低薪金>1500
select job as 职位, min(sal) as 最低薪金 from emp
	group by job
	having min(sal)>1500

--32显示所有雇员的姓名和加入工司的年份和月份,按雇员受雇日所在的月份,将最早年份的项排在前面
select ename as 姓名,datename(year,hiredate)+'-'+datename(month,hiredate) as 入职年月 from emp
	order by datediff(month ,hiredate,getdate()) desc

--2011-02-28
--33显示所有雇员的姓名以及满8年服务年限的日期
--use sql50
--go
--select * from emp
select ename as 姓名,hiredate as 入职日期,dateadd(year,8 ,hiredate) as 满8年服务年限的日期
	from emp
	
	
--34显示所有雇员的服务年限:总得年数,总得月数,总得天数
select ename as 姓名,  datediff(year,hiredate,getdate()) 总得年数,datediff(month,hiredate,getdate()) as 总得月数,datediff(day,hiredate,getdate()) as 总得天数
	from emp

--35列出按计算的字段排序的所有雇员的年薪.
--即按照掉落对雇员进行排序,年薪指雇员每月的总收入总共12个月的累加
select * from emp
select ename as 姓名, sal*12 as 年薪	
from emp
order by sal desc

--36列出年薪前5名的雇员
select top 5 ename as 姓名,sal*12 as 年薪
from emp
order by sal desc

--37列出年薪低于10000的雇员
select ename as 姓名,sal * 12 as 年薪
from emp
where sal*12 <10000


--38列出雇员的平均月薪和平均年薪
select avg(sal) as 平均月薪  ,avg (sal) *12 as 平均年薪
	from emp
	
--39列出部门名称和这些部门的雇员,同时列出那些没有雇员的部门
select * from emp
select * from dept
select dname as 部门名称,ename as 雇员姓名
	from dept
	left join emp
	on emp.deptno=dept.deptno
	order by dname	

--40.列出每个部门的信息以及该部门中雇员的数量
select dept.dname as 部门名称,count(emp.ename) as 雇员总数
	from dept
	join emp
	on dept.deptno= emp.deptno
	group by dept.dname

--41列出薪金比"SMITH"多的所有雇员
select * from emp
	where sal>
	(
		select sal from emp
		where ename='smith'
	)
--42列出所有雇员的姓名及其直接上级的姓名
select a.ename as 姓名,b.ename as 上级姓名
from emp a
join emp b
on a.mgr=b.empno

select a.ename as 姓名 ,(select b.ename from emp b where a.mgr=b.empno) as 直接上级
from emp a

--43 列出入职日期早于其直接上级的所有雇员
--select * from emp

select a.* 
	from emp a
	join emp b 
	on a.mgr=b.empno
	where a.hiredate<b.hiredate

--44.列出所有办事员('clerk')的姓名及其部门名称	
select ename as 姓名,dname as 部门名称
	from emp 
	join dept
	on emp.deptno=dept.deptno
	where emp.job='clerk'

--45.列出从事'sales'(销售)工作的雇员的姓名,假定不知道销售部的部门编号
select * from emp
	where job ='salesman'

--46.列出与'scott'从事相同工作的所有雇员
select * from emp
	where job =
	(select job from emp
	where ename='scott')

select a.* 
	from emp a
	join emp b 
	on a.empno!=b.empno
	where b.ename='scott' and a.job=b.job	
--47.列出某些雇员的姓名和薪金,条件是他们的薪金等于部门30中任何一个雇员的薪金
select ename as 姓名,sal as 薪金
	from emp
	where sal>
	(
		select min(sal) from emp
		where deptno=30
	)

--48.列出某些雇员的姓名和薪金,条件是他们的薪金高于部门30中所有雇员的薪金
select ename as 姓名,sal as 薪金
	from emp
	where sal>
	(
		select max(sal) from emp
		where deptno=30
	)
--49.列出从事同一种工作但属于不同部门的雇员的不同组合
select a.ename ,b.ename
	from emp a 
	join emp b 
	on a.empno!=b.empno
	where a.job=b.job
	and a.deptno!=b.deptno
	order by a.ename
--50.列出所有雇员的名称,部门名称和薪金	
select ename as 姓名,dname as 部门名称, sal as 薪金
	from emp 
	join dept
	on emp.deptno=dept.deptno
	