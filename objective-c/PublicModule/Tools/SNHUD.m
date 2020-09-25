//
//  SNHUD.m
//  objective-c
//
//  Created by silence on 2020/9/25.
//  Copyright © 2020 Silence. All rights reserved.
//

#import "SNHUD.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation SNHUD
+ (void)initHUD {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
}

+ (void)show {
    [SVProgressHUD show];
}

+ (void)showString:(NSString *)string {
    [SVProgressHUD showWithStatus:string];
}

+ (void)showError:(NSString *)string {
    [SVProgressHUD showErrorWithStatus:string];
}

+ (void)showSuccess:(NSString *)string {
    [SVProgressHUD showSuccessWithStatus:string];
}

+ (void)showProgress:(CGFloat)progress {
    [SVProgressHUD showProgress:progress];
}

+ (void)hiddenWithBlock:(void (^)(void))block {
    [SVProgressHUD dismissWithCompletion:block];
}

+ (void)hiddenWithDelay:(NSTimeInterval)delay Block:(void (^)(void))block {
    [SVProgressHUD dismissWithDelay:delay completion:block];
}
@end
