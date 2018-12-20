//
//  QLKBaseViewController.h
//  CloudsOutpatient
//
//  Created by zzs on 15/6/15.
//  Copyright (c) 2015年 HC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QLKBaseViewController : UIViewController
{
    
    
    
}

+ (id)getController:(NSString *)className withData:(id)data;
/**
 *  显示无数据背景
 *
 *  @param title 空背景文字
 */
- (void)showEmptyDataBackgroundViewWithTitle:(NSString*)title  description:(NSString*)description;

/**
 *  显示无数据背景
 *
 *  @param title 空背景文字
 */
- (void)showEmptyDataBackgroundViewWithImage:(UIImage *)logo title:(NSString*)title  description:(NSString*)description;

/**
 *  隐藏无数据背景
 *
 */
- (void)hideShowEmptyDataBackgroundView;

///**
// *  设置导航栏中间搜索
// *
// */
//- (void)setNaviMiddleSearchView;

/**
 *  设置导航栏TitleView
 *
 *  @param view 中间View
 */
- (void)setNaviMiddleButtonWithView:(UIView *)view;

/**
 *  设置导航栏中间标题
 *
 *  @param title 标题名
 */
- (void)setNaviTitle:(NSString* )title;
/**
 *  设置导航栏中间标题 附标题
 *
 *  @param title 标题名
 *  @param subTitle 子标题
 */
- (void)setNaviTitle:(NSString* )title subTitle:(NSString* )subTitle;
- (void)setNaviTitle:(NSString* )title subTitle:(NSString* )subTitle subColor:(UIColor* )subcolor;
/**
 *  设置导航栏左按钮
 *
 *  @param title 按钮名称
 */
- (void)setNaviLeftButton:(NSString* )title;
- (void)setNaviLeftButton;
- (void)setNaviLeftImgButton:(NSString* )imgName;
- (void)setNaviLeftButtonWith:(NSString* )title;
/**
 *  设置导航栏右按钮
 *
 *  @param title 按钮名称
 */
- (void)setNaviRightButton:(NSString* )title;
- (void)setNaviRightButton:(NSString* )title color:(UIColor*)color;
/**
 *  设置导航栏右按钮
 *
 *  @param title 按钮名称
 *  @param action 是否可点击
 
 */
- (void)setNaviRightButton:(NSString* )title action:(BOOL)action;
/**
 *  设置导航栏右按钮
 *
 *  @param imgName 图片名称
 */
- (void)setNaviRightImgButton:(NSString* )imgName;
/**
 *  声明在基类，由子类实现,目前应用场景是在由当前推送进入某页面的场景，需要dismiss当前视图加window上的视图
 */
-(void)removeAllWindowAlertFromParentViewController;
@end
