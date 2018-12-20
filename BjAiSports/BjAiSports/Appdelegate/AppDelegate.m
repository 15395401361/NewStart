//
//  AppDelegate.m
//  BjAiSports
//
//  Created by 吴林丰 on 2018/12/17.
//  Copyright © 2018 吴林丰. All rights reserved.
//

#import "AppDelegate.h"
#import "BJAMineController.h"   // 我的
#import "BJASocialController.h" // 社会
#import "BJAHomeController.h"  // 首页
#import "BJACourseController.h" // 课程
#import "QLKNavigationController.h"


@interface AppDelegate ()





@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self setupViewControllers];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    [self customizeInterface];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark - Methods

- (void)setupViewControllers {
    BJAHomeController *homeVC = [[BJAHomeController alloc] init];
    homeVC.title = @"首页";
    QLKNavigationController *homeNavi = [[QLKNavigationController alloc] initWithRootViewController:homeVC];

    BJASocialController *socialVC = [[BJASocialController alloc] init];
    socialVC.title = @"社交";
    QLKNavigationController *socialNavi = [[QLKNavigationController alloc]
                                                    initWithRootViewController:socialVC];

    BJACourseController *courseVC = [[BJACourseController alloc] init];
    courseVC.title = @"课程";
    QLKNavigationController *courseNavi = [[QLKNavigationController alloc]
                                                    initWithRootViewController:courseVC];
    BJAMineController *mineVC = [[BJAMineController alloc] init];
    mineVC.title = @"我的";
    QLKNavigationController *mineNavi = [[QLKNavigationController alloc]
                                           initWithRootViewController:mineVC];

    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[homeNavi, socialNavi,
                                           courseNavi,mineNavi]];
    self.tabBarController = tabBarController;
    [self customizeTabBarForController:tabBarController];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    NSArray *tabBarItemImages = @[@"home", @"huanzhe", @"wode",@"huanzhe"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"NewHomeBar_%@Select",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"NewHomeBar_%@Nomal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        index++;
    }
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}


@end
