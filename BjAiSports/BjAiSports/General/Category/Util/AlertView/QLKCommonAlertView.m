//
//  QLKAlertView.m
//  CloudsOutpatient
//
//  Created by 柴志勇 on 16/3/29.
//  Copyright © 2016年 HC. All rights reserved.
//  reference: https://github.com/fergusding/iOS-Custom-AlertView

#import "QLKCommonAlertView.h"
#define IS_IOS_LOWER_THAN_8 ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] < 8.0 )
#define IS_IOS_8_OR_HIGHER ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] >= 8.0 )

#define DEFAULT_ALERT_WIDTH 270
#define DEFAULT_ALERT_HEIGHT 144

@interface QLKCommonAlertView (){
    CGRect titleLabelFrame;
    CGRect messageLabelFrame;
    CGRect midMessageLabelFrame;
    CGRect cancelButtonFrame;
    CGRect otherButtonFrame;
    
    CGRect verticalSeperatorFrame;
    CGRect horizontalSeperatorFrame;
    
    BOOL hasModifiedFrame;
    BOOL hasContentView;
}

@property (nonatomic, strong) UIButton * midMessageButton; // 颜色 0x395998 字体 14
@property (nonatomic, strong) UIButton * cancelButton; // 颜色 blue 字体 16
@property (nonatomic, strong) UIButton * otherButton; // 颜色 red 字体 16
@property (nonatomic, strong) UILabel * titleLabel;  // 颜色 黑色 字体 16

@property (nonatomic, strong) UIView * alertContentView; //自定义View

//装饰子页面，暂时未用到
@property (nonatomic, strong) UIView * horizontalSeparator;
@property (nonatomic, strong) UIView * verticalSeparator;
//遮罩层
@property (nonatomic, strong) CustomMaskView * blackOpaqueView;
//文本
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * message;
@property (nonatomic, strong) NSString * midMessage;
@property (nonatomic, strong) NSString * cancelButtonTitle;
@property (nonatomic, strong) NSString * otherButtonTitle;

//控件背景大小
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;



@end

@implementation QLKCommonAlertView

- (id)initWithFrame:(CGRect)frame{
  
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                      midMessage:(NSString *)midMessage
            cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitle:(NSString *)otherButtonTitle{
  
    self.width = DEFAULT_ALERT_WIDTH;
    self.height = DEFAULT_ALERT_HEIGHT;
    
    self = [super initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    if (self) {
      
      self.clipsToBounds = YES;
      self.title = title;
      self.message = message;
      self.midMessage = midMessage;
      self.cancelButtonTitle = cancelButtonTitle;
      self.otherButtonTitle = otherButtonTitle;
      self.appearAnimationType = QLKAlertViewAnimationTypeDefault;
      self.disappearAnimationType = QLKAlertViewAnimationTypeDefault;
      self.cornerRadius = 8;
      self.buttonClickedHighlight = YES;
      
      self.buttonHeight = 44;
      self.titleTopPadding = 14;
      self.titleHeight = 34;
      self.titleBottomPadding = 2;
      self.messageBottomPadding = 20;
      self.messageLeftRightPadding = 20;
      self.midMessageHeight = 34;
      self.midMessageBottomPadding = 20;
        
      self.shouldDimBackgroundWhenShowInWindow = YES;
      self.shouldDismissOnActionButtonClicked = YES;
      self.dimAlpha = 0.4;
      [self setupItems];
        
        //结束会话单独处理
        if ([@"是否立即结束会话" isEqualToString:message]) {
            UITapGestureRecognizer *outsideTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(outsideTap:)];
            [self.blackOpaqueView addGestureRecognizer:outsideTapGesture];
            self.shouldDismissOnOutsideTapped = YES;
        }
    }
    return self;
}

#pragma mark - Show the alert view

// Show in specified view
- (void)showInView:(UIView *)view{
    [self calculateFrame];
    [self setupViews];
    if ( ! hasModifiedFrame) {
      self.frame = CGRectMake((view.frame.size.width - self.frame.size.width )/2, (view.frame.size.height - self.frame.size.height) /2, self.frame.size.width, self.frame.size.height);
    }
    UIView *window = [[[UIApplication sharedApplication] delegate] window];
    if (self.shouldDimBackgroundWhenShowInView && view != window) {
      UIView *window = [[[UIApplication sharedApplication] delegate] window];
      self.blackOpaqueView = [[CustomMaskView alloc] initWithFrame:window.bounds];
      self.blackOpaqueView.backgroundColor = [UIColor colorWithWhite:0 alpha:self.dimAlpha];
      
      UITapGestureRecognizer *outsideTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(outsideTap:)];
      [self.blackOpaqueView addGestureRecognizer:outsideTapGesture];
      [view addSubview:self.blackOpaqueView];
    }
    [self willAppearAlertView];
    [self addThisViewToView:view];
}

