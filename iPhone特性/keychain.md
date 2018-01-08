# 宝哥这边提供的方法是TKSSKeychain.h

苹果官方推荐的方法是：keychainItemWarpper，但这个是MRC的

有个三方的方法：SFHFKeyChainUtils

这个的用途是让用户把当前的关于app的一些设置，如UDID，游客登录的ID等缓存起来，无论你是否删除app，这个app都会存在。

具体用法：参考：TKSSKeychain.h
相关知识介绍：http://www.jianshu.com/p/6bc772bdeece

