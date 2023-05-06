---
title: iOS 项目中加入 pch文件
updated: 2023-05-05 04:28:17Z
created: 2023-05-05 04:26:47Z
---

- 1.创建pch文件
- 2.在pch文件中加入要全局使用的头文件
- 3.在工程中加入该pch文件

## 创建pch文件
![e2dc4781cf62e71d039ffc436c44a9ff.png](../../../_resources/e2dc4781cf62e71d039ffc436c44a9ff.png)
- 直接创建,不改名字

## 打开该文件,添加需要全局使用的.h文件
![e6d997151ad150675998fac867668bd6.png](../../../_resources/e6d997151ad150675998fac867668bd6.png)

## 在工程中加入该pch文件
- 1.查找位置,修改值为yes,如图
![6fc4b490417d0aec837543eb51add754.png](../../../_resources/6fc4b490417d0aec837543eb51add754.png)


- 2.修改路径为:   $(SRCROOT)/Apartment/PrefixHeader.pch   ,其中Apartment为工程名,如图
![2a406fc1f91dbc9f58ee353593f016d6.png](../../../_resources/2a406fc1f91dbc9f58ee353593f016d6.png)

- 3.编译

# 这样就可以在工程中全局使用了,喜欢的可以点个喜欢




