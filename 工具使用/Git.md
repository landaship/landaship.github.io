# 1.Git如何和之前的版本做比较？
如我当前版本10，我要和5版本比较，怎么做？

比较当前的文件和那个文件之间的差异

```
git diff 你要比较的版本号 -- 文件名称
git diff c2a2850 -- Git.md
```
比较某某版本跟某某版本区别则再加一个版本号

```
git diff 你要比较的版本号1 你要比较的版本号2 -- 文件名称
git diff 16jdga5 c2a2850 -- Git.md
```

输出,其中加号部分为添加了的内容,但是这个看起来很不舒服，特别是改动很大的情况下，产生的差异特别多，不知道怎么看了。

```log
diff --git "a/\345\267\245\345\205\267\344\275\277\347\224\250/Git.md" "b/\345\267\245\345\205\267\344\275\277\347\224\250/Git.md"
index 718fdab..8db45b1 100644
--- "a/\345\267\245\345\205\267\344\275\277\347\224\250/Git.md"
+++ "b/\345\267\245\345\205\267\344\275\277\347\224\250/Git.md"
@@ -1,3 +1,11 @@
 # 1.Git如何和之前的版本做比较？
 如我当前版本10，我要和5版本比较，怎么做？
 
+
+# 2.
+
+
+# 3.
+
+# 4.
+
```

# 2.如何添加sshkey
创建Project

1.创建SSH Key：（http://192.168.1.63/help/ssh/README）
1.1 检查是否生成过pub文件，如果存在则不需要创建了。
命令：cat ~/.ssh/id_rsa.pub  ，（文件名可以有多种：id_dsa.pub，id_ecdsa.pub，id_ed25519.pub）
如果文件存在则提示：

![F58F4D8A-37EC-4521-99CE-A66323B1186](media/F58F4D8A-37EC-4521-99CE-A66323B1186C.png)

文件不存在：
![1CB5CCD5-D8C2-43E2-9333-F37BDEB76972](media/1CB5CCD5-D8C2-43E2-9333-F37BDEB76972.png)

1.2 创建一个key pair
 命令：ssh-keygen -t rsa -C "yelu@thinkive.com" -b 4096
说明：
1.your.email@example.com 为你公司邮箱的名字，如yelu@thinkive.com
2.key pair路径哪里按照他的提示的默认路径输入，这样就不需要单独配置key pair路径了（/Users/yelu/.ssh/id_rsa）
![22978831-4A3C-4788-839C-F2BFC42AB12D](media/22978831-4A3C-4788-839C-F2BFC42AB12D.png)

1.3 拷贝 SSH key到剪贴板：
pbcopy < ~/.ssh/id_rsa.pub

1.4 拷贝key到gitlab配置栏
![DAC69D85-E6C8-4E10-BB2B-67585F0CED](media/DAC69D85-E6C8-4E10-BB2B-67585F0CEDC4.png)

1.5 检测key 是否生效
ssh -T git@192.168.1.63
如果生效会提示：
yeludeMacBook-Pro:.ssh yelu$ ssh -T git@192.168.1.63
Enter passphrase for key '/Users/yelu/.ssh/id_rsa': 
Welcome to GitLab, 叶璐!


1.ssh Key干什么用的？为什么要传到gitlab上做配置？配置完了以后是不是所有人都可以clone？配置多份ssh key（多邮箱）会不会有问题？
1.用来做免密码登录的
2.sshkey相当于公钥，用来做rsa加密的
3.不是所有人都可以clone，必须是跟服务器配置了sshkey才可以，换一台电脑需要再生成一个sshkey,tower 就是有问题，不知道为何，sourceTree可以
4.配置多份sshKey没有关系，可以任意配置多个站点的

2.Git Submodules是干嘛用的？我们不需要使用

用来做依赖的版本管理的，跟cocoaPods功能一样，只不过cocoaPods是用于ObJectC的

https://www.git-tower.com/blog/introducing-git-submodules-in-tower/

介绍：
http://www.open-open.com/lib/view/open1396404725356.html

3.为何tower只能添加root账号，不能添加我的子账号Louis？

4.如何让自己代码支持cocoaPod
http://www.cnblogs.com/zhanggui/p/6003481.html
 如何cocoaPod管理三方源码
http://code4app.com/article/cocoapods-install-usage

5.Xcode7自带Git创建的项目"Couldn’t communicate with a helper application."    
在终端命令行输入以下两行指令即可解决：
xcrun git config --global user.email xxxx--->你的git邮箱📬
xcrun git config --global user.name xxxx--->你的git用户名 

