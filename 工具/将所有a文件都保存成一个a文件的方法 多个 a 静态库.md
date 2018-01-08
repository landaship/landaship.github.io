# lipo -create -arch i386 i386/libavcodec.a -arch armv6 armv6/libavcodec.a -arch armv7 armv7/libavcodec.a -output universal/libavcodec.a

lipo -create -arch i386 i386/libavcodec.a -arch armv6 armv6/libavcodec.a -arch armv7 armv7/libavcodec.a -output universal/libavcodec.a

许多第三方提供的.a文件（一般是那些SDK），嵌入到我们的xcode项目后，生成不会报错。
 
一部分粗心的SDK提供方，或者我们自己做的.a文件，就会有报错，常见的就是不是armv7结构，或者不是armv7s结构，如果在模拟器中运行，会报不是i386结构。
 
原因是：armv7是支持比iphone5旧的那些设备，armv7s是iphone5或ipad4或者以后的新设备，i386是mac的。
 
这些名字指的是处理器所用的指令集。
 
因此常常发生的是.a文件要么ipad mini可以Build成功，但iphone5不能Build成功。要么就相反，让人抓狂。
 
解决办法是做一个全面支持各指令集的.a文件。
前提是分别生成3个支持对应指令集的.a文件。在Build静态库时，设备分别选择不同的真机以及模拟器，分别Build出来，备份到一个文件夹，并且取不同的名字。
 
此时可以用命令来检查导出的.a文件所支持的指令集，lipo -info XXX.a ，要保证3个都是不同的才能进行下一步 ，注意：armv7s的显示名是cputype (12) cpusubtype (11)
 
然后以命令 lipo -create XXXX_V7.a XXXX_V7s.a -output XXXX_all.a 合成他们成为新的.a文件。
 
最后替换掉报错的.a文件即可。 

