---
title: DMKit   --- 3. UserInfo  单利
updated: 2023-05-05 08:53:44Z
created: 2023-05-05 04:22:16Z
---

# DMKit 第三篇:UserInfo     
- 开发iOS的时候经常用到的用户信息单利
### *UserInfo* 当中存储了用户的重要信息,使用单利模式存取更加方便,使用归档解档数据更加安全,并且把屏幕比例写到了这里--ui布局更加精确
### 具体内容[GitHub-DMKit](https://github.com/liu5855019/DMKit)
### UserInfo.h
```
#import <Foundation/Foundation.h>

@interface UserInfo : NSObject


@property (nonatomic , copy) NSString *oldLoginStr;
@property (nonatomic , copy) NSString *token;

@property (nonatomic , assign) NSInteger userID;
@property (nonatomic , copy) NSString *phoneNum;        ///<手机号
@property (nonatomic , assign) double registTime;       ///<注册时间
@property (nonatomic , copy) NSString *email;           ///<邮箱
@property (nonatomic , copy) NSString *userName;        ///<用户名
@property (nonatomic , copy) NSString *address;         ///<详细地址
@property (nonatomic , copy) NSString *province;        ///<省
@property (nonatomic , copy) NSString *city;            ///<市
@property (nonatomic , copy) NSString *district;        ///<区


@property (nonatomic , copy) NSString *password;

@property (nonatomic , copy) NSString *headImg;         ///<头像
@property (nonatomic , copy) NSString *headImgH;        ///<高清版头像




+(instancetype) shareUser;

/** 当用户登录了返回当前用户的token,如果是游客返回 "tourist" */
+(NSString *)token;

/** 写入文件 */
-(void)saveDatas;
/** 删除文件 */
-(void)removeDatas;
/** 清除个人数据 */
-(void)clearDatas;
/** 是否登录状态,根据token值动态计算 */
-(BOOL)isLogin;



//屏幕比例 根据6/6s/7的屏幕计算屏幕比例 配合DMDefine使用
- (CGFloat)screenScale;
- (CGFloat)screenScaleW;

@end
```
###类扩展
```
#define kUserInfo @"Userinfo"
static NSString * const kTourist = @"tourist";              ///<游客token

@interface UserInfo ()

@property (nonatomic , assign) CGFloat scale;
@property (nonatomic , assign) CGFloat scaleW;

@end

```
### shareUser
```
+(instancetype) shareUser{
    static UserInfo *userInfo;
    if (userInfo) {
        return userInfo;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *filePath = [DMTools filePathInDocuntsWithFile:kUserInfo];
        userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        
        if (!userInfo) {
            userInfo = [[self alloc] init];
        }
    });
    
    return userInfo;
}
```
### token  
- 不推荐直接读取token,这样做我觉得更好
```
+(NSString *)token
{
    return [UserInfo shareUser].token.length ? [UserInfo shareUser].token : kTourist;
}
```
### isLogin      
- 不建议使用状态值来保存, 使用这种动态获取登录状态最好
```
-(BOOL)isLogin
{
    if (_token.length > 0) {
        return YES;
    }
    return NO;
}
```


### 存取
```
-(void)saveDatas{
    NSString *filePath = [DMTools filePathInDocuntsWithFile:kUserInfo];
    
    [NSKeyedArchiver archiveRootObject:self toFile:filePath];
}

-(void)removeDatas{
    //删除归档的文件
    NSString *filePath = [DMTools filePathInDocuntsWithFile:kUserInfo];
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}
-(void)clearDatas
{
    self.token = @"";
    self.phoneNum = nil;
    self.userID = 0;
    self.registTime = 0;
    self.email = nil;
    self.userName = nil;
    self.province = nil;
    self.city = nil;
    self.district = nil;
    self.address = nil;
    self.headImg = nil;
    self.headImgH = nil;
    
    [self saveDatas];
}
```
### 归档解档
```
/**
 *  解档协议方法
 */
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        
        self.oldLoginStr = [coder decodeObjectForKey:@"oldLoginStr"];
        self.token = [coder decodeObjectForKey:@"token"];
        
        self.userID = [coder decodeIntegerForKey:@"userID"];
        self.phoneNum = [coder decodeObjectForKey:@"phoneNum"];
        self.registTime = [coder decodeDoubleForKey:@"registTime"];
        self.email = [coder decodeObjectForKey:@"email"];
        self.userName = [coder decodeObjectForKey:@"userName"];
        self.address = [coder decodeObjectForKey:@"address"];
        self.province = [coder decodeObjectForKey:@"province"];
        self.city = [coder decodeObjectForKey:@"city"];
        self.district = [coder decodeObjectForKey:@"district"];
        self.headImg = [coder decodeObjectForKey:@"headImg"];
        self.headImgH = [coder decodeObjectForKey:@"headImgH"];
    
        self.password = [coder decodeObjectForKey:@"password"];
    }
    return self;
}

/**
 *  归档协议方法
 */
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_oldLoginStr forKey:@"oldLoginStr"];
    [aCoder encodeObject:_token forKey:@"token"];
    
    
    [aCoder encodeInteger:_userID forKey:@"userID"];
    [aCoder encodeDouble:_registTime forKey:@"registTime"];
    [aCoder encodeObject:_phoneNum forKey:@"phoneNum"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_userName forKey:@"userName"];
    [aCoder encodeObject:_address forKey:@"address"];
    [aCoder encodeObject:_province forKey:@"province"];
    [aCoder encodeObject:_city forKey:@"city"];
    [aCoder encodeObject:_district forKey:@"district"];
    [aCoder encodeObject:_headImg forKey:@"headImg"];
    [aCoder encodeObject:_headImgH forKey:@"headImgH"];
    
    
    [aCoder encodeObject:_password forKey:@"password"];
}
```
### Screen 屏幕比例 根据6/6s/7的屏幕计算屏幕比例 配合DMDefine使用,极力推荐这样使用,布局出来的东西跟ui给的图基本一模一样
```
// kScale(123);
// kScaleW(123);

-(CGFloat)screenScale
{
    if (_scale == 0) {
        _scale = kScreenH / 667.0f;
    }
    return _scale;
}

-(CGFloat)screenScaleW
{
    if (_scaleW == 0) {
        _scaleW = kScreenW / 375.0f;
    }
    return _scaleW;
}

```
# 想具体看看的请移驾:[GitHub-DMKit](https://github.com/liu5855019/DMKit)