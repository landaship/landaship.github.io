# 1.授权的三个步骤
     1.获取未授权的 request Token
     2. 获取用户授权的Request Toker
     3. 用授权过的Request Token 换取Access Token


如何发送post请求：
用开源框架： 

afnetworking 发送请求：
    


text／plain 服务器返回的类型是普通文本类型；failure不一定是服务器错误，可能是AFNetwork框架的错误，记住咯❌


POST请求以后返回值：
    "access_token" = "2.002TRblB8txwCB143a78f242HYZ68E";
    "expires_in" = 157679999;
    "remind_in" = 157679999;
    uid = 1619505927;  用户唯一id

建立一个新的account用来记录用户数据，
为什么讨论到了归档解档？

NScodershi 干什么的？

沙盒是什么鸟？tmp，lib通过NSSearchPathForDirectoriesInDomains这个访问？

NSKeyedArchiver又是什么鸟？

单例子分两部分：从写alloc retain release还有声明static 

还要学会宏定义：＃＃表示可替换文字

单例子都独立成一个文件鸟。。。
🐦

JSON又是一个类！！！！！fuck！！！

paragma message 这个东西一直都会有警告，除非你手动注释掉，否则一直会有警告产生 
     
Tips：
     多次请求返回的Access  Token是一样的
nsmutableurlrequest：requestwithurl

拿到请求标记，拿到访问标记， 

开源中国是否有API接口

4.公共账号：643055866@qq.com
itcastios




指示器：HUD
蒙板  MB。。。HUB

搞清楚新浪微博的建铨流程

什么时候要加：<UITableViewDataSource, UITableViewDelegate]]>
？不是新建tableview就需要么？奇怪这里为什么没有需要？    为什么不声明也没有报错？ 


mvc
数据和模型要放到一起，why？

草，导航栏怎么回事，怎么变成透明的了，头疼死了，跟这个有关UIBarMetricsDefault
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background.png"] forBarMetrics:UIBarMetricsDefault];

httpTools:负责发送微博项目的的get和post请求
statusTool：负责管理微博数据，抓去微博数据，发送微博，
AccountTool：管理账号，存储读取账号信息


