//
//  UIImage+SNImage.h
//  objective-c
//
//  Created by silence on 2020/9/23.
//  Copyright © 2020 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SNImage)
/*
 将图片内容本身旋转一定角度，不是旋转将UIImageView视图旋转
 @param degree 旋转的弧度 比如旋转45度应该传入 45*3.14/180
 @return 返回旋转成功后的图片
 */
- (UIImage *)imageRoateInegree:(float)degree;
//改变uiimage图片的大小
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
//创建圆角图像
- (UIImage *)roundedCornerImageWithCornerRadius:(CGFloat)cornerRadius;
//颜色转图片
- (UIImage *)createImageWithColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
