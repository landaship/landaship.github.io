# 1.修改淘宝源：gem sources -a https://ruby.taobao.org/
改成了https
2.install的时候报错
AppledeMacBook-Pro:~ Louis$ sudo gem install cocoapods
Password:
ERROR:  While executing gem ... (OpenSSL::SSL::SSLError)
    hostname "gems.ruby-china.org" does not match the server certificate

解决办法：换源 gem sources -a http://gems.ruby-china.org/

