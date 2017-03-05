--查看备份文件的逻辑文件名
restore filelistonly from disk ='E:\huayiLast\HengRong.bak'
--还原数据库
restore database HengRong from disk ='E:\huayiLast\HengRong.bak'
with recovery,
Move 'QinYingDB' to 'D:\Project_2\HengRong.mdf',
Move 'QinYingDB_Log' to 'D:\Project_2\HengRong_log.ldf'

--分离数据库
exec sp_detach_db   @dbname='HengRong'
--附加数据库
exec sp_attach_db @dbname='HengRong',@filename1='D:\Project_2\HengRong.mdf',@filename2='D:\Project_2\HengRong_log.ldf'
