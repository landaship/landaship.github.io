# 数据库Demo：http://blog.cocoachina.com/article/47277


sqlite 语法  参考教程：http://www.runoob.com/sqlite/sqlite-drop-table.html

1.如何修改表格中的列名称，如我有一个列叫City要改成Country 怎么处理？
          SQLite 仅仅支持 ALTER TABLE 语句的一部分功能，我们可以用 ALTER TABLE 语句来更改一个表的名字，也可向表中增加一个字段（列），但是我们不能删除一个已经存在的字段，或者更改一个已经存在的字段的名称、数据类型、限定符等等。 
2.如何修改表名称
          改变表名 - ALTER TABLE 旧表名 RENAME TO 新表名 
3.如何删除表中的某一列（字段）？
     原来SQLite目前还不支持drop column，也就是不支持直接删除表中的字段
4.添加一列
      - ALTER TABLE 表名 ADD COLUMN 列名 数据类型 
5.什么时候会用到多线程？
6.如何多线程大量打开和关闭数据库？
7.宝哥的框架中为何不用createTable来建表而是用updateTable来建表？
8.自动生成建表语句的sql工具？
9.levelDB和CoreData存储的比较？
10.归档主要用在什么环境？
11.沙盒里的数据哪些是会被备份的？哪些是会被清空的？
12.宝哥sql工具跟FMDB比较，据说是在多线程和写数据库语句方面比较节省时间？


