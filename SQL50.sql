--�������ݿ�
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

--������
use sql50
go
create table dept
(
	deptno int primary key,		--���ű��	
	dname nvarchar(14) not null,	--��������
	loc nvarchar(13)		--�������ڵ�
)
go

create table emp
(
	empno int primary key,   --��Ա���
	ename nvarchar(10) not null,  --��Ա����
	job nvarchar(9),     --��Ա��ְλ
	mgr int,			--�ϼ�����
	hiredate datetime,		--��ְ����
	sal numeric(7,2),		--нˮ
	comm numeric(7,2),		--Ӷ��
	deptno int references dept(deptno)   --���ű��
)
go

--��dept���в�������
insert into dept
	select 10,'accounting','new york' union
	select 20,'research' ,'dallas' union
	select 30,'sales','chicago' union
	select 40,'operations','boston'

--ɾ���������²���
truncate table emp
--��emp ���в�������
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

--������ѯ
--1.��ѯ���й�Ա
select empno as ��Ա���,ename as ��Ա����, job as ��Աְλ,mgr as �ϼ����ܱ��,hiredate as ��ְ����,sal as н��, comm as Ӷ��,deptno as ���
	from emp	
--2.��ѯ���в���
select deptno as ���ű��,dname as ����, loc as �������ڵ�
	from dept

--3.��ѯû��Ӷ������й�Ա
select * from emp
	where comm is null	
	
--4.��ѯн���Ӷ����������2000�����й�Ա
select * from emp
	where comm+sal>2000	

--5.ѡ����30�еĹ�Ա
select * from emp
	where deptno=30

--6.�г����а���Ա('clerk')������
select * from emp
	where job='clerk'
--7.�ҳ�Ӷ�����н��Ĺ�Ա
select* from emp
	where comm>sal

--8.�ҳ�Ӷ�����н��60%�Ĺ�Ա
select * from emp
	where comm>sal*0.6

--9.�ҳ�����10�����о���Ͳ���20�е����а���Ա����ϸ����
select * from emp
	where job='manager' and deptno=10
	or
		job='clerk' and deptno=20

--2011-02-27
exec sp_detach_db sql50
exec sp_attach_db @dbname=sql50,@filename1='D:\sql50\sql50.mdf'
--10.�ҳ�����10�����о���,����20�����а���Ա,�Ȳ��Ǿ���Ҳ���ǰ���Ա
	--��н��>=2000�����й�Ա����ϸ����Ϣ		
select * from emp
	where job='manager' and deptno=10
	or	job='clerk' and deptno=20
	or	job not in('manager','clerk') and sal>=2000

--11.�ҳ���ȡӶ��Ĺ�Ա�Ĳ�ͬ����
select distinct job from emp
	where comm is not null	

--12.���Ҳ���ȡӶ�����ȡӶ�����100Ԫ�����й�Ա
select * from emp	
	where comm is null
		or	comm<=100

--13.�ҳ��������8�����й�Ա
select * from emp
	where datediff(year,hiredate,getdate())>10

--14.��ʾ����ĸ��д�����й�Ա������
select ename from emp
	where ascii(substring(ename,1,1)) between 65 and 96

--15.��ʾ��������Ϊ5���ַ������й�Ա
select ename from emp
	where len(ename)=5		

--16.��ʾ����R�Ĺ�Ա����		
select ename from emp
	where contains(ename ,'R')
select ename from emp
	where ename like '%R%'


--17.��ʾ������R�Ĺ�Ա����
select ename from emp
	where ename like '[^R]'

--18��ʾ����A�����й�Ա������A�������ֶ��е�λ��
select ename from emp
	where ename like '_%A%_'
	
--19��ʾ���й�Ա������,��a����A
select replace(ename,'A','a') from emp
	

--20��ʾ���й�Ա������ǰ�����ַ�
select substring(ename,1,3) from emp

--21��ʾ���й�Ա����ϸ,����������
select * from emp
	order by ename desc

--22��ʾ���й�Ա������,�����乤��,��������������ǰ��
select ename from emp
	order by datediff(year,hiredate,getdate()) desc

--23��ʾ���й�Ա������,����,н��,������������,������ͬ���ٰ�н����
select ename,job,sal from emp
	order by job desc ,sal

--24��ʾ��һ��Ϊ30�����������й�Ա����н��,����С��
select ename as ����,cast(sal/30 as int) as ��н�� from emp

--25�ҳ���(�κ����)2�·���Ƹ�����й�Ա
select * from emp
	where datepart(month,hiredate)=2

--26����ÿ����Ա,��ʾ����빤˾������
select ename as ����,datediff(day,hiredate,getdate()) as ��ְ���� from emp

--27�г�������һ����Ա�����в���
select distinct deptno  from emp

--28�г��������������͹���
select job as ������,min(sal+ case when comm is null then 0 else comm end) as ��͹��� 
	from emp
	group by job 
