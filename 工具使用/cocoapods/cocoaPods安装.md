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
 ```
 sudo gem install -n /usr/local/bin cocoapods --pre
 ```
 
### 3.1 验证是否安装成功
```
pod search AFNetwork
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

解决办法：换源 gem sources -a http://gems.ruby-china.org/
```

