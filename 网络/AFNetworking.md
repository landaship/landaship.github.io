# AFNetworking使用总结   

【奖】CocoaChina首届晒优秀模块活动开始啦~~快来秀一秀你霸气的模块~
* 分享类型：游戏开发相关
1 将AFNetWorking文件夹导入项目 

 

2 添加类库 Security.framework、MobileCoreServices.framework、SystemConfiguration.framework 

3 在使用的地方  #import "AFNetworking.h" 

 

 

解决编译时警告： 

 

Prefix.pch文件中加入 

#import <SystemConfiguration/SystemConfiguration.h> 

#import <MobileCoreServices/MobileCoreServices.h> 

 

 

注：AFNetWorking使用了ARC ，在不使用ARC项目中使用时，对AFNetWorking的所有.m文件添加“-fobjc-arc” 

    在使用ARC项目中，使用“不使用ARC”的类库时，对类库的.m文件添加“-fno-objc-arc” 


  

