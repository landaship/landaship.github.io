# 1.cornerstone   详细介绍：http://www.jianshu.com/p/9ff1fbca8106

1.解决看不了日志的问题（ Cound not contact repository to read the latest log entries. The log displayed meb be incomplete.）
http://stackoverflow.com/questions/21183182/mac-cornerstone-could-not-contact-repository-to-read-the-latest-log-entries



解决svn冲突的办法 =====

1。其实避免的冲突最好的办法就是: 项目人在配合工作的时候，彼此之间很好的交流(我们都是面对面坐着)
作者:禚来强   原文地址: http://blog.csdn.net/diyagoanyhacker/article/details/6787509

2。当出现冲突的时候，svn会生成三个临时文件

              1.filename.mine 存储者本地的修改过的文件。

              2.filename.rOLDREV 存储者上次update的基础版本文件

              3.filename.rNEWREV 存储着客户端刚从服务器上接收来的版本。



3。当遇到冲突的时候有3种方法解决冲突

              1.手动合并代码，解决冲突。

              2.选择一个冲突出现时产生的临时文件来覆盖当前文件。

              3.运行svn resolved filename 命令来放弃当前文件的本地的所有修改。



4。一旦你解决了文件的冲突(手动合并代码)，另一件要做的事情是运行 svn resolved filename 命令,告诉svn你已经解决了冲突，svn会去删除3个临时文件



5。手动合并代码



<<<<<<<<<<<<<<.mine



ab

cd



============

ef

hi

>>>>>>>>>>>>>>>>.r2

从<<<<<<<<<<<<<<.mine到============是你在冲突区做的修改

从============到>>>>>>>>>>>>>>>>.r2是服务器版本在冲突区做的修改

然后我们修改为

ab

cd

ef

hi



然后运行 svn resolved filename。

手动合并代码完成。



7。利用生成三个文件解决冲突

1）svn checkout   test.m

            C    test.h

可以看到test.h有冲突。

2）ls -a test.h*

             test.h.mine

             test.h.r1

             test.h.r2

可以看到生成了三个临时文件

3）cp test.h.r1 test.h

4)svn resolved test.h 



8。使用svn revert解决冲突

1）svn upldate test.h

           C test.h

2)svn revert test.h

3)ls -a test.h*

      test.h

    可以发现用revert解决冲突后，生成的三个临时文件也没有了，所以不需要运行 svn resolved test.h。



9。提交修改给版本库(svn ci)

1)svn commit  test.h -m "add code"



10。检查项目版本历史(svn log, svn diff, svn cat, svn list)

1)svn log       提供指定版本的创建者，日期，修改路径等。

2)svn diff       显示特定修改的行级信息

3)svn cat       取得特定版本的文件显示在屏幕上

4)svn list       显示一个目录在特定版本存在的文件



11。查询历史版本修改列表

1) 


# 1.3 svn upgrade 后获取不到最新的日志 （svn log）
需要再svn update就可以了

#1.4 svn 如何查看tag
svn打tag其实就是copy一个分支。。。感觉好low


