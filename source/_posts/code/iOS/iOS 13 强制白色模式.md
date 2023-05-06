---
title: iOS 13 强制白色模式
updated: 2023-05-05 03:01:07Z
created: 2023-05-05 03:00:58Z
tags:
  - code
  - ios
---

* 1. 在 `AppDelegate` 中 加入如下代码:
```
if (@available(iOS 13.0, *)) {
    self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
} else {
        
}
```

* 2.需要在`info.plist`文件中添加`User Interface Style`配置, 并设置为`Light`
```
<key>UIUserInterfaceStyle</key>
<string>Light</string>
```