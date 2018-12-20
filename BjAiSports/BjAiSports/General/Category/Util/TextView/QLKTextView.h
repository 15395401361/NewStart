//
//  QLKTextView.h
//  CloudsOutpatient
//
//  Created by 柴志勇 on 16/3/29.
//  Copyright © 2016年 HC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QLKTextView;

typedef void (^textViewEventBlock)(QLKTextView* textView);

@interface QLKTextView : UITextView
@property(assign,nonatomic) NSInteger textMaxLength;  //限制长度
@property(copy,nonatomic) textViewEventBlock  eventEditingDidBegin; //开始编辑回调
@property(copy,nonatomic) textViewEventBlock  eventEditingDidChanged; //编辑中回调，是截取后回调
@property(copy,nonatomic) textViewEventBlock  eventEditingDidDidEnd;  //编辑结束

@end
