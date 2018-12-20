//
//  QLKAlertView.h
//  CloudsOutpatient
//
//  Created by 柴志勇 on 16/3/29.
//  Copyright © 2016年 HC. All rights reserved.
//  

#import "CustomMaskView.h"
typedef enum
{
  QLKAlertViewAnimationTypeNone        = 0,
  QLKAlertViewAnimationTypeDefault     = 1,
  
} QLKAlertViewAnimationType;

typedef void (^QLKAlertViewBlock)(void);

@interface QLKCommonAlertView : UIView

@property (nonatomic, strong) UILabel * messageLabel; // 颜色 灰色 字体 14



@property (nonatomic, assign) CGRect customFrame; //控件大小
@property (nonatomic, strong) UIView *contentView; //自定义类型

@property (nonatomic, assign) CGFloat buttonHeight; // H： 44
@property (nonatomic, assign) CGFloat titleHeight; // H: 34
@property (nonatomic, assign) CGFloat midMessageHeight; // H: 34

@property (nonatomic, assign) CGFloat titleTopPadding; //标题距离上边界偏移量
@property (nonatomic, assign) CGFloat titleBottomPadding;  //标题距离下边界偏移量
@property (nonatomic, assign) CGFloat messageBottomPadding; //文本距离下边界偏移量
@property (nonatomic, assign) CGFloat midMessageBottomPadding; //中间文本距离下边界偏移量
@property (nonatomic, assign) CGFloat messageLeftRightPadding; //文本距离左边界偏移量

//设置背景的边框样式
@property (nonatomic, strong) UIColor * borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, strong) UIImage * backgroundImage; //背景图片

@property (nonatomic, assign) BOOL hideSeperator;
@property (nonatomic, strong) UIColor * separatorColor;

//弹框显示消失动画类型
@property (nonatomic, assign) QLKAlertViewAnimationType appearAnimationType;
@property (nonatomic, assign) QLKAlertViewAnimationType disappearAnimationType;

//弹框动画时间
@property (nonatomic, assign) NSTimeInterval appearTime;
@property (nonatomic, assign) NSTimeInterval disappearTime;

//设置控件按钮属性
//按钮色值
@property (nonatomic, strong) UIColor *originCancelButtonColor;//取消按钮的颜色

@property (nonatomic, strong) UIColor *originOtherButtonColor;//确定按钮的颜色

@property (nonatomic, assign) BOOL cancelButtonPositionRight;

@property (nonatomic, assign) BOOL buttonClickedHighlight;

@property (nonatomic, assign) BOOL shouldDismissOnActionButtonClicked;

@property (nonatomic, assign) BOOL shouldDismissOnOutsideTapped;

@property (nonatomic, assign) BOOL shouldDimBackgroundWhenShowInWindow;

@property (nonatomic, assign) BOOL shouldDimBackgroundWhenShowInView;

@property (nonatomic, assign) CGFloat dimAlpha;

@property (readwrite, copy) QLKAlertViewBlock midButtonHandlerAction;
@property (readwrite, copy) QLKAlertViewBlock cancelButtonAction;
@property (readwrite, copy) QLKAlertViewBlock otherButtonAction;

/**
 *  创建
 *
 *  @param title   标题
 *  @param message 文本内容
 *  @param cancelButtonTitle  取消文本
 *  @param otherButtonTitle   其他文本
 */

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message  midMessage:(NSString *)midMessage cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle;
/**
 *  回调设置
 *  @param midButtonHandler 中间点击按钮
 *  @param cancelHandler  取消按钮回调
 *  @param otherHandler   其他按钮回调
 */
- (void)actionWithBlockssMidMesageButtonHandler:(void (^)(void))midButtonHandler  cancelButtonHandler:(void (^)(void))cancelHandler
                             otherButtonHandler:(void (^)(void))otherHandler;

/**
 *  当前页面显示
 *
 *  @param view  当前View
 */
- (void)showInView:(UIView *)view;

/**
 *  默认显示方式
 */

- (void)show;

/**
 *  按照颜色显示
 */

- (void)showWithColor:(UIColor *)okColor andCancelColor:(UIColor *)cancelColor;


/**
 *  消失
 */
- (void)dismiss;

@end
