//
//  QLKUITextField.m
//  CloudsOutpatient
//
//  Created by 吴林丰 on 2016/12/20.
//  Copyright © 2016年 HC. All rights reserved.
//

#import "QLKUITextField.h"

@implementation QLKUITextField

- (void)layoutSubviews{
    [super layoutSubviews];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
        for (UIScrollView *view in self.subviews) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                CGPoint offset = view.contentOffset;
                if (offset.y != 0) {
                    offset.y = 0;
                    view.contentOffset = offset;
                }
                break;
            }
        }
    }
}

@end
