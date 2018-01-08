# 1.UDID
     在ios5 以后被苹果废弃
2.网卡地址
     在ios7 以后被废除
3.IMEI 不可以直接读取，官方禁止获取
4.广告标识符是目前官方认可的方法，但是还是可以重新生成新的ID
http://kensou.blog.51cto.com/3495587/1249734


目前公司用的方案是：用UDID ＋ keyChain 方法解决
http://www.jianshu.com/p/7ad22ca88b83

 NSString *uuid1 = [[NSUUID UUID] UUIDString
];
    
CFUUIDRef uuid = CFUUIDCreate(NULL
);
    
assert(uuid != NULL
);
    
CFStringRef uuidStr = CFUUIDCreateString(NULL
, uuid);
    
NSLog(@"%@", uuidStr);

公司方法：调用50022 插件

