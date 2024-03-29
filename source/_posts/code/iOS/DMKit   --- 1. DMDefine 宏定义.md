---
title: DMKit   --- 1. DMDefine 宏定义
updated: 2023-05-05 04:21:14Z
created: 2023-05-05 04:21:10Z
---

#DMKit 第一篇:DMDefine.h     开发iOS的时候经常用到的宏定义

###NSLog

```
#ifndef __OPTIMIZE__
# define NSLog(...) NSLog(__VA_ARGS__)
#else
# define NSLog(...)
#endif

#ifdef DEBUG
#define MyLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define MyLog(...)
#endif
```
###Screen/Frame 屏幕尺寸
```
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenW [UIScreen mainScreen].bounds.size.width

#define kLineH (1.0f / [UIScreen mainScreen].scale)

//按比例设置view大小/字体大小等    这里要配合UserInfo单利使用
#define kScale(value) ((value) * [UserInfo shareUser].screenScale)
#define kScaleW(value) ((value) * [UserInfo shareUser].screenScaleW)

#define kGetX(v)            (v).frame.origin.x
#define kGetY(v)            (v).frame.origin.y
#define kGetW(v)            (v).frame.size.width
#define kGetH(v)            (v).frame.size.height

#define kGetMinX(v)            CGRectGetMinX((v).frame) // 获得控件屏幕的x坐标
#define kGetMinY(v)            CGRectGetMinY((v).frame) // 获得控件屏幕的Y坐标

#define kGetMidX(v)            CGRectGetMidX((v).frame) //横坐标加上到控件中点坐标
#define kGetMidY(v)            CGRectGetMidY((v).frame) //纵坐标加上到控件中点坐标

#define kGetMaxX(v)            CGRectGetMaxX((v).frame) //横坐标加上控件的宽度
#define kGetMaxY(v)            CGRectGetMaxY((v).frame) //纵坐标加上控件的高度

#define kGetTextSize(text, font) [text length] > 0 ? [text sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero     //获取字体size
```
### 判断当前的iPhone设备/系统版本
```
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

//获取系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//判断 iOS 8 或更高的系统版本
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))
//获得app build号
#define kAppBuild [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey]
//获得app Version 号
#define kAppVerison [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
```
### Color
```
//快速获取颜色
#define kGetColorRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kGetColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define kGetColorRgbValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


// 随机色
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

```
### setValue:赋值的时候使用 
```
#define DM_STRING(object) (((object == nil) || ([object isEqual:[NSNull null]])) ? @"":[NSString stringWithFormat:@"%@", object])

#define DM_INTEGER(object)    ( ((object == nil) || ([object isEqual:[NSNull null]])) ? 0 : [object integerValue])

#define DM_FLOAT(object)    ( ((object == nil) || ([object isEqual:[NSNull null]])) ? 0.0f : [object floatValue])

#define DM_DOUBLE(object)    ( ((object == nil) || ([object isEqual:[NSNull null]])) ? 0.0f : [object doubleValue])

#define DM_BOOL(object)    ( ((object == nil) || ([object isEqual:[NSNull null]])) ? NO : [object boolValue])

#define DM_ARRAY(object)    ( ((object == nil) || ([object isEqual:[NSNull null]])) ? @[] : object )

#define DM_DICTIONARY(object)  ( ((object == nil) || ([object isEqual:[NSNull null]])) ? @{} : object )
```
### Image
```
// 加载本地图片,不缓存
#define kLoadImage(fileName,extName) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:fileName ofType:extName]]

// 加载本地图片,缓存
#define kGetImage(fileName) [UIImage imageNamed: fileName]

// 加载xib
#define kLoadView(className) [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil][0]
```
### G－C－D
```
//后台线程运行
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
//主线程运行
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)
//selfWeak
#define WeakObj(self) __weak typeof(self) self##Weak = self;
```
### 国际化
```
//获取字符串
#define kLocStr(str) NSLocalizedString(str, nil)
#define kLocStrTab(str,file) NSLocalizedStringFromTable(str, file, nil)

//获取当前语言
#define kCurrentLanguage [[NSLocale preferredLanguages] firstObject]
```

#####自己用的大概就这么多吧,能应付一般的项目,把它放到pch里面,能使项目少写很多代码

#DMKit-GitHub:[GitHub-DMKit](https://github.com/liu5855019/DMKit)