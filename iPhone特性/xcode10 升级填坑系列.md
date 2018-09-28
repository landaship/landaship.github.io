# 1. library not found for -lstdc++.6.0.9

解决办法：https://forums.developer.apple.com/message/314346#314346

从老的xcode中拷贝libstdc++.6.0.9.tbd到新xcode路径中,但是这种方法只能适用于真机，模拟器不可以用了：

```
/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/lib/libstdc++.6.0.9.tbd
```


参考资料：https://juejin.im/post/5b1634f0f265da6e61788998


