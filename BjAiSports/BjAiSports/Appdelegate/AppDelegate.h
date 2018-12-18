//
//  AppDelegate.h
//  BjAiSports
//
//  Created by 吴林丰 on 2018/12/17.
//  Copyright © 2018 吴林丰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,assign) BOOL isLunchFromNotification;//是否通知打开App
@property (strong, nonatomic) RDVTabBarController *tabBarController;//菜单栏
@end

