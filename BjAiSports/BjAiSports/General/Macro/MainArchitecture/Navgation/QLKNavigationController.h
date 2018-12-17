//
//  QLKNavigationController.h
//  CloudsOutpatient
//
//  Created by czy on 15/6/17.
//  Copyright (c) 2015年 HC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QLKBaseViewController;
@interface QLKNavigationController : UINavigationController

@property (strong,nonatomic) UIImageView *navBarHairlineImageView;//导航栏底部阴影

- (id)initWithRootViewController:(UIViewController *)rootViewController;

- (id)initWithRootViewController:(NSString *)className withData:(id)data;

- (QLKBaseViewController *)currentController;

- (void)pushViewController:(NSString *)className withData:(id)data animated:(BOOL)animated;

@end
