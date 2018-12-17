//
//  QLKNavigationController.m
//  CloudsOutpatient
//
//  Created by czy on 15/6/17.
//  Copyright (c) 2015年 HC. All rights reserved.
//

#import "QLKNavigationController.h"
#import "QLKBaseViewController.h"
@interface QLKNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@end

@implementation QLKNavigationController

- (UIImageView *)navBarHairlineImageView{
//    if (_navBarHairlineImageView == nil) {
//        _navBarHairlineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,[[UIApplication sharedApplication] statusBarFrame].size.height+44, SCREEN_WIDTH, 1)];
//        [self.view addSubview:_navBarHairlineImageView];
//    }
    return _navBarHairlineImageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    WS(weakSelf);
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.interactivePopGestureRecognizer.delegate = weakSelf;
//        self.delegate =  weakSelf;
//    }
    self.navBarHairlineImageView.hidden = NO;

    self.navBarHairlineImageView.image = [UIImage imageNamed:@"navBarLine"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    if ([[rootViewController class] isSubclassOfClass:[QLKBaseViewController class]]) {
        
        self = [super initWithRootViewController:rootViewController];
        
        self.delegate = self;
        
        return self;
    }
    
    NSAssert(NO, @"rootViewController 不是 KXBaseViewController 的子类");
    
    return nil;
}

- (id)initWithRootViewController:(NSString *)className withData:(id)data
{
    QLKBaseViewController *controller = [QLKBaseViewController getController:className withData:data];
    
    self.delegate = self;
    return [self initWithRootViewController:controller];
}

- (QLKBaseViewController *)currentController
{
    return (QLKBaseViewController *)self.topViewController;
}

- (void)pushViewController:(NSString *)className withData:(id)data animated:(BOOL)animated
{
    QLKBaseViewController *controller = [QLKBaseViewController getController:className withData:data];
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [self pushViewController:controller animated:animated];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    if(SYSTEM_VERSION >= 8 ){
//        if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//            navigationController.interactivePopGestureRecognizer.enabled = YES;
//            if (SharedAppDelegate.isLunchAdImageFromNotification && SharedAppDelegate.isClickLunchAdImageFromNotification) {//禁用从push+点击启动图的手势
//                navigationController.interactivePopGestureRecognizer.enabled = NO;
//            }
//        }
//        if (navigationController.viewControllers.count == 1) {
//            navigationController.interactivePopGestureRecognizer.enabled = NO;
//        }
//    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{

}

@end
