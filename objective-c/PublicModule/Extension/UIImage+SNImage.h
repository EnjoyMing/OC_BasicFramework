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

/* 改变uiimage图片的大小*/
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

/* 创建圆角图像*/
- (UIImage *)roundedCornerImageWithCornerRadius:(CGFloat)cornerRadius;

/* 颜色转图片 */
- (UIImage *)createImageWithColor:(UIColor *)color;

/* 给图片添加图片水印
 * @param backgroundImage   背景图片
 * @param markName 右下角的水印图片
 */
+ (instancetype)waterMarkWithImageName:(NSString *)backgroundImage
                      andMarkImageName:(NSString *)markName;

/* 给图片添加文字水印
 * @param image 背景图片
 * @param text 待添加的文本
 * @param point 起点
 * @param attributed 待添加的文本特性
*/
+ (UIImage *)jx_WaterImageWithImage:(UIImage *)image
                               text:(NSString *)text
                          textPoint:(CGPoint)point
                   attributedString:(NSDictionary * )attributed;
@end

NS_ASSUME_NONNULL_END
