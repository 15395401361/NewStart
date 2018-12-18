//
//  UIView+Ext.h
//  Qilekang
//
//  Created by wj on 14-7-9.
//  Copyright (c) 2014年 Qilekang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, UIViewBorderSideType) {
    UIViewBorderSideTypeAll = 0,
    UIViewBorderSideTypeTop = 1 << 0,
    UIViewBorderSideTypeBottom = 1 << 1,
    UIViewBorderSideTypeLeft = 1 << 2,
    UIViewBorderSideTypeRight = 1 << 3,
};


/**
 *  UIView Frame操作
 */
@interface UIView (Frame)

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIViewBorderSideType)borderType;//UIView 加边框
- (void)moveBy:(CGPoint) delta;
- (void)scaleBy:(CGFloat) scaleFactor;
- (void)fitInSize:(CGSize) aSize;

// 简化设置
- (CGFloat)frameHight;
- (CGFloat)frameWidth;
- (CGFloat)originX;
- (CGFloat)originY;
- (CGPoint)frameOrigin;
- (CGSize)frameSize;

- (void)uniformScale;

- (void)setFrameHight:(CGFloat)hight;
- (void)setFrameWidth:(CGFloat)width;
- (void)setOriginX:(CGFloat)originX;
- (void)setOriginY:(CGFloat)originY;
- (void)setFrameSize:(CGSize)size;

@end

/**
 *  手势
 */
typedef void (^JMWhenTappedBlock)(void);
@interface UIView (JMWhenTappedBlocks) <UIGestureRecognizerDelegate>

- (void)whenTapped:(JMWhenTappedBlock)block;
- (void)whenDoubleTapped:(JMWhenTappedBlock)block;
- (void)whenTwoFingerTapped:(JMWhenTappedBlock)block;
- (void)whenTouchedDown:(JMWhenTappedBlock)block;
- (void)whenTouchedUp:(JMWhenTappedBlock)block;

@end

/**
 *  UIView 截屏
 */
@interface UIView (SCreenShot)

- (UIImage *)convertViewToImage:(UIView*)v;

@end

/**
 *  从Nib加载
 */
@interface UIView (Nib)

+ (id)classFromNib:(NSString *)className;

/**
 *  通过xib获取View
 *
 *  @return QLKBalanceTipsView
 */
+(id)xibView;

- (UIViewController *)findViewController;

/**
 *  查找父控件
 *  className 类名
 *  sourceView 源View
 */

+ (id )findViewWithClassName: (Class)className view:(UIView *)sourceView;

@end


/**
 *  UIView 动画
 */
@interface UIView (Animation) <CAAnimationDelegate>

/**
 * gradient animaiton
 * @param from 起始alpha值
 * @param to   终止alpha值
 * @param duration 动画时间
 * @param beginTime 动画延迟时间
 */
- (CAAnimation *)animationWithOpacityFrom:(CGFloat) from To:(CGFloat) to Duration:(CGFloat) duration BeginTime:(CGFloat)beginTime;

//用于获取View所属的controller
+(UIViewController*)viewController:(UIView*)view;
//用于获取cell
+(UITableViewCell*)getCellFromSubView:(UIView*)subview;

@end
