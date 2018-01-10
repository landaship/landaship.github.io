# 在项目开发中遇到了这样一种情况：
需要用一个干净的工程（export出来的，没有svn信息）去覆盖一个主干的工程（含有svn信息），然后提交代码；我们在mac系统中拷贝－>粘贴到目标文件夹，只有2个选项：停止和全部替换；选择全部替换后，svn信息全部丢失了。

这时我们可以使用cp -r dir1 rootdir 来进行覆盖，dir1是那个干净工程的文件夹路径，和主干工程同名；rootdir是主干工程的上级目录，如此一来我们就实现了保留svn信息前提下覆盖文件夹的目的。


原文：http://blog.csdn.net/openglnewbee/article/details/25030597

实际使用：cp -r /Users/yelu/SVN代码管理/光大综合99SVN/TKApp/TKApp/* ./

