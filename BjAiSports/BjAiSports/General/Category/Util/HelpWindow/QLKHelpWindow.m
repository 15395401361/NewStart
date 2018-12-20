//
//  QLKHelpWindow.m
//  CloudsOutpatient
//
//  Created by 吴林丰 on 2018/11/12.
//  Copyright © 2018 HC. All rights reserved.
//

#import "QLKHelpWindow.h"

@implementation QLKHelpWindow

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.windowLevel=UIWindowLevelAlert;
        //隐藏键盘
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
        
    }
    return self;
}

- (void)showInHelpWindow:(UIView *)view{
    [self hideHelpWindow];
}

- (void)hideHelpWindow{
    self.hidden = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
