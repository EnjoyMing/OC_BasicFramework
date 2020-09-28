//
//  SNUserInfo.m
//  objective-c
//
//  Created by silence on 2020/9/28.
//  Copyright © 2020 Silence. All rights reserved.
//

#import "SNUserInfo.h"

@interface SNUserInfo()

@end

static SNUserInfo * share;

@implementation SNUserInfo
+ (void)load{
    //将属性的所有setter、getter方法与自定义的方法互换
    unsigned int count = 0;
    Ivar *varList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = varList[i];
        //获取属性名称
        const char *attr = ivar_getName(ivar);
        NSString *attriName = [NSString stringWithFormat:@"%s",attr];
        attriName = [attriName substringFromIndex:1];
        NSString *firstAttriName = [attriName substringToIndex:1];
        firstAttriName = [firstAttriName uppercaseString];
        NSString *lastAttriName = [attriName substringFromIndex:1];
        //构造原setter方法
        SEL originalSetSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",firstAttriName,lastAttriName]);
        Method originalSetMethod = class_getInstanceMethod([self class], originalSetSelector);
        
        //构造原getter方法
        SEL originalGetSelector = NSSelectorFromString(attriName);
        Method originalGetMethod = class_getInstanceMethod([self class], originalGetSelector);
        
        //新setter方法
        SEL newSetSelector = @selector(setMyAttribute:);
        Method newSetMethod = class_getInstanceMethod([self class], newSetSelector);
        IMP newSetIMP = method_getImplementation(newSetMethod);
        //新getter方法
        SEL newGetSelector = @selector(getAttribute);
        Method newGetMethod = class_getInstanceMethod([self class], newGetSelector);
        IMP newGetIMP = method_getImplementation(newGetMethod);
        
        //Method Swizzling
        method_setImplementation(originalSetMethod, newSetIMP);
        method_setImplementation(originalGetMethod, newGetIMP);
    }
}

#pragma mark-自定义setter方法（将属性值都存储到用户偏好设置）
- (void)setMyAttribute:(id)attribute{
    //获取调用的方法名称
    NSString *selectorString = NSStringFromSelector(_cmd);
    //对set方法进行属性字段的解析,并存储到用户偏好设置表
    NSString *attr = [selectorString substringFromIndex:3];
    attr = [attr substringToIndex:[attr length]-1];
    //对首字符进行小写
    NSString *firstChar = [attr substringToIndex:1];
    firstChar = [firstChar lowercaseString];
    NSString *lastAttri = [NSString stringWithFormat:@"%@%@",firstChar,[attr substringFromIndex:1]];
    [[NSUserDefaults standardUserDefaults]setObject:attribute forKey:lastAttri];
}

#pragma mark-自定义的getter方法（将属性值从用户偏好设置中取出）
- (id)getAttribute{
    //获取方法名
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSString *result = [[NSUserDefaults standardUserDefaults] objectForKey:selectorString];
    if ([result isEqual:[NSNull null]]) {
        result = nil;
    }
    return result;
}


/*创建单利*/
+ (instancetype)share {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[SNUserInfo alloc] init];
    });
    return share;
}

/*创建单利*/
+ (void)configInfo:(NSDictionary *)info {
    NSArray * allKeys = [info allKeys];
    for (NSString * key in allKeys) {
        //首字母大写
        NSString *firstKey = [key substringToIndex:1];
        firstKey = [firstKey uppercaseString];
        NSString *lastKey = [key substringFromIndex:1];
        
        //构造setter方法
        NSString *selectorStr = [NSString stringWithFormat:@"set%@%@:",firstKey,lastKey];
        SEL setSeletor = NSSelectorFromString(selectorStr);
        
        //调用setter方法
        NSString *value = [info objectForKey:key];
        
        SNUserInfo *manager = [SNUserInfo share];
        if (!manager) { return; }
        IMP imp = [manager methodForSelector:setSeletor];
        void (*func)(id, SEL, NSString *) = (void *)imp;
        func(manager, setSeletor, value);
    }
    [SNUserInfo share].loginStatus = YES;
}

/*退出登录*/
+ (void)loginOut {
    //清除本地信息
    [self cleanLocalInfo];
    
    /*
     *
     如果业务逻辑上需要将用户登出的状态通知到服务器；在此处进行项目的网络操作
     network handle
     *
     */
}
/*清除存储在用户偏好设置中的所有用户信息*/
+ (void)cleanLocalInfo{
    NSArray *allAttribute =  [self getAllProperties];
    for (NSString *attribute in allAttribute) {
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:attribute];
    }
    [SNUserInfo share].loginStatus = NO;
}
/*获取用户信息类的所有属性*/
+ (NSArray *)getAllProperties {
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}

@end
