---
title: 关于push推送的种种
updated: 2023-05-05 04:25:49Z
created: 2023-05-05 04:25:26Z
---

#1.后台推送过来的格式一般为
```
{  
  "aps" : {  
    "alert" : {  
      "body" : "Bob wants to play poker",  //消息  
      "action-loc-key" : “PLAY"             
    },  
    "badge" : 5, //显示在App左上角的角标数，代表未读消息，需要自己的服务进行统计和控制，apns不支持+1或者-1的操作。  
  },  
  "parm1" : "bar", //控制参数
  "parm2″ : [ "bang", "value" ] //扩展参数  
}   
```
* 这里要注意的时alert部分，它的值可以是一个String（文本消息），也可以是一个JSON的Dictionary。当它是文本消息的时候，系统就会把这些文字显示到一个alertview中；如果它也是由一个JSON Dictionary组成的话，其格式如下：
```body
action-loc-key
loc-key
loc-args
launch-image
```
* body部分就是alertView中将要展现出来的文本消息，loc-属性主要是用来实现本地化消息，launch-image只是app主bundle里的一个图片文件的名称，一般来说我们不指定这一属性。

#####这么来的话就可以正常显示了,但是有一种问题,用户如果不点击这条消息,是无法回调到app里的
#2.当程序在后台时不需要用户点击,可以直接回调到app里
* 让后台加上下列代码
```
{
    aps:{
       content-available:1
       alert:{...}
    }
}
```
* 需要客户端打开后台模式 Remote notifications













