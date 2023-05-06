---
title: iOS typedef NS_OPTIONS   枚举小记
updated: 2023-05-05 04:12:32Z
created: 2023-05-05 04:12:15Z
---

```c

typedef NS_OPTIONS(NSUInteger, TestOptions) {
    Option0 = 1 << 0,       //1   == 00000001
    Option1 = 1 << 1,       //2   == 00000010
    Option2 = 1 << 2,       //4   == 00000100
    Option3 = 1 << 3,       //8   == 00001000
    Option4 = 1 << 4,       //16  == 00010000
    Option5 = 1 << 5,       //32  == 00100000
    Option6 = 1 << 6,       //64  == 01000000
    Option7 = 1 << 7,       //128 == 10000000
};



void test()
{
    NSLog(@"%ld---%ld---%ld---%ld---%ld---%ld---%ld---%ld",Option0,Option1,Option2,Option3,Option4,Option5,Option6,Option7);
    
    NSUInteger option = Option2 | Option4 | Option6;        //84 = 01010100
    
    NSLog(@"option : %ld",option);      //84 = 01010100
    
    NSLog(@"%ld",option & Option0);     //0
    NSLog(@"%ld",option & Option1);     //0
    NSLog(@"%ld",option & Option2);     //4     01010100 & 00000100 = 00000100
    NSLog(@"%ld",option & Option3);     //0
    NSLog(@"%ld",option & Option4);     //16    01010100 & 00010000 = 00010000
    NSLog(@"%ld",option & Option5);     //0
    NSLog(@"%ld",option & Option6);     //64
    NSLog(@"%ld",option & Option7);     //0
}

```