- (void)show{
  
    [self showInWindow];
}
#pragma mark --- 显示
-(void)showInWindow{
    UIView *superView;
    UIView *window = [[[UIApplication sharedApplication] delegate] window];
    //    if (IS_IOS_8_OR_HIGHER) {
    //       superView = window;
    //    } else {
    //       superView = [[window subviews] lastObject];
    //    }
    superView = window;
    
    if (self.shouldDimBackgroundWhenShowInWindow) {
        self.blackOpaqueView = [[CustomMaskView alloc] initWithFrame:window.bounds];
        self.blackOpaqueView.backgroundColor = [UIColor colorWithWhite:0 alpha:self.dimAlpha];
        
        UITapGestureRecognizer *outsideTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(outsideTap:)];
        [self.blackOpaqueView addGestureRecognizer:outsideTapGesture];
        [superView addSubview:self.blackOpaqueView];
    }
    
    [self showInView:superView];
}

- (void)showWithColor:(UIColor *)okColor andCancelColor:(UIColor *)cancelColor{
    if (nil != okColor) {
        [self.otherButton setTitleColor:okColor forState:UIControlStateNormal];
    }
    if (nil != cancelColor) {
        [self.cancelButton setTitleColor:cancelColor forState:UIControlStateNormal];
    }
     [self showInWindow];

}



- (void)outsideTap:(UITapGestureRecognizer *)recognizer{
  
    if (self.shouldDismissOnOutsideTapped) {
      [self dismiss];
    }
}

- (void) addThisViewToView: (UIView *) view{
  
    NSTimeInterval timeAppear = ( self.appearTime > 0 ) ? self.appearTime : .2;
    NSTimeInterval timeDelay = 0;
    
    [view addSubview:self];
    WS(weakSelf);
    if (self.appearAnimationType == QLKAlertViewAnimationTypeDefault){
      self.transform = CGAffineTransformMakeScale(1.1, 1.1);
      self.alpha = .6;
      [UIView animateWithDuration:timeAppear delay:timeDelay options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.transform = CGAffineTransformIdentity;
        weakSelf.alpha = 1;
        
      } completion:^(BOOL finished){
        [weakSelf didAppearAlertView];
      }];
    }else if (self.appearAnimationType == QLKAlertViewAnimationTypeNone){
      [self didAppearAlertView];
    }
}

// Hide and dismiss the alert
- (void)dismiss{
  
    NSTimeInterval timeDisappear = ( self.disappearTime > 0 ) ? self.disappearTime : .08;
    NSTimeInterval timeDelay = .02;
    WS(weakSelf);
    if (self.disappearAnimationType == QLKAlertViewAnimationTypeDefault) {
      self.transform = CGAffineTransformIdentity;
      [UIView animateWithDuration:timeDisappear delay:timeDelay options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.alpha = .0;
      } completion:^(BOOL finished){
        [weakSelf removeFromSuperview];
      }];
    }else if (self.disappearAnimationType == QLKAlertViewAnimationTypeNone){
      [self removeFromSuperview];
    }
  
    if (self.blackOpaqueView) {
      [UIView animateWithDuration:timeDisappear animations:^{
        weakSelf.blackOpaqueView.alpha = 0;
      } completion:^(BOOL finished) {
        [weakSelf.blackOpaqueView removeFromSuperview];
      }];
    }
}

#pragma mark - Setup the alert view

- (void)setContentView:(UIView *)contentView{
  
    if ( ! self.title && ! self.message && ! self.midMessage) {
      self.buttonHeight = 0;
    }
    self.alertContentView = contentView;
    
    hasContentView = YES;
    self.width = contentView.frame.size.width;
    self.height = contentView.frame.size.height + self.buttonHeight;
    
    contentView.frame = contentView.bounds;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.width, self.height);
    [self addSubview:contentView];
}

