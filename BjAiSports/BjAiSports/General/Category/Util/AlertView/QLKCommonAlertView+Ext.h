//
//  UIAlertView+Ext.h
//  CloudsOutpatient
//
//  Created by 柴志勇 on 16/3/29.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QLKCommonAlertView.h"
typedef void (^QLKWhenClickedBlock)(void);

@interface QLKCommonAlertView (Ext)


+ (id)showAlertView:(NSString *)title message:(NSString *)message click:(QLKWhenClickedBlock)clickMessageClick midMessage:(NSString *)midMessage  click:(QLKWhenClickedBlock)click onText:(NSString *)okText cancel:(QLKWhenClickedBlock)cancel cancelText:(NSString *)cancelText;
/**
 *  弹窗Alert 使用默认颜色的alert 
 *  具有确定和取消按钮
 */
+ (id)showAlertView:(NSString *)title message:(NSString *)message click:(QLKWhenClickedBlock)click onText:(NSString *)okText cancel:(QLKWhenClickedBlock)cancel cancelText:(NSString *)cancelText;

/**
 *  弹窗Alert 使用默认颜色的alert
 *  只具备一个确定按钮
 */
+ (id)showAlertView:(NSString *)title message:(NSString *)message click:(QLKWhenClickedBlock)click  okText:(NSString *)okText;

/**
 * 寒山石  
 * 增加可以自定义颜色的按钮弹窗
 * 具有确定和取消按钮
 */
+ (id)showAlertView:(NSString *)title message:(NSString *)message click:(QLKWhenClickedBlock)click onText:(NSString *)okText okColor:(UIColor *)okColor cancel:(QLKWhenClickedBlock)cancel cancelText:(NSString *)cancelText cancelColor:(UIColor *)cancelColor;

/**
 * 寒山石
 * 增加可以自定义颜色的按钮弹窗
 * 只具备一个确定按钮
 */
+ (id)showAlertView:(NSString *)title message:(NSString *)message click:(QLKWhenClickedBlock)click okText:(NSString *)okText okColor:(UIColor *)okColor;

@end
