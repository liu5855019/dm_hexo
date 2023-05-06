---
title: iOS 性能分析小记
updated: 2023-05-05 04:09:01Z
created: 2023-05-05 04:07:22Z
---

# 1.启动时间
* 1.1 main启动前时间测量: 通过环境变量,直接打印
  run >> arguments >> environment >> +号
> Name:   DYLD_PRINT_STATISTICS
> Value:   1
* 1.2  main之后通过计时打印时间
main.m:
```
CFAbsoluteTime startTime;

int main(int argc, char * argv[]) {
    @autoreleasepool {
        startTime = CFAbsoluteTimeGetCurrent();
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
```

delegate.m:
```
extern CFAbsoluteTime startTime;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    NSLog(@"startTime: %f s",CFAbsoluteTimeGetCurrent() - startTime);
    
    return YES;
}

```

# 2. 内存分析

* 2.1 weak 与 assign
> assign  : __unsafe__unretained   引用的对象释放后,指针依然指向原地址
>weak : 引用对象释放后,指针指向nil
* 2.2 检测内存泄漏方法
> 1. 静态分析
> 2. 动态检测方法 (__Instrument__)
> 3. 析构打印
> 4. 第三方工具 (MLeaksFinder)