//
//  UIAlertView+Ext.m
//  CloudsOutpatient
//
//  Created by 柴志勇 on 16/3/29.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "QLKCommonAlertView+Ext.h"

@implementation QLKCommonAlertView (Ext)

#pragma mark --- 不可自定义颜色的双按钮弹窗

+ (id)showAlertView:(NSString *)title message:(NSString *)message click:(QLKWhenClickedBlock)clickMessageClick midMessage:(NSString *)midMessage  click:(QLKWhenClickedBlock)click onText:(NSString *)okText cancel:(QLKWhenClickedBlock)cancel cancelText:(NSString *)cancelText
{
    QLKCommonAlertView *alertView = [[QLKCommonAlertView alloc]initWithTitle:title message:message midMessage:midMessage cancelButtonTitle: cancelText otherButtonTitle:okText];
    [alertView  actionWithBlockssMidMesageButtonHandler:clickMessageClick cancelButtonHandler:cancel otherButtonHandler:click ];
    [alertView show];
    return alertView;
}


+ (id)showAlertView:(NSString *)title message:(NSString *)message  click:(QLKWhenClickedBlock)click onText:(NSString *)okText cancel:(QLKWhenClickedBlock)cancel cancelText:(NSString *)cancelText
{
    
    
    QLKCommonAlertView *alertView = [[QLKCommonAlertView alloc]initWithTitle:title message:message midMessage:nil cancelButtonTitle: cancelText otherButtonTitle:okText];
    [alertView  actionWithBlockssMidMesageButtonHandler:nil cancelButtonHandler:cancel otherButtonHandler:click ];
    [alertView show];
    return alertView;
}

#pragma mark --- 不可自定义颜色的单按钮弹窗
+ (id)showAlertView:(NSString *)title message:(NSString *)message click:(QLKWhenClickedBlock)click  okText:(NSString *)okText{
     QLKCommonAlertView *alertView = [[QLKCommonAlertView alloc] initWithTitle:title message:message midMessage:nil cancelButtonTitle:nil otherButtonTitle:okText];
  
    [alertView  actionWithBlockssMidMesageButtonHandler:nil cancelButtonHandler:nil otherButtonHandler:click ];
     [alertView show];
     return alertView;
}

#pragma mark --- 可自定义颜色的双按钮弹窗
+ (id)showAlertView:(NSString *)title message:(NSString *)message click:(QLKWhenClickedBlock)click onText:(NSString *)okText okColor:(UIColor *)okColor cancel:(QLKWhenClickedBlock)cancel cancelText:(NSString *)cancelText cancelColor:(UIColor *)cancelColor{
    QLKCommonAlertView *alertView = [[QLKCommonAlertView alloc]initWithTitle:title message:message midMessage:nil cancelButtonTitle: cancelText otherButtonTitle:okText];
    [alertView  actionWithBlockssMidMesageButtonHandler:nil cancelButtonHandler:cancel otherButtonHandler:click ];
    [alertView showWithColor:okColor andCancelColor:cancelColor];
    return alertView;
}

#pragma mark --- 可自定义颜色的单按钮弹窗
+ (id)showAlertView:(NSString *)title message:(NSString *)message click:(QLKWhenClickedBlock)click okText:(NSString *)okText okColor:(UIColor *)okColor{

    QLKCommonAlertView *alertView = [[QLKCommonAlertView alloc] initWithTitle:title message:message midMessage:nil cancelButtonTitle:nil otherButtonTitle:okText];
     [alertView  actionWithBlockssMidMesageButtonHandler:nil cancelButtonHandler:nil otherButtonHandler:click ];
    [alertView showWithColor:okColor andCancelColor:nil];
    return alertView;
}

@end
