//
//  QLKBaseViewController.m
//  CloudsOutpatient
//
//  Created by zzs on 15/6/15.
//  Copyright (c) 2015年 HC. All rights reserved.
//

#import "QLKBaseViewController.h"

#define titleFont 17.0

@interface QLKBaseViewController ()<UITextFieldDelegate>
{
    int     _lastPosition2;                     // 记录上次滑动的位置
    BOOL    _isDecelerate;                      // 是否减速
    BOOL    _isDrag;                            //是否滑动
}

@property (retain,nonatomic) UIView* emptyDataBackgroundView;
@property (retain,nonatomic) UIImageView* logo;
@property (retain,nonatomic) UILabel* titleLabel;
@property (retain,nonatomic) UILabel* desLabel;

@end

@implementation QLKBaseViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if ((self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
         #ifdef __IPHONE_7_0
        if([UIViewController instancesRespondToSelector:@selector(edgesForExtendedLayout)]) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            //            self.edgesForExtendedLayout = UIRectEdgeAll;
        }
        
        if([UIViewController instancesRespondToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
            [self setNeedsStatusBarAppearanceUpdate];
        }
#endif
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
//    [self.navigationController.navigationBar setBackgroundImage:[UIColor createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];  //去掉导航的下端阴影
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

}

- (void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];
   [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
  
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
}

-(void) viewWillDisappear:(BOOL)animation {
    [super viewWillDisappear:animation];
}

+ (id)getController:(NSString *)className withData:(id)data
{
    Class clazz = nil;
    QLKBaseViewController *controller = nil;
    
    if(className && (clazz = NSClassFromString(className))) {
        controller = [[NSClassFromString(className) alloc] init];
    } else {
        controller = [[QLKBaseViewController alloc] init];
    }
    return controller;
}

- (void)showEmptyDataBackgroundViewWithTitle:(NSString*)title  description:(NSString*)description
{
    [self showEmptyDataBackgroundViewWithImage:[UIImage imageNamed:@""] title:title description:description];
}

//显示空数据背景
- (void)showEmptyDataBackgroundViewWithImage:(UIImage *)logo title:(NSString*)title  description:(NSString*)description
{
    /***
    if (!self.emptyDataBackgroundView) {
        _emptyDataBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenFrameWitdh, 267)];
        _emptyDataBackgroundView.backgroundColor = Colorf7f7f7;
        [self.view addSubview:_emptyDataBackgroundView];
        [_emptyDataBackgroundView addSubview:_logo];
        __weak __typeof(&*self)weakSelf = self;
        [_emptyDataBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.view).width.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        _logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 122, 129)];
        
        [_emptyDataBackgroundView addSubview:_logo];
        [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.emptyDataBackgroundView);
            make.top.equalTo(weakSelf.view).with.offset(31);
        }];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainScreenFrameWitdh, 16)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = Color707070;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        
        [_emptyDataBackgroundView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.emptyDataBackgroundView);
            make.top.equalTo(weakSelf.logo.mas_bottom).with.offset(15);
        }];
        
        _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainScreenFrameWitdh, 12)];
        _desLabel.textAlignment = NSTextAlignmentCenter;
        _desLabel.textColor = Color707070;
        _desLabel.font = [UIFont systemFontOfSize:14];
        
        [_emptyDataBackgroundView addSubview:_desLabel];
        [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.emptyDataBackgroundView);
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).with.offset(5);
        }];
    }
    self.emptyDataBackgroundView.hidden = NO;
    [self.logo setImage:logo];
    self.titleLabel.text = title;
    self.desLabel.text = description;
     
     **/
}

- (void)hideShowEmptyDataBackgroundView
{
    self.emptyDataBackgroundView.hidden = YES;
}

- (void)setNaviTitle:(NSString* )title {
    self.title = title;
    NSShadow *shadowAttribute = [[NSShadow alloc]init];
    shadowAttribute.shadowColor = [UIColor clearColor];
    shadowAttribute.shadowOffset = CGSizeMake(0, -1);
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                                     Color444444, NSForegroundColorAttributeName,
//                                                                     shadowAttribute, NSShadowAttributeName,
//                                                                     [UIFont systemFontOfSize:titleFont], NSFontAttributeName,
//                                                                     nil]];
}

- (void)setNaviTitle:(NSString* )title withTitleFont:(CGFloat)fontSize {
    self.title = title;
    NSShadow *shadowAttribute = [[NSShadow alloc]init];
    shadowAttribute.shadowColor = [UIColor clearColor];
    shadowAttribute.shadowOffset = CGSizeMake(0, -1);
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                                     Color444444, NSForegroundColorAttributeName,
//                                                                     shadowAttribute, NSShadowAttributeName,
//                                                                     [UIFont systemFontOfSize:fontSize], NSFontAttributeName,
//                                                                     nil]];
}

- (void)setNaviTitle:(NSString* )title subTitle:(NSString* )subTitle {
//    [self setNaviTitle:title subTitle:subTitle subColor:Color666666];
}

- (void)setNaviTitle:(NSString* )title subTitle:(NSString* )subTitle subColor:(UIColor* )subcolor{
    
//    UIView* backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
    
//    UILabel* lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, backgroundView.width, 20)];
//    lable.textColor = Color444444;
//    lable.textAlignment = NSTextAlignmentCenter;
//    lable.text = title;
//    lable.font = [UIFont systemFontOfSize:titleFont];
//    [backgroundView addSubview:lable];
//
//    UILabel* subLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, backgroundView.width, 14)];
//    subLable.textColor = subcolor;
//    subLable.textAlignment = NSTextAlignmentCenter;
//    subLable.text = subTitle;
//    subLable.font = [UIFont systemFontOfSize:12];
//    [backgroundView addSubview:subLable];
//    self.navigationItem.titleView = backgroundView;
}

-(BOOL)judgeChineseOrEnglish:(NSString *)title{
        for(int i=0; i< [title length];i++){
            int a = [title characterAtIndex:i];
            if( a > 0x4e00 && a < 0x9fff)
            {
                return YES;
            }
            
        }
        return NO;
}
//导航titleView点击按钮回调
- (void)clickCenterFoldButton:(id)sender {
  
}


- (void)setNaviMiddleButtonWithView:(UIView *)view{
    self.navigationItem.titleView = view;
}

- (void)setNaviLeftButton {
    [self setNaviLeftButton:@"返回"];
}
- (void)setNaviLeftButton:(NSString* )title
{
    UIImage * lpImage = [UIImage imageNamed:@"navi_return_button.png"];
    UIImage * lpImage2 = [self imageByApplyingAlpha:0.5 image:lpImage];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    [btn setImage:lpImage forState:UIControlStateNormal];
    [btn setImage:lpImage2 forState:UIControlStateHighlighted];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [btn addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = backBtn;
}

- (void)setNaviLeftImgButton:(NSString* )imgName
{
    UIImage * lpImage = [UIImage imageNamed:imgName];
    UIImage * lpImage2 = [self imageByApplyingAlpha:0.5 image:lpImage];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    [btn setImage:lpImage forState:UIControlStateNormal];
    [btn setImage:lpImage2 forState:UIControlStateHighlighted];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -60, 0, 0);
    [btn addTarget:self action:@selector(clickLeftImgButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = backBtn;
}

- (void)setNaviLeftButtonWith:(NSString* )title
{
//  [self setNaviLeftButton:title color:Color7b7b7b];
}

- (void)setNaviLeftButton:(NSString* )title color:(UIColor*)color
{
//  if (IS_NOT_EMPTY(title)) {
//    CGSize textSize = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.0f], NSFontAttributeName, nil]];
//    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftButton setTitleColor: color forState:UIControlStateNormal];
//    leftButton.frame = CGRectMake(0, 0, textSize.width+20, textSize.height+10);
//    [leftButton setTitle:title forState:UIControlStateNormal];
//    [leftButton setContentEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
//    if (self.navigationItem.leftBarButtonItem) {
//      self.navigationItem.leftBarButtonItem=nil;
//    }
//    leftButton.titleLabel.font=[UIFont systemFontOfSize:15];
//    [leftButton addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    [self.navigationItem setLeftBarButtonItem:leftButtonItem animated:YES];
//  }
}

- (void)setNaviRightButton:(NSString* )title
{
//    [self setNaviRightButton:title color:Color7b7b7b];
}

- (void)setNaviRightButton:(NSString* )title color:(UIColor*)color
{
//    if (IS_NOT_EMPTY(title)) {
//        CGSize textSize = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.0f], NSFontAttributeName, nil]];
//        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [rightButton setTitleColor: color forState:UIControlStateNormal];
//        rightButton.frame = CGRectMake(0, 0, textSize.width+20, textSize.height+10);
//        [rightButton setTitle:title forState:UIControlStateNormal];
//        [rightButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -40)];
//        if (self.navigationItem.rightBarButtonItem) {
//          self.navigationItem.rightBarButtonItem=nil;
//        }
//        rightButton.titleLabel.font=[UIFont systemFontOfSize:15];
//        [rightButton addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//        [self.navigationItem setRightBarButtonItem:rightButtonItem animated:YES];
//    }else{
//
//    }
}

- (void)setNaviRightButton:(NSString* )title action:(BOOL)action
{
//  if (IS_NOT_EMPTY(title)) {
//    if(self.navigationItem.rightBarButtonItem){
//        UIButton *rightButton = (UIButton *)self.navigationItem.rightBarButtonItem.customView;
//        [rightButton setUserInteractionEnabled:action];
//        if (action) {
//          [rightButton setTitleColor: Color7b7b7b forState:UIControlStateNormal];
//        }else{
//          [rightButton setTitleColor: Colorbbbbbb forState:UIControlStateNormal];
//        }
//    }else{
//
//        CGSize textSize = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.0f], NSFontAttributeName, nil]];
//        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        rightButton.frame = CGRectMake(0, 0, textSize.width+20, textSize.height+10);
//        [rightButton setTitle:title forState:UIControlStateNormal];
//        [rightButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -40)];
//        rightButton.titleLabel.font=[UIFont systemFontOfSize:15];
//        [rightButton addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
//        [rightButton setUserInteractionEnabled:action];
//        if (action) {
//          [rightButton setTitleColor: Color7b7b7b forState:UIControlStateNormal];
//        }else{
//          [rightButton setTitleColor: Colorbbbbbb forState:UIControlStateNormal];
//        }
//        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//        [self.navigationItem setRightBarButtonItem:rightButtonItem animated:YES];
//    }
//  }else{
//     self.navigationItem.rightBarButtonItem=nil;
//  }
}

- (void)setNaviRightImgButton:(NSString* )imgName
{
//    if (IS_NOT_EMPTY(imgName)) {
//        UIImage *img1 = [UIImage imageNamed:imgName];
//        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        rightButton.frame = CGRectMake(0, 0, 80, 44);
//        [rightButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -60)];
//        [rightButton addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
//        [rightButton setImage:img1 forState:UIControlStateNormal];
//         UIImage * lpImage2 = [UIImage imageByApplyingAlpha:0.5 image:img1];
//        [rightButton setImage:lpImage2 forState:UIControlStateHighlighted];
//        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//        [self.navigationItem setRightBarButtonItem:rightButtonItem animated:YES];
//    }
}
- (void)clickRightButton:(id)sender {
   
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DonotdisturbViewController" object:nil];
    
}

-(void)clickLeftButton:(UIButton*)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"DonotdisturbBack" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickLeftImgButton:(UIButton*)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"clickLeftImgButton" object:nil];
}
- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
}

- (void)handlePanelHighlight:(id)sender{
    [[(UIView*)sender subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [obj setHighlighted:[(UIButton*)sender isHighlighted]];
        }
    }];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return UIInterfaceOrientationMaskPortrait;
}

#ifdef __IPHONE_7_0
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}
#endif

- (BOOL)shouldAutorotate {
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation == UIInterfaceOrientationPortrait) {
        // your code for portrait mode
        
    }
    
    return YES;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _isDecelerate = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int currentPostion = scrollView.contentOffset.y;
    
    if (_isDrag) {
        if ((abs(_lastPosition2 - currentPostion) < 3 && _isDecelerate) || abs(_lastPosition2 - currentPostion) < 2) { // 快速滑动减速时或者手指慢速移动时, 恢复图片下载线程
            _isDrag = NO;
        }else {
        }
    }else{

    }
    
    _lastPosition2 = currentPostion;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isDecelerate = NO;
    _isDrag = YES;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _isDrag = NO;
}
-(void)removeAllWindowAlertFromParentViewController{
  
}

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
