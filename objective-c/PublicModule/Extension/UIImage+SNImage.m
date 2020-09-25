//
//  UIImage+SNImage.m
//  objective-c
//
//  Created by silence on 2020/9/23.
//  Copyright © 2020 Silence. All rights reserved.
//

#import "UIImage+SNImage.h"
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

@implementation UIImage (SNImage)
/*
 将图片内容本身旋转一定角度，不是旋转将UIImageView视图旋转
 @param degree 旋转的弧度 比如旋转45度应该传入 45*3.14/180
 @return 返回旋转成功后的图片
 */
- (UIImage *)imageRoateInegree:(float)degree {
    //图片实际像素 等于图片像素 *放大因子scale
    size_t width = (size_t)self.size.width * self.scale;
    size_t height = (size_t)self.size.height * self.scale;
    //表示每行图片字节数
    size_t bytesRerRow = width * 4;
    CGImageAlphaInfo alphaInfo = kCGImageAlphaPremultipliedFirst;
    //配置上下文参数
    /*
     第一个参数 要渲染的绘制内存地址，这个内存块的大小至少是（bytesPerRow*height）个字节。如果传空值，则是由上下文自动分配的
     第二个参数 实际宽度像素
     第三个参数 实际像素高度
     第四个参数 内存中像素每个组件位数 对于32位像素格式和RGB 颜色空间，你应该将这个值设为8.
     第五个参数 每行所占字节数
     第六个参数 上下文使用的颜色空间
     第七个参数 alpha通道 指定bitmap是否包含alpha通道，像素中alpha通道的相对位置
    **/
    CGContextRef imageContext = CGBitmapContextCreate(NULL, width, height, 8, bytesRerRow, CGColorSpaceCreateDeviceRGB(), kCGBitmapByteOrderDefault | alphaInfo);
    if (!imageContext) {
        return nil;
    }
    CGContextDrawImage(imageContext, CGRectMake(0, 0, width, height), self.CGImage);
    /**
     旋转图片
     ARGB88 表示32位像素RGB位图 正好对应上面传入的组件位数 8
     第一个参数 旋转之前图片
     第二个参数 旋转之后图片
     第三个参数 缓冲区，当需要相当短的时间内频繁调用函数，或者需要实时
     *性能保证（使锁问题）那么你应该分配自己的临时缓冲区。可传空，有上下文自己分配
     第四个参数 旋转角度
     第五个参数 背景颜色
     第六个参数 填充颜色
     */
    uint8_t *imagedata = (uint8_t *)CGBitmapContextGetData(imageContext);
    vImage_Buffer src = {imagedata,height,width,bytesRerRow};
    vImage_Buffer dest = {imagedata,height,width,bytesRerRow};
    //白色
    Pixel_8888 backColor = {0,0,0,0};
    vImageRotate_ARGB8888(&src, &dest,NULL,degree, backColor, kvImageBackgroundColorFill);
    CGImageRef rotateImageRef = CGBitmapContextCreateImage(imageContext);
    UIImage *rotateImage = [UIImage imageWithCGImage:rotateImageRef scale:self.scale orientation:self.imageOrientation];
    CFRelease(rotateImageRef);
    return rotateImage ;
}
//TODO:改变uiimage图片的大小
- (UIImage *)imageByScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) ==NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor < heightFactor){
            scaleFactor = widthFactor;
        }else{
            scaleFactor = heightFactor;
        }
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
       // center the image
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
   // this is actually the interesting part:
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(newImage == nil){
       NSLog(@"could not scale image");
    }
    return newImage ;
}
//TODO:创建圆角图像
- (UIImage *)roundedCornerImageWithCornerRadius:(CGFloat)cornerRadius {
    CGFloat w = self.size.width;
    CGFloat h = self.size.height;
    CGFloat scale = [UIScreen mainScreen].scale;
    // 防止圆角半径小于0，或者大于宽/高中较小值的一半。
    if (cornerRadius < 0){
        cornerRadius = 0;
    }else if (cornerRadius > MIN(w, h)){
        cornerRadius = MIN(w, h) / 2.;
    }
    UIImage *image = nil;
    CGRect imageFrame = CGRectMake(0., 0., w, h);
    UIGraphicsBeginImageContextWithOptions(self.size, NO, scale);
    [[UIBezierPath bezierPathWithRoundedRect:imageFrame cornerRadius:cornerRadius] addClip];
    [self drawInRect:imageFrame];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
//TODO:颜色转图片
- (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
