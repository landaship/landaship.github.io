# CocoaPods 安装
## 1 检查你的ruby源
```
gem sources -l
```
默认情况是

```
*** CURRENT SOURCES ***
https://rubygems.org/
```
## 2 替换源
https://rubygems.org/ 这个源需要翻墙才能访问，所以要更换成ruby中国的源
### 2.1 移除旧源
```
gem sources --remove https://rubygems.org/
```

## 2.2 添加新的源地址
```
gem sources -a http://gems.ruby-china.org/
```

## 2.3 检查源地址正确
```
 gem sources -l 
```
 
 
## 3.安装cocoapod
由于Mac OS X 10.11 El Capitan用户，由于系统启用了SIP(System Integrity Protection), 导致root用户也没有权限修改/usr/bin目录。所以安装cocoaPod的时候需要指定一下安装路径 
 ```
 sudo gem install -n /usr/local/bin cocoapods --pre
 ```
 Tips:gem help install -> -n 是指定安装路径的意思
 
### 3.1 验证是否安装成功
```
pod search AFNetwork
```

### 4初始化pod
### 4.1 从https://gitclub.cn/CocoaPods/Specs.git 上下载最近的索引到~/.cocoapods/repos 目录

```
git clone https://gitclub.cn/CocoaPods/Specs.git ~/.cocoapods/repos/master
```
git.coding.net/CocoaPods/Specs.git 这个镜像已经不可以用了
> 作者在ReadMe里说的

```
由于码市官方限制，本项目停止更新，详见：https://coding.net/u/coding/p/Coding-Feedback/topic/298997

我已将项目迁移到阿里云，如有需要请使用下面的源(每小时更新)：
* https://code.aliyun.com/Magi/CocoaPods.git   
* https://gitclub.cn/CocoaPods/Specs.git `推荐`
```
### 4.2 初始化pod
pod setup

虽然躲过了拷贝的一难，但是还是花了不少其他的时间
```
Louis:repos Louis$ pod setup
Setting up CocoaPods master repo
  $ /usr/bin/git -C /Users/Louis/.cocoapods/repos/master fetch origin --progress
  remote: Counting objects: 207169, done.        
  remote: Compressing objects: 100% (135/135), done.        
  remote: Total 207169 (delta 30350), reused 30311 (delta 30311), pack-reused 176718        
  Receiving objects: 100% (207169/207169), 69.17 MiB | 47.00 KiB/s, done.
  Resolving deltas: 100% (139898/139898), completed with 7303 local objects.
  From https://github.com/CocoaPods/Specs
     9111217530c..06bf69a78a5  master                -> origin/master
   * [new branch]              backz                 -> origin/backz
   * [new branch]              swift_version_support -> origin/swift_version_support
  $ /usr/bin/git -C /Users/Louis/.cocoapods/repos/master rev-parse --abbrev-ref HEAD
  master
  $ /usr/bin/git -C /Users/Louis/.cocoapods/repos/master reset --hard origin/master
  Checking out files: 100% (16552/16552), done.
  HEAD is now at 06bf69a78a5 [Add] bongSDK 4.8.3
warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your diff.renameLimit variable to at least 16049 and retry the command.
Setup completed
Louis:repos Louis$ 
```

> pod setup 作用
 
```swift
 pod setup --help
 
 Creates a directory at `~/.cocoapods/repos` which will hold your spec-repos.
      This is where it will create a clone of the public `master` spec-repo from:

          https://github.com/CocoaPods/Specs

      If the clone already exists, it will ensure that it is up-to-date.
```
### 4.3 如果初始化过了就直接pod repo update即可


## 5.pod repo 命令
> pod repo remove 

改命令会删除~/.cocoapods/repos 目录下的对应的仓库，如果仓库没有会提示你不存在，如果存在

> pod repo add name名字 git路径

会从git clone 一份你指定的东西到~/.cocoapods/repos目录下，并用name作为仓库（repos）名字,实际上他执行的就是clone命令

> pod repo

查看所有的仓库（repos）信息

```
Louis:test Louis$ pod repo

master
fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
- Type: git (unknown)
- URL:  https://gitclub.cn/CocoaPods/Specs.git
- Path: /Users/Louis/.cocoapods/repos/master

test
- Type: git (master)
- URL:  git@192.168.1.67:Louis/777777.git
- Path: /Users/Louis/.cocoapods/repos/test

testdddd
- Type: git (master)
- URL:  git@192.168.1.67:Louis/777777.git
- Path: /Users/Louis/.cocoapods/repos/testdddd
```

# FAQ 
## 1. 出现：出现 [!] To setup the master specs repo, please run pod setup.
```
解决办法：自己去下载然后拷贝到~/.cocoapod/目录下,也可以用命令去下载
git clone https://git.coding.net/CocoaPods/Specs.git ~/.cocoapods/repos/master
```

## 2.install的时候报错
```
AppledeMacBook-Pro:~ Louis$ sudo gem install cocoapods
Password:
ERROR:  While executing gem ... (OpenSSL::SSL::SSLError)
    hostname "gems.ruby-china.org" does not match the server certificate

解决办法：换源 上面的换源的方法
```

