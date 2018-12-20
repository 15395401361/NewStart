//
//  QLKTextField.h
//  CloudsOutpatient
//
//  Created by 柴志勇 on 16/3/29.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLKUITextField.h"
@class QLKTextField;

typedef void (^textFieldEventBlock)(QLKTextField* textField);

@interface QLKTextField : QLKUITextField
@property(assign,nonatomic) NSInteger textMaxLength;  //限制长度
@property(copy,nonatomic) textFieldEventBlock  eventEditingDidBegin; //开始编辑回调
@property(copy,nonatomic) textFieldEventBlock  eventEditingDidChanged; //编辑中回调，是截取后回调
@property(copy,nonatomic) textFieldEventBlock  eventEditingDidDidEnd;  //编辑结束

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
@end
