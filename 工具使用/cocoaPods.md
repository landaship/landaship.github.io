# 1.安装常遇到的问题

2017 年的，系统10.12.6 亲测有效
http://www.jianshu.com/p/4daa1a8965d8
    
# 2. cocoapod 的原理
就是用他的一个xproject 工程生成一个静态.a 文件，然后主工程引用他生成的静态库，实现的自动编译

# 3.外网的人如何使用我们的cocoapod？如何更新我们的框架？

#4. 如何搭建本地?
在Podfile里指定里你的spec路径，这个路径是放在你本地的话，访问的就是本地的，我们需要做的是搭建局域网的，所以要放在一个局域网的http服务器上。
spec 弄好了之后就是配置spec文件了，这个文件就是pod索引

#5. 要引入三方库如何做？

# 6. pod install 和pod update 区别？
http://www.jianshu.com/p/a977c0a03bf4

pod install 只会添加或者删除新添加的pod库文件，不会更新其他已经存在的
pod upate 会更新所有的，所以一般pod update 后面需要加上其他的需要更新的版本号

# 7.xcworkspace 的作用
多个工程的管理，可以用来调试Framework
# 8.pod repo 是干嘛的？

# 9.更换那个源跟提高速度有什么关系？
# 10.为何没有提到本地库如何做？


pod repo add TKSharePlugin git@192.168.1.67:Louis/podSpec.git
http://192.168.1.67/Louis/podSpec.git
source 'git@192.168.1.67:Louis/podSpec.git' 

解决cocoaPod 慢的问题
http://blog.csdn.net/nn955/article/details/53043482

出现：出现 [!] To setup the master specs repo, please run pod setup.
解决办法：自己去下载然后拷贝到~/.cocoapod/目录下,也可以用命令去下载
git clone https://git.coding.net/CocoaPods/Specs.git ~/.cocoapods/repos/master


测试Spec 是否管用****
pod lib lint 

