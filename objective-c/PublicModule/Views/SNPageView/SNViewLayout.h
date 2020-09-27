//
//  SNViewLayout.h
//  objective-c
//
//  Created by silence on 2020/9/27.
//  Copyright © 2020 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SNViewLayoutType) {
    SNViewLayoutNormal,
    SNViewLayoutLinear,
    SNViewLayoutCoverflow,
};

@class SNViewLayout;
@protocol SNViewLayoutDelegate <NSObject>

// initialize layout attributes
- (void)pagerViewTransformLayout:(SNViewLayout *)pagerViewTransformLayout
   initializeTransformAttributes:(UICollectionViewLayoutAttributes *)attributes;

// apply layout attributes
- (void)pagerViewTransformLayout:(SNViewLayout *)pagerViewTransformLayout
      applyTransformToAttributes:(UICollectionViewLayoutAttributes *)attributes;

@end


@interface SNLayoutObject : NSObject

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) UIEdgeInsets sectionInset;

@property (nonatomic, assign) SNViewLayoutType layoutType;

@property (nonatomic, assign) CGFloat minimumScale; // sacle default 0.8
@property (nonatomic, assign) CGFloat minimumAlpha; // alpha default 1.0
@property (nonatomic, assign) CGFloat maximumAngle; // angle is % default 0.2

@property (nonatomic, assign) BOOL isInfiniteLoop;  // infinte scroll
@property (nonatomic, assign) CGFloat rateOfChange; // scale and angle change rate
@property (nonatomic, assign) BOOL adjustSpacingWhenScroling;

/**
 pageView cell item vertical centering
 */
@property (nonatomic, assign) BOOL itemVerticalCenter;

/**
 first and last item horizontalc enter, when isInfiniteLoop is NO
 */
@property (nonatomic, assign) BOOL itemHorizontalCenter;

// sectionInset
@property (nonatomic, assign, readonly) UIEdgeInsets onlyOneSectionInset;
@property (nonatomic, assign, readonly) UIEdgeInsets firstSectionInset;
@property (nonatomic, assign, readonly) UIEdgeInsets lastSectionInset;
@property (nonatomic, assign, readonly) UIEdgeInsets middleSectionInset;

@end



@interface SNViewLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) SNLayoutObject *layout;
@property (nonatomic, weak, nullable) id<SNViewLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