--select min(case when comm is null then 0 else comm end) from emp

--29�г��������ž�������н��	
select deptno as ���ű��, min(sal)  from emp
	where job ='manager'
	group by deptno
	
--30�г�н����ڹ�˾ƽ��ˮƽ�����й�Ա
select * from emp
	where sal>(select avg(sal) from emp)

--31�г��������������н��,�������н��>1500
select job as ְλ, min(sal) as ���н�� from emp
	group by job
	having min(sal)>1500

--32��ʾ���й�Ա�������ͼ��빤˾����ݺ��·�,����Ա�ܹ������ڵ��·�,��������ݵ�������ǰ��
select ename as ����,datename(year,hiredate)+'-'+datename(month,hiredate) as ��ְ���� from emp
	order by datediff(month ,hiredate,getdate()) desc

--2011-02-28
--33��ʾ���й�Ա�������Լ���8��������޵�����
--use sql50
--go
--select * from emp
select ename as ����,hiredate as ��ְ����,dateadd(year,8 ,hiredate) as ��8��������޵�����
	from emp
	
	
--34��ʾ���й�Ա�ķ�������:�ܵ�����,�ܵ�����,�ܵ�����
select ename as ����,  datediff(year,hiredate,getdate()) �ܵ�����,datediff(month,hiredate,getdate()) as �ܵ�����,datediff(day,hiredate,getdate()) as �ܵ�����
	from emp

--35�г���������ֶ���������й�Ա����н.
--�����յ���Թ�Ա��������,��нָ��Աÿ�µ��������ܹ�12���µ��ۼ�
select * from emp
select ename as ����, sal*12 as ��н	
from emp
order by sal desc

--36�г���нǰ5���Ĺ�Ա
select top 5 ename as ����,sal*12 as ��н
from emp
order by sal desc

--37�г���н����10000�Ĺ�Ա
select ename as ����,sal * 12 as ��н
from emp
where sal*12 <10000


--38�г���Ա��ƽ����н��ƽ����н
select avg(sal) as ƽ����н  ,avg (sal) *12 as ƽ����н
	from emp
	
--39�г��������ƺ���Щ���ŵĹ�Ա,ͬʱ�г���Щû�й�Ա�Ĳ���
select * from emp
select * from dept
select dname as ��������,ename as ��Ա����
	from dept
	left join emp
	on emp.deptno=dept.deptno
	order by dname	

--40.�г�ÿ�����ŵ���Ϣ�Լ��ò����й�Ա������
select dept.dname as ��������,count(emp.ename) as ��Ա����
	from dept
	join emp
	on dept.deptno= emp.deptno
	group by dept.dname

--41�г�н���"SMITH"������й�Ա
select * from emp
	where sal>
	(
		select sal from emp
		where ename='smith'
	)
--42�г����й�Ա����������ֱ���ϼ�������
select a.ename as ����,b.ename as �ϼ�����
from emp a
join emp b
on a.mgr=b.empno

select a.ename as ���� ,(select b.ename from emp b where a.mgr=b.empno) as ֱ���ϼ�
from emp a

--43 �г���ְ����������ֱ���ϼ������й�Ա
--select * from emp

select a.* 
	from emp a
	join emp b 
	on a.mgr=b.empno
	where a.hiredate<b.hiredate

--44.�г����а���Ա('clerk')���������䲿������	
select ename as ����,dname as ��������
	from emp 
	join dept
	on emp.deptno=dept.deptno
	where emp.job='clerk'

--45.�г�����'sales'(����)�����Ĺ�Ա������,�ٶ���֪�����۲��Ĳ��ű��
select * from emp
	where job ='salesman'

--46.�г���'scott'������ͬ���������й�Ա
select * from emp
	where job =
	(select job from emp
	where ename='scott')

select a.* 
	from emp a
	join emp b 
	on a.empno!=b.empno
	where b.ename='scott' and a.job=b.job	
--47.�г�ĳЩ��Ա��������н��,���������ǵ�н����ڲ���30���κ�һ����Ա��н��
select ename as ����,sal as н��
	from emp
	where sal>
	(
		select min(sal) from emp
		where deptno=30
	)

--48.�г�ĳЩ��Ա��������н��,���������ǵ�н����ڲ���30�����й�Ա��н��
select ename as ����,sal as н��
	from emp
	where sal>
	(
		select max(sal) from emp
		where deptno=30
	)
--49.�г�����ͬһ�ֹ��������ڲ�ͬ���ŵĹ�Ա�Ĳ�ͬ���
select a.ename ,b.ename
	from emp a 
	join emp b 
	on a.empno!=b.empno
	where a.job=b.job
	and a.deptno!=b.deptno
	order by a.ename
--50.�г����й�Ա������,�������ƺ�н��	
select ename as ����,dname as ��������, sal as н��
	from emp 
	join dept
	on emp.deptno=dept.deptno
	