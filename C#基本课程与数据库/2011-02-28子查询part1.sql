use northwind
go

--内联接
select top 100 orderid ,customers.customerid, companyname,orderdate 
from customers
inner join orders
on customers.customerid=orders.customerid


--外联接
select orderid,customers.customerid,companyname,orderdate
from customers
left outer join orders
on customers.customerid=orders.customerid
where orderdate >'1998-5-1'


--多表联接
select top 10 productid,productname,categoryname,companyname
from products
join categories
on products.categoryid=categories.categoryid
join suppliers
on products.supplierid=suppliers.supplierid
where categoryname like 'C%'

select distinct (customerid) from orders
select distinct (o1.customerid)
from orders o1
join orders o2
on o1.customerid=o2.customerid
where o1.orderid!=o2.orderid



--分布SQL
--每而多少条
--当前第几页
--需求:每在页显示10条数据,显示第3页的数据
--第一种解决方案:如果表有编号列,使用where between ... and...
--第二种解决方案:
--1.想选取前10条,得用top,但是问题是top只能从第一条开始
--2.可以获取前20条,但前20条 我不要,也就是,去掉前20条
--3.使用子查询
select top 10 *
from orders
where orderid not in
(
	select top 20 orderid
	from orders
)

/*
分页的实现

declare @pageSize int
declare @pageIndex int 
declare @condition nvarchar(30)
select @pageSize =10,@pageIndex = 3,

create function page(@pageSize,@pageIndex,@condition)
returns 
begin
	return
	select top @pageSize * 
	from orders
	where 条件 and orderid not in
	(
		select top (@pageIndex-1)*@pageSize orderid
		from orders 
		where 条件
		order by @condition
	)
	order by @condition	
end

*/

select top 100 row_number() over (order by orderdate) as rcount,* 
from orders

select top 100 row_number() over (order by customerid) as rcount,*
from orders

--分页
select *
from(
	select row_number() over(order by orderdate) as rcount,* 
	from orders	
	)         --把子查询作为一张表 
	as Ranks  --必须起别名
where rcount between 21 and 30
order by orderdate	




--用子查询找出customers表和orders表中的orderid,customerid,orderdate,companyname
select orderid,customerid,orderdate,
	(select companyname from customers c
	 where c.customerid=o.customerid) as companyname
from orders o
--用表联接查询
select orders.orderid,orders.customerid ,companyname ,orderdate 
from orders
join customers
on orders.customerid= customers.customerid


use northwind
go


--2011-03-01练习
--按每页10条数据,选择第3页的所有数据

select top 10 * from orders
where orderid not in 
(
	select top 20 orderid 
	from orders 
)
select top 30 * from orders


--添加一个编号
select row_number() over(order by orderid) as rcount ,* from orders

select * from 
(
	select row_number() over (order by orderid) as rcount,* from orders
) as ranks
where rcount between 21 and 30
order by orderid

create table a 
(
	id int not null,
	name nvarchar(20) not null,
	sex nvarchar(20)
)

create unique clustered 
	index index_id
	on a(id)
drop index a.index_id
