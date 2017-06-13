[TOC]
# 1.GitLab 常见问题

## 1.1 为何上传头像失败
修改配置文件：

```swift
 cat /etc/gitlab/gitlab.rb，找到external_url把其域名修改成ip就可以
```
![](media/14972341307238.png)

## 1.2 为何复制出来的git 地址是带域名的？然后自动添加到git管理器会失败
如图问题一修改配置就可以

## 1.3 gitlab 如何配置腾讯企业邮件
配置邮件的方法：https://docs.gitlab.com/omnibus/settings/smtp.html
记住修改脚本的时候，删除# 后不能前面留空格，其余按照教程做就可以
有一点必须注意：from 哪里必须写你发送邮件的邮件名称，然后用最后的测试发送邮件的方法测试发送邮件
配置：
![](media/14972341394374.png)

命令汇总：

```swift
vi /etc/gitlab/gitlab.rb
gitlab-ctl reconfigure
gitlab-rails consoleNotify.test_email('yelu@thinkive.com', 'Message Subject', 'Message Body').deliver_now
```
效果：
![](media/14972341483251.png)

## 1.4 gitlab 修改readeMe成base64 以后project都访问不了
打开project
![](media/14972341653176.png)

选中ReadMe，然后删除就可以了
![](media/14972341759020.png)


## 1.5 gitlab 如何查看版本：
需要登录以后才能查看：http://192.168.1.63/help，在首页

![](media/14972341844147.png)



## 1.6 如何关联邮箱

```swift
vi /opt/gitlab/embedded/service/gitlab-rails/config/gitlab.yml
```
8.1.7.0 以后的版本取消了默认要求注册邮箱
https://gitlab.com/gitlab-org/gitlab-ce/blob/master/CHANGELOG.md


![](media/14972341951188.png)

---
* Tips:

需要开启send confirmation email的功能才能收到注册邮件，需要关注project才能收到issues的邮件通知
![](media/14972342053337.png)
![](media/14972342120406.png)



## 1.7 gitlab如何备份和还原？
http://blog.csdn.net/qwer026/article/details/52066474

自动备份地址：

```
/var/opt/gitlab/backups
```
设置自动备份：

```
sudo su -
crontab -e
// 这里设置是1点01分自动备份
1 1 * * * /opt/gitlab/bin/gitlab-rake gitlab:backup:create
```

## 1.8 gitlab 如何取消owner 权限

进入project menber，里面有个是否是owner的权限。


## 1.9.gitlab 有时候会报403 forbidden的错误
可以直接切换网络
可以修改gitlab的安全策略：

https://stackoverflow.com/questions/35994601/how-to-turn-off-rack-attack-in-gitlab-ce-omnibus/37437881#37437881

【gitlab使用】--gitlab-ce并发超过30引起ip被封
http://chuansong.me/n/2629829


## 1.10 gitlab 弄好以后sourceTree 连接会一直要求输入账号密码：
终端输入如下指令：把你的key添加到钥匙串中

```
ssh-add -K ~/.ssh/id_rsa_gitLab
```

## 1.11 gitlab 如何定时删除备份
没有找到，目前只能够手动删除

