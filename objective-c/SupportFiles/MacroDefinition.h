//
//  MacroDefinition.h
//  objective-c
//
//  Created by silence on 2020/9/22.
//  Copyright © 2020 Silence. All rights reserved.
//

/*型号                       屏幕尺寸    分辨率（pt）    Reader    分辨率（px）    渲染后（px）    PPI
iPhone 3GS                  3.5寸     320 x 480      @1x      320 x 480        空          163
iPhone 4/4S                 3.5寸     320 x 480      @2x      640 x 960        空          326
iPhone 5/5S/5C/SE           4.0寸     320 x 568      @2x      640 x 1136       空          326
iPhone 6/6S/7/8             4.7寸     375 x 667      @2x      750 x 1334       空          326
iPhone 6/6S/7/8 Plus        5.5寸     414 x 736      @3x      1242 x 2208   1080x1920      401
iPhone X/XS/11 Pro          5.8寸     375 x 812      @3x      1125 x 2436      空          458
iPhone XR/11                6.1寸     414 x 896      @2x      828 x 1792       空          326
iPhone XS Max/11 Pro Max    6.5寸     414 x 896      @3x      1242 x 2688      空          458
*/

#ifndef MacroDefinition_h
#define MacroDefinition_h

//TODO:自定义打印日志
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) {}
#endif

//TODO:弱引用、强引用宏定义
#define weak_self(type)  __weak typeof(type) weak##type = type;
#define strong_self(type)  __strong typeof(type) type = weak##type;

//TODO:屏幕尺寸
#define screen_w [UIScreen mainScreen].bounds.size.width
#define screen_h [UIScreen mainScreen].bounds.size.height
#define navi_h (isIPhoneX?88:64)
#define tabbar_h (isIPhoneX?83:49)
#define safeArea_h (isIPhoneX?34:0)
#define status_h (isIPhoneX?44:20)

//TODO:不同的设备
// use to iPad
#define isIPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
// use to iphone 5,5s,6,7,8
#define isIPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// use to iphone 6P,7P,8P
#define isIPhonePlus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)

//TODO:刘海屏判断
#define isIPhoneX (CGSizeEqualToSize(CGSizeMake(375.f, 812.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(812.f, 375.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(414.f, 896.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(896.f, 414.f), [UIScreen mainScreen].bounds.size))


//TODO:RGB颜色设置
#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B)     [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

#endif /* MacroDefinition_h */

