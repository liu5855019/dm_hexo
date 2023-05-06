---
title: iOS 打包自己的 app 生成ipa给老板用
updated: 2023-05-05 06:19:50Z
created: 2023-05-05 04:29:29Z
---

### 1进入developer.apple.com  创建证书
![d638ef31928e47178b07fbdf30889197.png](../../../_resources/d638ef31928e47178b07fbdf30889197.png)



### 2如果发布证书已经有了请跳过,没有的跟着创建证书
![ab8367e3d62ee28c5fdbffbc3be268dc.png](../../../_resources/ab8367e3d62ee28c5fdbffbc3be268dc.png)

![3b4fbb725a23a15c812f51b7919ec65c.png](../../../_resources/3b4fbb725a23a15c812f51b7919ec65c.png)

- 在这里选择你的请求证书,如果没有请求证书,在文章末尾给出请求证书生成过程
![8019f97aa656afee4348ae24779378f0.png](../../../_resources/8019f97aa656afee4348ae24779378f0.png)

- 创建完成后下载出来
![c0f305e7c4a3937699fde912b9dc5980.png](../../../_resources/c0f305e7c4a3937699fde912b9dc5980.png)

### 3 创建应用程序(app id)
![ce15d424cf92f2de0a3544597dcbba32.png](../../../_resources/ce15d424cf92f2de0a3544597dcbba32.png)

### 4 添加老板设备(iPhone)  ,如果不知道老板的udid,文章末尾给出用手机查看udid的解决办法  
![fbc6b23adef18743a551f8a014625fd9.png](../../../_resources/fbc6b23adef18743a551f8a014625fd9.png)

### 5 生成profile
![baf81ad9dad5ddd1ac99589453625dc3.png](../../../_resources/baf81ad9dad5ddd1ac99589453625dc3.png)

- 选择你刚才创建的 app id
![b13b7983b1dfcb0f8a610a536de93494.png](../../../_resources/b13b7983b1dfcb0f8a610a536de93494.png)

- 选择你创建的发布证书
![7f5fe230cd36cf7b065b41a3de982d19.png](../../../_resources/7f5fe230cd36cf7b065b41a3de982d19.png)

- 选择设备(最少要有老板iPhone)
![7677e2906927f26acadb80d3c3647da3.png](../../../_resources/7677e2906927f26acadb80d3c3647da3.png)

- 给生成的profile取个名字
![482e46c7f810c5f3fcf0e8e1255444de.png](../../../_resources/482e46c7f810c5f3fcf0e8e1255444de.png)

![a174b2a2311ae20eba49dd2a1815f8d7.png](../../../_resources/a174b2a2311ae20eba49dd2a1815f8d7.png)

##### 至此证书创建完成
----------------------------
----
### 6 把刚才下载的两个文件都双击了


### 7 在工程中选择刚创建的profile名字(28处)
![142d5c69ee038a72a35204a88c3a196a.png](../../../_resources/142d5c69ee038a72a35204a88c3a196a.png)

### 8 填入app id 选择team (你登录的$99账号的主号)
![b9a6c49eb25a9bc64b72fd4e563a9014.png](../../../_resources/b9a6c49eb25a9bc64b72fd4e563a9014.png)

### 9 打包
![e6ea7b5c26e849d1fd7108356fd62701.png](../../../_resources/e6ea7b5c26e849d1fd7108356fd62701.png)

- 导出ipa
![1f0d460ff0296171e00205fb0dad8320.png](../../../_resources/1f0d460ff0296171e00205fb0dad8320.png)
![f1b30d573b361a8030d113b1576bb775.png](../../../_resources/f1b30d573b361a8030d113b1576bb775.png)
### 至此打包结束,可以上传到蒲公英等网站供老板下载了
--------------------------
---
### 附1 生成请求证书
- 打开钥匙串
![91016fbde9a802206544d1ea2ee3ac87.png](../../../_resources/91016fbde9a802206544d1ea2ee3ac87.png)


![e071a71a02647cbb5da178941aae10da.png](../../../_resources/e071a71a02647cbb5da178941aae10da.png)


![e3cd4910c226c8b9268de98a5b444f7e.png](../../../_resources/e3cd4910c226c8b9268de98a5b444f7e.png)

### 附2 用手机拿到老板的udid (用Xcode获得都会就不说了)

![069ff7fd0e9f9060b0a1d890d558dd0b.png](../../../_resources/069ff7fd0e9f9060b0a1d890d558dd0b.png)


# 文章到此结束,喜欢的请收藏,转载请标明出处