---
title: iOS UIImage  CIImage  CGImage  自己的理解
updated: 2023-05-05 04:10:43Z
created: 2023-05-05 04:10:21Z
---

### 创建与使用
 ##### 1.使用imageWithCGImage 生成的图片
  * 会重新生成UIImage
  * 会把生成它的CGImageRef保存下来
  * 并且img.CIImage为nil
  * 可以生成NSData
```
    CGImageRef ref = img.CGImage;
    img = [UIImage imageWithCGImage:ref];
    if (ref == img.CGImage) {
        NSLog(@"把生成它的cgimg存下来了");
    }
    if (!img.CIImage) {
        NSLog(@"ciimg == nil");
    }

    //测试cgimg >> data
    NSData *data = UIImagePNGRepresentation(img);
    if (data.length) {
        NSLog(@"cgimg >> uiimg >> data  成功!");
    } else {
        NSLog(@"cgimg >> uiimg >> data  失败!");
    }
```
##### 2.使用imageWithCIImage 生成的图片  
  * 也会重新生成UIImage   
  * 同时会把生成它的CIImage存下来
  * img.CGImage == NULL
  * 生成NSData 为 nil
```
    CIImage *ciImg = [[CIImage alloc] initWithImage:img];
    img = [UIImage imageWithCIImage:ciImg];
    if (ciImg == img.CIImage) {
        NSLog(@"把生成它的ciimg存下来了");
    }
    if (!img.CGImage) {
        NSLog(@"cgimg == NULL");
    }

    //测试ciimg >> data
    data = UIImagePNGRepresentation(img);
    if (data.length) {
        NSLog(@"ciimg >> uiimg >> data  成功!");
    } else {
        NSLog(@"ciimg >> uiimg >> data  失败!");
    }
```