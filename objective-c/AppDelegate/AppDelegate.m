//
//  AppDelegate.m
//  objective-c
//
//  Created by silence on 2020/9/22.
//  Copyright © 2020 Silence. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 应用程序启动后覆盖自定义点。
    if (@available(iOS 13.0, *)) {
        
    }else{
        [[SNInitObject share] init_custom];
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
        self.window.rootViewController = [SNCustomTabBarVC new];
        [[SNInitObject share] setupLaunchImage:self.window];
    }
    NSLog(@"%d",navi_h);
    return YES;
}


#pragma mark - UISceneSession lifecycle
- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    //当创建一个新的场景会话时调用。
    // Use this method to select a configuration to create the new scene with.
    //使用这个方法选择一个配置来创建新的场景。
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    //当用户丢弃场景会话时调用。
    
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    //如果任何会话在应用程序不运行时被丢弃，这将在application:didFinishLaunchingWithOptions后不久被调用。
    
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    //使用此方法释放特定于被丢弃场景的任何资源，因为它们不会返回。
}


@end
