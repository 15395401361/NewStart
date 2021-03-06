//
//  UIView+Ext.m
//  Qilekang
//
//  Created by wj on 14-7-9.
//  Copyright (c) 2014年 Qilekang. All rights reserved.
//

#import "UIView+Ext.h"
#import <objc/runtime.h>

@implementation UIView (Frame)

- (CGPoint)origin
{
	return self.frame.origin;
}

- (void)setOrigin:(CGPoint) aPoint
{
	CGRect newframe = self.frame;
	newframe.origin = aPoint;
	self.frame = newframe;
}

- (CGSize)size
{
	return self.frame.size;
}

- (void)setSize:(CGSize) aSize
{
	CGRect newframe = self.frame;
	newframe.size = aSize;
	self.frame = newframe;
}

- (CGPoint)bottomRight
{
	CGFloat x = self.frame.origin.x + self.frame.size.width;
	CGFloat y = self.frame.origin.y + self.frame.size.height;
	return CGPointMake(x, y);
}

- (CGPoint)bottomLeft
{
	CGFloat x = self.frame.origin.x;
	CGFloat y = self.frame.origin.y + self.frame.size.height;
	return CGPointMake(x, y);
}

- (CGPoint)topRight
{
	CGFloat x = self.frame.origin.x + self.frame.size.width;
	CGFloat y = self.frame.origin.y;
	return CGPointMake(x, y);
}

- (CGFloat)height
{
	return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newheight
{
	CGRect newframe = self.frame;
	newframe.size.height = newheight;
	self.frame = newframe;
}

- (CGFloat)width
{
	return self.frame.size.width;
}

- (void)setWidth:(CGFloat)newwidth
{
	CGRect newframe = self.frame;
	newframe.size.width = newwidth;
	self.frame = newframe;
}

- (CGFloat)top
{
	return self.frame.origin.y;
}

- (void)setTop:(CGFloat)newtop
{
	CGRect newframe = self.frame;
	newframe.origin.y = newtop;
	self.frame = newframe;
}

- (CGFloat)left
{
	return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)newleft
{
	CGRect newframe = self.frame;
	newframe.origin.x = newleft;
	self.frame = newframe;
}

- (CGFloat)bottom
{
	return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)newbottom
{
	CGRect newframe = self.frame;
	newframe.origin.y = newbottom - self.frame.size.height;
	self.frame = newframe;
}

- (CGFloat)right
{
	return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)newright
{
	CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
	CGRect newframe = self.frame;
	newframe.origin.x += delta ;
	self.frame = newframe;
}
- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIViewBorderSideType)borderType{
    
    if (borderType == UIViewBorderSideTypeAll) {
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = color.CGColor;
        return self;
    }
    
    
    /// 左侧
    if (borderType & UIViewBorderSideTypeLeft) {
        /// 左侧线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    /// 右侧
    if (borderType & UIViewBorderSideTypeRight) {
        /// 右侧线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, 0.0f) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    /// top
    if (borderType & UIViewBorderSideTypeTop) {
        /// top线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, 0.0f) toPoint:CGPointMake(self.frame.size.width, 0.0f) color:color borderWidth:borderWidth]];
    }
    
    /// bottom
    if (borderType & UIViewBorderSideTypeBottom) {
        /// bottom线路径
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, self.frame.size.height) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    
    return self;
}

- (CAShapeLayer *)addLineOriginPoint:(CGPoint)p0 toPoint:(CGPoint)p1 color:(UIColor *)color borderWidth:(CGFloat)borderWidth {
    
    /// 线的路径
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:p0];
    [bezierPath addLineToPoint:p1];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    /// 添加路径
    shapeLayer.path = bezierPath.CGPath;
    /// 线宽度
    shapeLayer.lineWidth = borderWidth;
    return shapeLayer;
}

- (void)moveBy:(CGPoint)delta
{
	CGPoint newcenter = self.center;
	newcenter.x += delta.x;
	newcenter.y += delta.y;
	self.center = newcenter;
}

- (void)scaleBy:(CGFloat)scaleFactor
{
	CGRect newframe = self.frame;
	newframe.size.width *= scaleFactor;
	newframe.size.height *= scaleFactor;
	self.frame = newframe;
}

- (void)fitInSize:(CGSize)aSize
{
	CGFloat scale;
	CGRect newframe = self.frame;
	
	if (newframe.size.height && (newframe.size.height > aSize.height))
	{
		scale = aSize.height / newframe.size.height;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	if (newframe.size.width && (newframe.size.width >= aSize.width))
	{
		scale = aSize.width / newframe.size.width;
		newframe.size.width *= scale;
		newframe.size.height *= scale;
	}
	
	self.frame = newframe;
}

- (CGFloat)frameHight
{
    return self.frame.size.height;
}

- (CGFloat)frameWidth
{
    return self.frame.size.width;
}

- (CGFloat)originX
{
    return self.frame.origin.x;
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (CGPoint)frameOrigin
{
    return self.frame.origin;
}

- (CGSize)frameSize
{
    return self.frame.size;
}

-(void)uniformScale
{
    self.frame = CGRectMake([self originX], [self originY], SCREEN_WIDTH, SCREEN_WIDTH*self.frameHight/self.frameWidth); 
}

- (void)setFrameHight:(CGFloat)hight
{
    self.frame = CGRectMake([self originX], [self originY], [self frameWidth], hight);
}

- (void)setFrameWidth:(CGFloat)width
{
    self.frame = CGRectMake([self originX], [self originY], width, [self frameHight]);
}

- (void)setOriginX:(CGFloat)originX
{
    self.frame = CGRectMake(originX, [self originY], [self frameWidth], [self frameHight]);
}

- (void)setOriginY:(CGFloat)originY
{
    self.frame = CGRectMake([self originX], originY, [self frameWidth], [self frameHight]);
}

- (void)setFrameSize:(CGSize)size
{
    self.frame = CGRectMake([self originX], [self originY], size.width, size.height);
}

@end

@implementation UIView (SCreenShot)

- (UIImage *)convertViewToImage:(UIView *)v
{
    UIGraphicsBeginImageContext(v.bounds.size);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

@implementation UIView (Nib)

+ (id)classFromNib:(NSString *)className;
{
    Class class = NSClassFromString(className);
    
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil];
    NSUInteger index = [objects indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [obj isKindOfClass:class];
    }];
    
    assert(index != NSNotFound);
    return [objects objectAtIndex:index];
}

+(id)xibView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] objectAtIndex:0];
}

