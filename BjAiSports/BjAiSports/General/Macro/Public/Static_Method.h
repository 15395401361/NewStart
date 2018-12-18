//
//  Static_Method.h
//  BjAiSports
//
//  Created by 吴林丰 on 2018/12/17.
//  Copyright © 2018 吴林丰. All rights reserved.
//

#ifndef Static_Method_h
#define Static_Method_h

//弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


#define SharedAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])


//检测字符串
#define IS_NOT_EMPTY(string) (string !=nil && ![string isKindOfClass:[NSNull class]] && ![@"" isEqualToString:string] && ![@"NULL" isEqualToString:string] && ![@"<null>" isEqualToString:string] && ![@"null" isEqualToString:string] && ![@"(null)" isEqualToString:string] && ![[NSNull null] isEqual:string])
#define StrOrNull(x) (x ? x : @"")
#define SReplace(x,t) (x ? x : (StrOrNull(t)))

// 屏幕宽高
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define Height_StatusBar (IS_IPHONE_X==YES)?44.0f: 20.0f

#define Height_NavBar (IS_IPHONE_X==YES) ? 88.0f : 64.0f

#define Height_TabBar (IS_IPHONE_X==YES)?83.0f: 49.0f

//手机系统及型号
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define SYSTEM_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])
#define STORE_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define IS_IOS10() ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)
#define IS_IOS12() ([[UIDevice currentDevice].systemVersion doubleValue] >= 12.0)

// 颜色
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define Color444444 [UIColor colorWithHexString:@"#444444"]//深黑
#define Color666666 [UIColor colorWithHexString:@"#666666"]//淡灰色
#define Color7b7b7b [UIColor colorWithHexString:@"#7b7b7b"]//灰色
#define Colorbbbbbb [UIColor colorWithHexString:@"#bbbbbb"]//黑色


#define SLYY_Camera_permissions @"请通过“设置>隐私>相机”打开爱体育，以允许程序访问您的相机"//相机权限

#define SLYY_Photo_album_permissions @"请通过“设置>隐私>相册”打开爱体育，以允许程序访问您的相册"//相册权限


#endif /* Static_Method_h */

#ifdef QLKDEBUG
#   define QLKDLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#else
#   define QLKDLog(...)
#endif
