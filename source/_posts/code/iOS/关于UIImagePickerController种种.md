---
title: 关于UIImagePickerController种种
updated: 2023-05-05 04:26:24Z
created: 2023-05-05 04:26:16Z
---

###1设置照相机button为国际化
在info.plist中设置 localized resources can be mixed 为 yes 即可

###2让照片始终竖着朝向自己,不知道在win上面是否管用
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    
    if (image.imageOrientation == UIImageOrientationLeft) {
        image = [UIImage imageWithCGImage:image.CGImage scale:1 orientation:UIImageOrientationLeft];
    }else{
        image = [UIImage imageWithCGImage:image.CGImage scale:1 orientation:UIImageOrientationRight];
    }