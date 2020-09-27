//
//  SNNodataView.h
//  objective-c
//
//  Created by silence on 2020/9/23.
//  Copyright © 2020 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NODataViewBlock)(void);

@interface SNNodataView : UIView

/*占位图*/
@property (nonatomic, strong) UIButton * imgBtn;
/*描述信息*/
@property (nonatomic, strong) UILabel  * desLb;
/*点击事件回调*/
@property (nonatomic, copy, readonly) NODataViewBlock clickBlock;

@end

NS_ASSUME_NONNULL_END
