# 1.SSH 公钥跟邮箱有什么关系？
ssh-keygen -t rsa -C "yelu@thinkive.com" -b 4096
没有什么关系，-C 只是一个comment，设置注释的，也可以说是标识吧，方便你区分多个公钥

# 1.ssh-keygen 命令的作用？
生成一个公钥（id_rsa.pub）还有一个私钥（id_rsa）

# 3.git 有SSH和http的方式，为何SSH可以不用密码？http用了密码是要登录远程主机么？但是http用的密码是登录gitlab服务器的gitlab账号，这个跟登录服务器是一回事么？
http的需要输入账号密码
ssh的不需要输入，原因就是因为用ssh协议。

ssh免密登录原理
RSA介绍：[RSA算法详解](http://www.guideep.com/read?guide=5676830073815040#)通俗易懂的介绍了RSA的来龙去脉，但是看完后还是一脸懵逼
最笨的总结方法：RSA算法创造了一对双胞胎小明跟小强，根据算法，小明是公共人物（公钥），小强是通过算法算出来的（但是不能通过小明反算出小强来，只有造物者知道小强是怎么算出来的），此时小强就是私钥。所谓加密就是你传送的指令用小明加密了，到了接手方以后让小强就能解出来。

有了这个基础之后才可以说SSH免密登录
1.先创建一对钥匙串PK（公钥），SK（私钥），命令ssh-keygen -t rsa -C "yelu@thinkive.com" -b 4096
2.有了这对活宝以后，把PK放到GitLab或者GitHub上去，此时，服务器的authorized_keys中便包含了你这个公钥
3.当客户端想免密登录的时候，客户端会发起一个登录请求，包括了自己的用户名和iP
4.服务器收到这个请求后就会去authorized_keys查找是不是有你这个可信任的公钥，如果有，他就生成一个随机数，并把这个随机数用公钥加密发送给客户端
5.客户端收到这个消息后用私钥解密，然后发送这段随机数明文发送给服务器
6.服务器收到信息后校验如果一致则放行登录
所以免密登录其实并不是记住密码，而是一种认证机制而已

[流程图](https://www.processon.com/diagraming/5b8ea36be4b0fe81b62610d7)
参考资料：https://blog.csdn.net/qq_26907251/article/details/78804367

# 4.如何添加ssh key
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

# 5.有多对SSH key时如何处理？
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





