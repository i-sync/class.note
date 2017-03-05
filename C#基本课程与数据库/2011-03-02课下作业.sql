---创建存储过程,用于选取分页
--方法1 不可行
create procedure proc_pagination
	@pagesize int = 10,
	@pageindex int =1,
	@ordercondition nvarchar(20),
	@primarykey nvarchar(20)
as
	select top @pagesize * from orders
	where @primarykey not in
	(
		select top (@pageindex-1)*@pagesize  @primarykey 
		from orders
		order by @ordercondition
	)
	order by @ordercondition
go		
--方法2
drop procedure proc_pageination

create procedure proc_pageination
	@pagesize int = 10,
	@pageindex int =1,
	@ordercondition nvarchar(20)
as
	select * from 
	(
	select row_number() over (order by @ordercondition) as rownumber,* 
	from products
	) as newtable
	where rownumber between (@pageindex-1)*@pagesize+1 and @pageindex* @pagesize
go	

use northwind

exec proc_pageination 10,3,productname

--为northwind数据库中添加存储过程,要求获取orders表中
--shippeddate为空,且requiredate在当前日期以前的订单的详细信息
create procedure proc_ordersinfo
as
	select * from orders
	where shippeddate is null	
	and requireddate>getdate()
go	

exec proc_ordersinfo

--修改以上的存储过程,要求:只获取部分字段,
--即requireddate,orderdate,orderid,customerid,employid
alter proc proc_ordersinfo
as
	select requireddate,orderdate,orderid,customerid,employeeid
	from orders
	where shippeddate is null
	and requireddate> getdate()
go	
exec proc_ordersinfo

--删除存储过程
drop proc proc_ordersinfo