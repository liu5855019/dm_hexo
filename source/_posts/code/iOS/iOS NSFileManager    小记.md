---
title: iOS NSFileManager    小记
updated: 2023-05-05 04:13:22Z
created: 2023-05-05 04:13:04Z
---


##遍历文件夹
---
#### * 办法1
```
    NSDirectoryEnumerator *enumer = [[NSFileManager defaultManager] enumeratorAtPath:dirPath];
    NSString *path;
    while (path = [enumer nextObject]) {
        NSLog(@"%@",path);
    }
```
######遍历结果:
```
19章新副本攻略-9.doc
gg修改教程-6.docx
test                    //文件夹
test/test.png     //文件夹下的文件
```
###### 这样可以连文件夹带文件夹下的文件path一起读出来
---
#### * 办法2
```
    NSError *err = nil;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:&err];
    if (err) {
        NSLog(@"%@",err);
    } else {
        NSLog(@"%@",files);
    }
```
######遍历结果:
 ```
19章新副本攻略-9.doc,
gg修改教程-6.docx,
test          //文件夹
```
######能遍历出来文件夹,但是不遍历文件夹下的东西 
=========================================================