- (UIView *)contentView{
  
    return self.alertContentView;
}

- (void)setCenter:(CGPoint)center{
  
    [super setCenter:center];
    
    hasModifiedFrame = YES;
}

- (void)setCustomFrame:(CGRect)frame{
  
    [super setFrame:frame];
    
    self.width = frame.size.width;
    self.height = frame.size.height;
    hasModifiedFrame = YES;
    
    [self calculateFrame];
}

- (void)calculateFrame{
  
    BOOL hasButton = (self.cancelButtonTitle || self.otherButtonTitle);
    
    if ( ! hasContentView ) {
      if ( ! hasModifiedFrame ){
        UIFont * messageFont = self.messageLabel.font ? self.messageLabel.font : [UIFont systemFontOfSize:14];
      
        CGSize maximumLabelSize = CGSizeMake(self.width - self.messageLeftRightPadding * 2, FLT_MAX);
        
        CGRect textRect = [self.message boundingRectWithSize:maximumLabelSize
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName:messageFont}
                                                     context:nil];
        
        CGFloat messageHeight = textRect.size.height;
        
        CGFloat newHeight = messageHeight + self.titleHeight + self.buttonHeight + self.titleTopPadding + self.titleBottomPadding + self.messageBottomPadding + self.midMessageHeight + self.midMessageBottomPadding;
        self.height = newHeight;
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.height);
        
      }
      
      if ( ! self.title ) {
        titleLabelFrame = CGRectZero;
      } else {
        titleLabelFrame = CGRectMake(self.messageLeftRightPadding,
                                     self.titleTopPadding,
                                     self.width - self.messageLeftRightPadding * 2,
                                     self.titleHeight);
      }
      if ( ! self.message ) {
        messageLabelFrame = CGRectZero;
      } else if (hasButton) {
        messageLabelFrame = CGRectMake(self.messageLeftRightPadding,
                                       titleLabelFrame.origin.y + titleLabelFrame.size.height + self.titleBottomPadding,
                                       self.width - self.messageLeftRightPadding * 2,
                                       self.height - self.buttonHeight - titleLabelFrame.size.height - self.titleTopPadding - self.titleBottomPadding - self.midMessageBottomPadding - self.midMessageHeight);
      } else {
        messageLabelFrame = CGRectMake(self.messageLeftRightPadding,
                                       titleLabelFrame.origin.y +  titleLabelFrame.size.height + self.titleBottomPadding,
                                       self.width - self.messageLeftRightPadding * 2,
                                       self.height - titleLabelFrame.size.height - self.titleTopPadding - self.titleBottomPadding - self.midMessageBottomPadding - self.midMessageHeight);
      }
      
      if( ! self.midMessage){
          midMessageLabelFrame = CGRectZero;
      }else{
          midMessageLabelFrame = CGRectMake(self.messageLeftRightPadding,
                                         titleLabelFrame.origin.y +  titleLabelFrame.size.height + self.titleBottomPadding + messageLabelFrame.size.height + self.messageBottomPadding,
                                         self.width - self.messageLeftRightPadding * 2,
                                         self.midMessageHeight);
      }
        
      if ( ! self.title || self.title.length == 0 ) {
        messageLabelFrame = CGRectMake(self.messageLeftRightPadding, 0, self.width - self.messageLeftRightPadding * 2, self.height - self.buttonHeight);
      }
      
    }
    
    if ( self.hideSeperator || ! hasButton ) {
      verticalSeperatorFrame = CGRectZero;
      horizontalSeperatorFrame = CGRectZero;
    } else {
      verticalSeperatorFrame = CGRectMake(self.width / 2,
                                          self.height - self.buttonHeight+0.5,
                                          0.5,
                                          self.buttonHeight);
      
      horizontalSeperatorFrame = CGRectMake(0,
                                            self.height - self.buttonHeight+0.5,
                                            self.width,
                                            0.5);
    }
    
    if ( ! self.cancelButtonTitle ) {
      cancelButtonFrame = CGRectZero;
    } else if ( ! self.otherButtonTitle ) {
      verticalSeperatorFrame = CGRectZero;
      cancelButtonFrame = CGRectMake(0,
                                     self.height - self.buttonHeight,
                                     self.width,
                                     self.buttonHeight);
    } else if ( ! self.cancelButtonPositionRight ) {
      cancelButtonFrame = CGRectMake(0,
                                     self.height - self.buttonHeight,
                                     self.width / 2,
                                     self.buttonHeight);
    } else {
      cancelButtonFrame = CGRectMake(self.width / 2,
                                     self.height - self.buttonHeight,
                                     self.width / 2,
                                     self.buttonHeight);
    }
    
    if ( ! self.otherButtonTitle ) {
      otherButtonFrame = CGRectZero;
    } else if ( ! self.cancelButtonTitle ) {
      verticalSeperatorFrame = CGRectZero;
      otherButtonFrame = CGRectMake(0,
                                    self.height - self.buttonHeight,
                                    self.width,
                                    self.buttonHeight);
    } else if ( ! self.cancelButtonPositionRight ) {
      otherButtonFrame = CGRectMake(self.width / 2,
                                    self.height - self.buttonHeight,
                                    self.width / 2,
                                    self.buttonHeight);
    } else {
      otherButtonFrame = CGRectMake(0,
                                    self.height - self.buttonHeight,
                                    self.width / 2,
                                    self.buttonHeight);
    }
    
    if ( ! self.otherButtonTitle && ! self.cancelButtonTitle) {
      cancelButtonFrame = CGRectZero;
      otherButtonFrame = CGRectZero;
      
      self.height = self.height - self.buttonHeight;
      self.buttonHeight = 0;
      self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.height);
    }
  
}

