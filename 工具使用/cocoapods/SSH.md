# SSH 公钥跟邮箱有什么关系？
ssh-keygen -t rsa -C "yelu@thinkive.com" -b 4096
没有什么关系，-C 只是一个comment，设置注释的，也可以说是标识吧，方便你区分多个公钥

# ssh-keygen 命令的作用？
生成一个公钥（id_rsa.pub）还有一个私钥（id_rsa）

# git 有SSH和http的方式，为何SSH可以不用密码？http用了密码是要登录远程主机么？但是http用的密码是登录gitlab服务器的gitlab账号，这个跟登录服务器是一回事么？
http的需要输入账号密码
ssh的不需要输入，原因就是因为用ssh协议。

# 如何添加ssh key
创建Project

1.创建SSH Key：（http://192.168.1.67/help/ssh/README）
```
ssh-keygen -t rsa -C "yelu@thinkive.com" -b 4096
```
代码参数含义： 
-t指定密钥类型，默认是rsa，可以省略。 
-C设置注释文字，比如邮箱。 
-f指定密钥文件存储文件名。

1.3 拷贝 SSH key到剪贴板：
pbcopy < ~/.ssh/id_rsa.pub

# 有多对SSH key时如何处理？
如果只有一个SSH key，我们不需要处理什么就能正常的push、pull，如果有多个了，就会提示你你的某个git目录不能push、pull了，这个时候需要做添加私钥的处理。

添加私钥
```
ssh-add 私钥路径
例：
$ ssh-add ~/.ssh/id_rsa_github
```

> ssh-add命令是把专用密钥添加到ssh-agent的高速缓存中
 
查看是否添加成功

```
ssh-add -l
结果：
2048 SHA256:ueU7NSaLTzfKNMKL3EVkBKqK2/bvr/ewdNVTmBYZtxg /Users/YourName/.ssh/id_rsa_github (RSA)
```

删除：

```
ssh-add -d 私钥路径
```


参考资料：
http://man.linuxde.net/ssh-add
https://www.cnblogs.com/ppforever/p/4914914.html