- (UIViewController *)findViewController
{
    id target = self;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

+ (id )findViewWithClassName: (Class)className view:(UIView *)sourceView
{
    id target = sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:className]) {
            break;
        }
    }
    return target;
}

@end

@implementation UIView (JMWhenTappedBlocks)

static char kWhenTappedBlockKey;
static char kWhenDoubleTappedBlockKey;
static char kWhenTwoFingerTappedBlockKey;
static char kWhenTouchedDownBlockKey;
static char kWhenTouchedUpBlockKey;

#pragma mark -
#pragma mark Set blocks

- (void)runBlockForKey:(void *)blockKey {
    JMWhenTappedBlock block = objc_getAssociatedObject(self, blockKey);
    if (block) block();
}

- (void)setBlock:(JMWhenTappedBlock)block forKey:(void *)blockKey {
    self.userInteractionEnabled = YES;
    objc_setAssociatedObject(self, blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark -
#pragma mark When Tapped

- (void)whenTapped:(JMWhenTappedBlock)block {
    UITapGestureRecognizer* gesture = [self addTapGestureRecognizerWithTaps:1 touches:1 selector:@selector(viewWasTapped)];
    [self addRequiredToDoubleTapsRecognizer:gesture];
    [self setBlock:block forKey:&kWhenTappedBlockKey];
}

- (void)whenDoubleTapped:(JMWhenTappedBlock)block {
    UITapGestureRecognizer* gesture = [self addTapGestureRecognizerWithTaps:2 touches:1 selector:@selector(viewWasDoubleTapped)];
    [self addRequirementToSingleTapsRecognizer:gesture];
    
    [self setBlock:block forKey:&kWhenDoubleTappedBlockKey];
}

- (void)whenTwoFingerTapped:(JMWhenTappedBlock)block {
    [self addTapGestureRecognizerWithTaps:1 touches:2 selector:@selector(viewWasTwoFingerTapped)];
    
    [self setBlock:block forKey:&kWhenTwoFingerTappedBlockKey];
}

- (void)whenTouchedDown:(JMWhenTappedBlock)block {
    [self setBlock:block forKey:&kWhenTouchedDownBlockKey];
}

- (void)whenTouchedUp:(JMWhenTappedBlock)block {
    [self setBlock:block forKey:&kWhenTouchedUpBlockKey];
}

#pragma mark -
#pragma mark Callbacks

- (void)viewWasTapped {
    [self runBlockForKey:&kWhenTappedBlockKey];
}

- (void)viewWasDoubleTapped {
    [self runBlockForKey:&kWhenDoubleTappedBlockKey];
}

- (void)viewWasTwoFingerTapped {
    [self runBlockForKey:&kWhenTwoFingerTappedBlockKey];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self runBlockForKey:&kWhenTouchedDownBlockKey];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self runBlockForKey:&kWhenTouchedUpBlockKey];
}

