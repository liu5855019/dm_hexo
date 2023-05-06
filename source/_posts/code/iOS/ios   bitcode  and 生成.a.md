---
title: ios   bitcode  and 生成.a
updated: 2023-05-05 04:05:12Z
created: 2023-05-05 04:05:04Z
---

bitcode 是必要的



用Clang编译成 ARM64 格式且带bitcode的目标文件test.o demo.o:　　
wuqiong:~ apple$ xcrun -sdk iphoneos clang -arch arm64 -fembed-bitcode -c test.m demo.m

然后把两个目标文件打包为一个静态库文件:
wuqiong:~ apple$ xcrun -sdk iphoneos ar  -r libTest.a test.o demo.o
ar: creating archive libTest.a

用Shell命令otool查看目标文件中是否包含bitcode段:
wuqiong:~ apple$ otool -l test.o |grep bitcode
  sectname __bitcode
  sectname __bitcode
如果看到输出了2行sectname __bitcode,就是说明这静态库中的两个目标文件包含了bitcode.　　