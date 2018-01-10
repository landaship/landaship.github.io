# safari
插件有两种类型：WebKit–Based Plug-ins和Netscape-Style Plug-ins。但是在safari5.1以后的版本WebKit–Based Plug-ins类型的插件就被舍弃了，主要原因是因为该类型的插件缺乏安全性。而Netscape-Style Plug-ins插件使用的是firfox开发的插件库，苹果进行了封装，该类型的插件有一个好处就是跨浏览器，可以运行在safari，firfox
等主流的浏览器中


dmg 结尾的文件如何生成？
     用app2Dmg 这个apppkg和dmg有什么区别？
      pkg相当于win下面的大型安装包，比如大型的micoffice软件，这种软件一般需要注册，而且安装时需要机主的权限。

       dmg
相当于win下面的rar压缩软件包。当然mac也能解压rar
软件，很多都可以直接解压，然后拖到你需要的地方使用。

dmg里怎么装进去pkg的，那个软件只支持app的呢？


将需要打包的pkg放入到一个文件夹中，打开，磁盘工具，选择“文件”－》“新建映像”－》“来自文件夹到映像”，然后选择你的文件夹，然后确定就可以

如何生成pkg？
     用IceBerg



如何不带界面？

如何获取到键盘事件？

用OC可以编程么？
可以


浏览器扩展和插件有什么区别？
      插件用于跟系统交互
      扩展用于浏览器功能扩充


How can I install files into the Library folder of the current user?
Packages are not the best solution to install files in the home directory of the current logged user.
Yet
, it's possible to work around this if you wish the user does not have to choose the destination folder (him|her)
self.
Note: This solution only works if the all the files are to be installed in the home folder of the current user.
1Open Iceberg.
2Choose File > New Project… .
3Select the Core Template > Package template and click Next.
4Type the name of the project in the Project Name text field and click Finish.
5Choose View > Settings.
6Check the following options Root Volume Only
,
 Overwrite Directory Permissions and Follow Symbolic Links.
7Choose View > Scripts.
8Open TextEdit and type the following text in the new document:
#!/bin/sh

ln -s /private/tmp/CurrentUser/NetscapeCoreAnimationMoviePlugin.plugin $HOME/Library/Internet\ Plug-Ins 

exit 0
9Choose File > Save.
10Save the document in your Iceberg project folder under the name ScriptPreflight.txt and quit TextEdit.
11Select the line named preflight in the Installation Scripts table and click on Choose… .
12Select the ScriptPreflight.txt file and click Choose.
13Check the checkbox for the preflight row.
14Choose View > Files.
15Select the / folder.
16Choose Archive > Show Info.
17Choose Archive > New Folder.
18Set the name of the folder to private
,
 choose wheel from the Group pop-up menu and set the permissions to drwxr-xr-x.
19Choose Archive > New Folder.
20Set the name of the folder to tmp
,
 choose wheel from the Group pop-up menu and set the permissions to drwxrwxrwt.
21Choose Archive > New Folder.
22Set the name of the folder to CurrentUser
,
 choose admin from the Group pop-up menu and set the permissions to drwxrwxr-x.
23Add into the CurrentUser folder
, the files you want to install,
 imagining this is the current user home folder.


Safari
是否支持继续NPAPI，目前没有结论

https://discussions.apple.com/thread/6558586?start=0&tstart=0

火狐官方宣布停止支持
NPAPI
http://www.jianshu.com/p/0e23d14c7846

苹果官网
NPAPI demo


密码控件有漏洞：

http://www.cnnvd.org.cn/vulnerability/show/cv_id/2016090449
https://support.apple.com/zh-cn/HT207170


官方
Demo
https://developer.apple.com/library/content/samplecode/NPAPI_Core_Animation_Movie_Plugin/Introduction/Intro.html

显示不了文字的解决办法：
新建一个类继承NSSecureTextFiled然后从写他的几个set方法，调用super就可以