#pragma mark -
#pragma mark Helpers

- (UITapGestureRecognizer*)addTapGestureRecognizerWithTaps:(NSUInteger)taps touches:(NSUInteger)touches selector:(SEL)selector {
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    tapGesture.delegate = self;
    tapGesture.numberOfTapsRequired = taps;
    tapGesture.numberOfTouchesRequired = touches;
    [self addGestureRecognizer:tapGesture];
    
    return tapGesture;
}

- (void) addRequirementToSingleTapsRecognizer:(UIGestureRecognizer*) recognizer {
    for (UIGestureRecognizer* gesture in [self gestureRecognizers]) {
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
            UITapGestureRecognizer* tapGesture = (UITapGestureRecognizer*) gesture;
            if (tapGesture.numberOfTouchesRequired == 1 && tapGesture.numberOfTapsRequired == 1) {
                [tapGesture requireGestureRecognizerToFail:recognizer];
            }
        }
    }
}

- (void) addRequiredToDoubleTapsRecognizer:(UIGestureRecognizer*) recognizer {
    for (UIGestureRecognizer* gesture in [self gestureRecognizers]) {
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
            UITapGestureRecognizer* tapGesture = (UITapGestureRecognizer*) gesture;
            if (tapGesture.numberOfTouchesRequired == 2 && tapGesture.numberOfTapsRequired == 1) {
                [recognizer requireGestureRecognizerToFail:tapGesture];
            }
        }
    }
}

@end

@implementation UIView (Animation)

- (CAAnimation *)animationWithOpacityFrom:(CGFloat) from To:(CGFloat) to Duration:(CGFloat) duration BeginTime:(CGFloat)beginTime
{
    CABasicAnimation *theAnimation;
    
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation.duration=duration;
    theAnimation.beginTime = beginTime;
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    theAnimation.repeatCount=0;
    theAnimation.delegate = self;
    theAnimation.autoreverses=NO;
    theAnimation.fromValue=[NSNumber numberWithFloat:from];
    theAnimation.toValue=[NSNumber numberWithFloat:to];
    
    return theAnimation;
}

+(UIViewController*)viewController:(UIView*)view{
    for (UIView* next = [view superview]; next; next =
         next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController
                                          class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
+(UITableViewCell*)getCellFromSubView:(UIView*)subview{
    if ([subview.superview isKindOfClass:[UITableViewCell class]]) {
        return (UITableViewCell*)subview.superview;
    }else if ([subview.superview.superview isKindOfClass:[UITableViewCell class]]){
        return (UITableViewCell*)subview.superview.superview;
    }else if ([subview.superview.superview.superview isKindOfClass:[UITableViewCell class]]){
        return (UITableViewCell*)subview.superview.superview.superview;
    }else if ([subview.superview.superview.superview.superview isKindOfClass:[UITableViewCell class]]){
        return (UITableViewCell*)subview.superview.superview.superview.superview;
    }else{
        return nil;
    }
    
}

@end
