//
//  QLKHelpWindowManager.h
//  CloudsOutpatient
//
//  Created by 吴林丰 on 2018/11/12.
//  Copyright © 2018 HC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLKHelpWindowManager : NSObject<NSCopying>

@property (nonatomic,copy) void (^ tapActionBlock) (void);

+ (id) shareHelpWindowInstance;
/**
 * 显示需要的帮助图
 */
- (void)showView:(UIView *)view;

/**
 * 隐藏helpWindow
 */
- (void)hideView:(UIView *)view;

@end
