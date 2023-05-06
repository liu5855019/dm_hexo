---
title: iOS cocoapods
updated: 2023-05-05 07:10:37Z
created: 2023-05-05 07:09:11Z
tags:
  - ios
---


### Mac 10.14 以上 安装 cocoapods
> sudo gem install -n /usr/local/bin cocoapods

### pod update 命令运行失败的时候
> 在 Podfile 文件中 do 前 加入
>
> source 'https://github.com/CocoaPods/Specs.git'
>
> 命令 , 再次 pod update

### pod 上传相关
```
# 1.先把 东西写好,上传 github

# 2.添加标记
git tag 1.1.0

# 3.将标记上传
git push --tags

# 4.修改 podspec 文件

# 5.进入 podspec 文件所在目录

# 6.检查 podspec 是否修改完成
pod spec lint --allow-warnings

# 7. 上传 pod
pod trunk push --allow-warnings


其它:
#登录过期后
1.  pod trunk register qq@qq.com 'password' --verbose
2.  pod 会发一封邮件到邮箱 (可能在垃圾箱)
3.  点击邮箱中链接进行验证
4.  pod trunk me

```

### pod 忽略警告
第一种:
> pod '三方名称', :inhibit_warnings => true

第二种: 忽略所有
> platform :ios, '9.0'
> inhibit_all_warnings!