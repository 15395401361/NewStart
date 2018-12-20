//
//  QLKHelpWindowManager.m
//  CloudsOutpatient
//
//  Created by 吴林丰 on 2018/11/12.
//  Copyright © 2018 HC. All rights reserved.
//

#import "QLKHelpWindowManager.h"
#import "QLKHelpWindow.h"
static QLKHelpWindowManager *helpWindow;


@interface QLKHelpWindowManager ()

@property (nonatomic,strong) QLKHelpWindow *showHelpWindow;
@end

@implementation QLKHelpWindowManager

- (QLKHelpWindow *)showHelpWindow{
    if (_showHelpWindow == nil) {
        _showHelpWindow = [[QLKHelpWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UITapGestureRecognizer *windowTap = [[UITapGestureRecognizer alloc] initWithTarget:helpWindow action:@selector(windowTapAction)];
        [_showHelpWindow addGestureRecognizer:windowTap];
        
        UIPanGestureRecognizer *panWindow = [[UIPanGestureRecognizer alloc] initWithTarget:helpWindow action:@selector(windowTapAction)];
        [_showHelpWindow addGestureRecognizer:panWindow];
        
    }
    return _showHelpWindow;
}


+ (id)shareHelpWindowInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helpWindow = [[QLKHelpWindowManager alloc]init];
    });
    return helpWindow;
}

/**
 *  重写allocWithZone
 */

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helpWindow = [super allocWithZone:zone];
    });
    return helpWindow;
}

//如果需要使用自定义Copy方法,就需要重写copyWithZone,同时需要遵循nscoding 协议
- (id)copyWithZone:(NSZone *)zone{
    QLKHelpWindowManager *model = [[QLKHelpWindowManager alloc] init];
    return model;
}

- (void)showView:(UIView *)view{
    if (helpWindow.showHelpWindow) {
        [helpWindow hideView:view];
    }
    [helpWindow.showHelpWindow addSubview:view];
    helpWindow.showHelpWindow.hidden = NO;
}

- (void)hideView:(UIView *)view{
    [view removeFromSuperview];
    helpWindow.showHelpWindow.hidden = YES;
    helpWindow.showHelpWindow = nil;
}

- (void)windowTapAction{
    if (helpWindow.tapActionBlock) {
        helpWindow.tapActionBlock();
    }
}

@end