- (void)setupItems{
  
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.midMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.midMessageButton.frame = CGRectZero;
    [self.midMessageButton addTarget:self action:@selector(midMessageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // Setup Title Label
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleLabel.text = self.title;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = Color444444;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    // Setup midMessage button
   
    self.midMessageButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.midMessageButton setTitle:self.midMessage forState:UIControlStateNormal];
    [self.midMessageButton setTitleColor:Color395998 forState:UIControlStateNormal];
    self.midMessageButton.backgroundColor = [UIColor clearColor];
    
    // Setup Message Label
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.font = [UIFont systemFontOfSize:14];
    self.messageLabel.text = self.message;
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.textColor = Color444444;
    self.messageLabel.backgroundColor = [UIColor clearColor];
    
    //Setup Cancel Button
    self.cancelButton.backgroundColor = [UIColor clearColor];
    [self.cancelButton setTitleColor:Colorf84B62 forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //Setup Other Button
    self.otherButton.backgroundColor = [UIColor clearColor];
    [self.otherButton setTitleColor:Colorf84B62 forState:UIControlStateNormal];
    self.otherButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.otherButton setTitle:self.otherButtonTitle forState:UIControlStateNormal];
    [self.otherButton addTarget:self action:@selector(otherButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.horizontalSeparator = [[UIView alloc] initWithFrame:CGRectZero];
    self.verticalSeparator = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    [self.cancelButton setBackgroundImage:[UIColor createImageWithColor:Colorbbbbbb] forState:UIControlStateHighlighted];
    [self.otherButton setBackgroundImage:[UIColor createImageWithColor:Colorbbbbbb] forState:UIControlStateHighlighted];
}

- (void)setupViews{
  
    // Setup Background
    if (self.backgroundImage) {
      [self setBackgroundColor:[UIColor colorWithPatternImage:self.backgroundImage]];
    } else if (self.backgroundColor) {
      [self setBackgroundColor:self.backgroundColor];
    } else {
      [self setBackgroundColor:[UIColor colorWithRed:246.0/255 green:246.0/25 blue:246.0/25 alpha:1.0]];
    }
    
    if (self.borderWidth) {
      self.layer.borderWidth = self.borderWidth;
    }
    if (self.borderColor) {
      self.layer.borderColor = self.borderColor.CGColor;
    } else {
      self.layer.borderColor = [UIColor clearColor].CGColor;
    }
    
    self.layer.cornerRadius = self.cornerRadius;
    
    // Set Frame
    self.titleLabel.frame = titleLabelFrame;
    self.messageLabel.frame = messageLabelFrame;
    self.midMessageButton.frame = midMessageLabelFrame;
    self.cancelButton.frame = cancelButtonFrame;
    self.otherButton.frame = otherButtonFrame;
    
    self.horizontalSeparator.frame = horizontalSeperatorFrame;
    self.verticalSeparator.frame = verticalSeperatorFrame;
    
    if (self.separatorColor) {
      self.horizontalSeparator.backgroundColor = self.separatorColor;
      self.verticalSeparator.backgroundColor = self.separatorColor;
    } else {
      self.horizontalSeparator.backgroundColor = [UIColor colorWithRed:196.0/255 green:196.0/255 blue:201.0/255 alpha:1.0];
      self.verticalSeparator.backgroundColor = [UIColor colorWithRed:196.0/255 green:196.0/255 blue:201.0/255 alpha:1.0];
    }
    
    // Make the message fits to it bounds
    if ( self.title ) {
      [self.messageLabel sizeToFit];
      CGRect myFrame = self.messageLabel.frame;
      myFrame = CGRectMake(myFrame.origin.x, myFrame.origin.y, self.width -  2 * self.messageLeftRightPadding, myFrame.size.height);
      self.messageLabel.frame = myFrame;
    }
    
    // Add subviews
    if ( ! hasContentView) {
      [self addSubview:self.titleLabel];
      [self addSubview:self.messageLabel];
      [self addSubview:self.midMessageButton];
    }
    
    [self addSubview:self.cancelButton];
    [self addSubview:self.otherButton];
    [self addSubview:self.horizontalSeparator];
    [self addSubview:self.verticalSeparator];
}

#pragma mark - Touch Event

- (void)cancelButtonTouchBegan:(id)sender{
  
    self.originCancelButtonColor = [self.cancelButton.backgroundColor colorWithAlphaComponent:0];
    self.cancelButton.backgroundColor = [self.cancelButton.backgroundColor colorWithAlphaComponent:.1];
}

- (void)cancelButtonTouchEnded:(id)sender{
  
    self.cancelButton.backgroundColor = self.originCancelButtonColor;
}

- (void)otherButtonTouchBegan:(id)sender{
  
    self.originOtherButtonColor = [self.otherButton.backgroundColor colorWithAlphaComponent:0];
    self.otherButton.backgroundColor = [self.otherButton.backgroundColor colorWithAlphaComponent:.1];
}

- (void)otherButtonTouchEnded:(id)sender{
  
    self.otherButton.backgroundColor = self.originOtherButtonColor;
}

#pragma mark - Actions

- (void)actionWithBlockssMidMesageButtonHandler:(void (^)(void))midButtonHandler  cancelButtonHandler:(void (^)(void))cancelHandler
                         otherButtonHandler:(void (^)(void))otherHandler{
  
    self.midButtonHandlerAction = midButtonHandler;
    self.cancelButtonAction = cancelHandler;
    self.otherButtonAction = otherHandler;
}

- (void)cancelButtonClicked:(id)sender{
    WS(weakSelf);
    if (self.buttonClickedHighlight){
      
        UIColor * originColor = [self.cancelButton.backgroundColor colorWithAlphaComponent:0];
        self.cancelButton.backgroundColor = [self.cancelButton.backgroundColor colorWithAlphaComponent:.1];
        double delayInSeconds = .2;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
          weakSelf.otherButton.backgroundColor = originColor;
        });
      
    }
    
    [self dismiss];
    
    if (self.cancelButtonAction) {
        self.cancelButtonAction();
    }
}

- (void)midMessageButtonClicked:(id)sender{
    [self dismiss];
    if (self.midButtonHandlerAction) {
        self.midButtonHandlerAction();
    }
}

- (void)otherButtonClicked:(id)sender{
    WS(weakSelf);
    if (self.buttonClickedHighlight){
      UIColor * originColor = [self.otherButton.backgroundColor colorWithAlphaComponent:0];
      self.otherButton.backgroundColor = [self.otherButton.backgroundColor colorWithAlphaComponent:.1];
      double delayInSeconds = .2;
      dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
      dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        weakSelf.otherButton.backgroundColor = originColor;
      });
    }
    
    if (self.shouldDismissOnActionButtonClicked) {
      [self dismiss];
    }
    
    if (self.otherButtonAction) {
      self.otherButtonAction();
    }
}

- (void)didAppearAlertView{
  
}

- (void)willAppearAlertView{
  
}

@end
