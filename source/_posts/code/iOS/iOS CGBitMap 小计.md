---
title: iOS CGBitMap 小计
updated: 2023-05-05 04:09:54Z
created: 2023-05-05 04:09:42Z
---

### 创建context
```
CGBitmapContextCreate(<#void * _Nullable data#>,  //指向要渲染的绘制内存的地址
                       <#size_t width#>,     //width * scale
                       <#size_t height#>,    //height *scale
                       <#size_t bitsPerComponent#>,   //内存中像素的每个组件的位数 对于32位像素格式和RGB 颜色空间，你应该将这个值设为8
                       <#size_t bytesPerRow#>,   //每一行在内存所占的比特数
                       <#CGColorSpaceRef  _Nullable space#>,     //上下文使用的颜色空间
                       <#uint32_t bitmapInfo#>  //指定bitmap是否包含alpha通道，像素中alpha通道的相对位置，像素组件是整形还是浮点型等信息的字符串
                      )
```
---
---
### 针对bitmapInfo字段做一些备注
### 1. CGBitmapInfo
* 这个主要说一下`kCGBitmapByteOrder32Little` / ` kCGBitmapByteOrder32Big`
* `kCGBitmapByteOrder32Little` 生成的信息位置为: `倒序`
* `kCGBitmapByteOrder32Big` 生成的信息位置为: `顺序`
```
typedef CF_OPTIONS(uint32_t, CGBitmapInfo) {
    kCGBitmapAlphaInfoMask = 0x1F,

    kCGBitmapFloatInfoMask = 0xF00,
    kCGBitmapFloatComponents = (1 << 8),

    kCGBitmapByteOrderMask     = kCGImageByteOrderMask,
    kCGBitmapByteOrderDefault  = kCGImageByteOrderDefault,
    kCGBitmapByteOrder16Little = kCGImageByteOrder16Little,
    kCGBitmapByteOrder32Little = kCGImageByteOrder32Little,
    kCGBitmapByteOrder16Big    = kCGImageByteOrder16Big,
    kCGBitmapByteOrder32Big    = kCGImageByteOrder32Big
} CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);
```

### 2. CGImageAlphaInfo
* 这个主要说一下 `kCGImageAlphaPremultipliedLast` / `kCGImageAlphaPremultipliedFirst`
* `kCGImageAlphaPremultipliedLast ` >>>> ` R G B A `
* `kCGImageAlphaPremultipliedFirst ` >>>> ` A R G B `
```
typedef CF_ENUM(uint32_t, CGImageAlphaInfo) {
    kCGImageAlphaNone,               /* For example, RGB. */
    kCGImageAlphaPremultipliedLast,  /* For example, premultiplied RGBA */
    kCGImageAlphaPremultipliedFirst, /* For example, premultiplied ARGB */
    kCGImageAlphaLast,               /* For example, non-premultiplied RGBA */
    kCGImageAlphaFirst,              /* For example, non-premultiplied ARGB */
    kCGImageAlphaNoneSkipLast,       /* For example, RBGX. */
    kCGImageAlphaNoneSkipFirst,      /* For example, XRGB. */
    kCGImageAlphaOnly                /* No color data, alpha data only */
};
```

### 说了这么多 举个栗子
```
    //顺序  +   argb  = argb
    kCGImageByteOrder32Big | kCGImageAlphaPremultipliedFirst  
    const int RED = 1;
    const int GREEN = 2;
    const int BLUE = 3;
    const int ALPHA = 0;

    //顺序  +   rgba  = rgba
    kCGImageByteOrder32Big | kCGImageAlphaPremultipliedLast 
    const int RED = 0;
    const int GREEN =1;
    const int BLUE = 2;
    const int ALPHA = 3;


    //倒序   +  rgba   = abgr
    kCGImageByteOrder32Little | kCGImageAlphaPremultipliedLast
    const int RED = 3;
    const int GREEN = 2;
    const int BLUE = 1;
    const int ALPHA = 0;

    //倒序 + argb = bgra;
    //kCGImageByteOrder32Little | kCGImageAlphaPremultipliedFirst
    const int RED = 2;
    const int GREEN = 1;
    const int BLUE = 0;
    const int ALPHA = 3;

```



