# Podfile 参数解析
## 1.1 什么是CocoaPods？
简单的说是方便我们管理代码依赖，这个代码可以是三方的也可以是自己的，也就是说是不归这个代码仓库管理的代码。

CocoaPods是专门为iOS工程提供对第三方库的依赖的管理工具，通过CocoaPods，我们可以更方便地管理每个第三方库的版本，而且不需要我们做太多的配置。直观、集中和自动化地管理我们项目的第三方库。

## 1.2 CocoaPods 的原理是什么？
就是用他的一个xproject 工程生成一个静态.a 文件，然后主工程引用他生成的静态库，实现的自动编译，子工程中的代码修改是没有效果的，这样可以防止别人修改自己的代码。

## 1.3 如何使用CocoaPods
### 1.3.1 在project同级目录下生成Podfield文件
### 1.3.2 添加Pod索引
### 1.3.3 pod install

1.安装常遇到的问题

2017 年的，系统10.12.6 亲测有效
http://www.jianshu.com/p/4daa1a8965d8
    
# 2. cocoapod 的原理


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

# 1.修改淘宝源：gem sources -a https://ruby.taobao.org/
改成了https
2.install的时候报错
AppledeMacBook-Pro:~ Louis$ sudo gem install cocoapods
Password:
ERROR:  While executing gem ... (OpenSSL::SSL::SSLError)
    hostname "gems.ruby-china.org" does not match the server certificate

解决办法：换源 gem sources -a http://gems.ruby-china.org/

