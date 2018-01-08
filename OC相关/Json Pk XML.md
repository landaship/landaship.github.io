# 
XML解析方式
DOM解析：一次性将整个XML文档加载进内存，比较适合解析小文件
SAX解析：从根元素开始，按顺序一个元素一个元素往下解析，比较适合解析大文件

Dom方式的建议使用TBXML，我们大多数情况都是只读取，TBXML是读取效率最高，使用使用最方便的库，GDataXML虽然可读写，但是有点大，有点慢，如果用SAX的方式，建议使用libxml2，这个解析大文件比较快。

xpath：http://www.cnblogs.com/longqi293/archive/2009/01/30/1381447.html

各种比较：http://www.programgo.com/article/7287477315/


json和xml现在基本上可以相互替代，但是各有优缺点，json解析比较简单，比较易读，修改麻烦
xml解析复杂，而且xml文件结构比较大，消耗流量等，但是结构清晰，修改和扩充结构比较简单
https://www.zhihu.com/question/25636060


下面的例子就很直白的表达了xml跟json的不同，xml跟简洁易读，新添两个节点address xml只需要两行代码搞定，而json需要写成数组然后里面用字典的方式，整个表达式变得很冗长，不利于人阅读，这就是xml为何多做ui配置文件，config配置文件。json也有他的优点，就是很强的key－value，方便机器识别判断，传输速度快，占用空间小等，解析速读快而已
表达一个组配置用json
{
  "catalog": {
    "-name": "hq",
    "-description": "服务器地址配置",
    "-test": "test",
    "address": [
      {
        "-desription": "添加一个描述",
        "#text": "aaaaa"
      },
      {
        "-desription": "添加一个描述",
        "#text": "aaaaa"
      }
    ],
    "item": [
      {
        "-name": "isMultipleUrl",
        "-value": "1",
        "-description": "是否有多线路,0：否 1：是"
      },
      {
        "-fuck": "abc",
        "-name": "moudleTitles",
        "-value": "szsh.沪深|plat.板块|newShare.新股|bond.债券|index.指数",
        "-description": "行情模块标题配置"
      },
      {
        "-name": "isClearChooseWhenLogOut",
        "-value": "0",
        "-description": "是否退出时清空股票，0为不清空，1为清空"
      }
    ]
  }
}

表达一个组配置，用xml
 <catalog name="hq" description="服务器地址配置" test="test">
        <address desription="添加一个描述">aaaaa</address>
        <address desription="添加一个描述">aaaaa</address>
        <item name="isMultipleUrl" value="1" description="是否有多线路,0：否 1：是" />
        <item fuck="abc" name="moudleTitles" value="szsh.沪深|plat.板块|newShare.新股|bond.债券|index.指数" description="行情模块标题配置" />
        <item name="isClearChooseWhenLogOut" value="0" description="是否退出时清空股票，0为不清空，1为清空" />
    </catalog>

