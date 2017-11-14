//
//  PDNavigationController.m
//  PDCS
//
//  Created by iMac on 2017/9/21.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "PDNavigationController.h"
#define KEY_WINDOW  [[UIApplication sharedApplication] keyWindow]
#define TOP_VIEW    (KEY_WINDOW.rootViewController.view)

static float originalScaleRate = 0.95;
static float originalMaskAlpha = 0.5;

@interface PDNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) NSMutableArray *snapshotStack;
@property (nonatomic, strong) UIImageView *snapshotImageView;
@property (nonatomic, strong) UIView *snapshotMaskView;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic, assign) CGPoint startTouch;
@end

@implementation PDNavigationController
+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //    bar.barStyle = UIBarStyleDefault;
    ///导航栏字体颜色
    [bar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                 KNaviTitleClr, NSForegroundColorAttributeName,
                                 [UIFont fontWithName:@"Arial-Bold" size:18], NSFontAttributeName,
                                 nil]];
    
    ///设置导航栏的颜色。
    if (ISIOS7AndAbove) {
        [bar setTintColor:kBarBgColor];
        bar.barTintColor = kBarBgColor;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.translucent = NO;
    
    if (ISIOS7AndAbove) {
        UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        gesture.maximumNumberOfTouches = 1;
        gesture.delegate = self;
        gesture.edges = UIRectEdgeLeft;
        [self.view addGestureRecognizer:gesture];
    }

}

- (UIImage *)takeSnapShotWithTopView
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(TOP_VIEW.bounds.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(TOP_VIEW.bounds.size);
    
#ifdef __IPHONE_7_0
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    [TOP_VIEW drawViewHierarchyInRect:TOP_VIEW.bounds afterScreenUpdates:YES];
#endif
#else
    [TOP_VIEW.layer renderInContext:UIGraphicsGetCurrentContext()];
#endif
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (UIImage *)takeSnapshot
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(TOP_VIEW.bounds.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(TOP_VIEW.bounds.size);
    
#ifdef __IPHONE_7_0
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    [self.view drawViewHierarchyInRect:TOP_VIEW.bounds afterScreenUpdates:YES];
#endif
#else
    [TOP_VIEW.layer renderInContext:UIGraphicsGetCurrentContext()];
#endif
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark - override push
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.hidesBackButton = YES;
    
    if (ISIOS7AndAbove) {
        if (!self.snapshotStack) {
            self.snapshotStack = [[NSMutableArray alloc] initWithCapacity:10];
        }
        UIImage *snapshot = [self takeSnapShotWithTopView];
        if (snapshot){
            [self.snapshotStack addObject:snapshot];
        }
    }
    
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (animated) {
        __block CGRect frame = TOP_VIEW.frame;
        [self initSnapshot];
        UIImage *snapshot = [self takeSnapShotWithTopView];
        //         UIImageWriteToSavedPhotosAlbum(snapshot, self, nil, nil);
        TOP_VIEW.left = -SCREEN_WIDTH;
        _snapshotImageView.hidden = NO;
        _snapshotImageView.image = snapshot;
        _snapshotImageView.left = 0;
        //        _snapshotImageView.frame = frame;
        [TOP_VIEW.superview insertSubview:self.snapshotImageView belowSubview:TOP_VIEW];
        
        [UIView animateWithDuration:0.4 animations:^{
            frame.origin.x = 0;
            TOP_VIEW.frame = frame;
        } completion:^(BOOL finished) {
            frame.origin.x = 0;
            TOP_VIEW.frame = frame;
        }];
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect sFrame = _snapshotImageView.frame;
            sFrame.origin.x = SCREEN_WIDTH;
            _snapshotImageView.frame = sFrame;
        } completion:^(BOOL finished) {
            self.snapshotImageView.hidden = YES;
            _snapshotImageView = nil;
            _snapshotMaskView = nil;
            [self.snapshotStack removeLastObject];
        }];
        
    }else{
        [self.snapshotStack removeLastObject];
    }
    return [super popViewControllerAnimated:NO];
}

#pragma mark - handlePanGesture
- (void)handlePanGesture:(UIScreenEdgePanGestureRecognizer *)panGestureRecognizer
{
    if (self.viewControllers.count == 1) {
        return;
    }
    CGPoint point = [panGestureRecognizer locationInView:KEY_WINDOW];
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        _startPoint = point;
        [self initSnapshot];
        self.snapshotImageView.image = [self.snapshotStack lastObject];
        self.snapshotImageView.hidden = NO;
        
        TOP_VIEW.layer.shadowOffset = CGSizeMake(-3, 0);
        TOP_VIEW.layer.shadowOpacity = originalMaskAlpha;
        
        [TOP_VIEW.superview insertSubview:self.snapshotImageView belowSubview:TOP_VIEW];
        panGestureRecognizer.view.userInteractionEnabled = NO;
        
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (_startPoint.x<64 || (150<_startPoint.y && _startPoint.y <300)) {
            CGRect frame = TOP_VIEW.frame;
            if (point.x - _startPoint.x>0) {
                frame.origin.x = point.x - _startPoint.x;
                TOP_VIEW.frame = frame;
                [self scaleSnapshotWithXOffset:frame.origin.x];
            }
        }
        else{
            
        }
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded ||
               panGestureRecognizer.state == UIGestureRecognizerStateCancelled ||
               panGestureRecognizer.state == UIGestureRecognizerStateFailed) {
        _startPoint = CGPointZero;
        [self judgeToPushOrPop];
        panGestureRecognizer.view.userInteractionEnabled = YES;
    }
}

- (void)scaleSnapshotWithXOffset:(CGFloat)xOffset
{
    CGFloat rate = (1 - originalScaleRate) * (xOffset / TOP_VIEW.frame.size.width);
    float originTranslation = SCREEN_WIDTH * 0.6;
    CGFloat targetRate = originalScaleRate + rate;
    if (targetRate > 1) targetRate = 1;
    CGFloat targetTranslation = -(originTranslation - xOffset * (originTranslation/SCREEN_WIDTH));
    
    
    //    self.snapshotImageView.transform = CGAffineTransformMakeScale(targetRate, targetRate);
    self.snapshotImageView.transform = CGAffineTransformMakeTranslation(targetTranslation, 0);
    [self scaleSnapshotMaskAlphaWithXOffset:xOffset];
}

- (void)scaleSnapshotMaskAlphaWithXOffset:(CGFloat)xOffset
{
    CGFloat alpha = (1 - originalMaskAlpha) * (xOffset / TOP_VIEW.frame.size.width);
    CGFloat targetAlpha = 1 - (originalMaskAlpha + alpha);
    //    Log(@"xOffset: %f targetAlpha = %f" , xOffset, targetAlpha);
    
    TOP_VIEW.layer.shadowOpacity = targetAlpha;
    self.snapshotMaskView.backgroundColor = [UIColor colorWithWhite:0 alpha:targetAlpha];
}


- (void)initSnapshot
{
    if (!self.snapshotImageView) {
        self.snapshotImageView = [[UIImageView alloc] initWithFrame:TOP_VIEW.bounds];
        
        self.snapshotMaskView = [[UIView alloc] initWithFrame:self.snapshotImageView.bounds];
        [self.snapshotImageView addSubview:self.snapshotMaskView];
        self.snapshotMaskView.backgroundColor = [UIColor colorWithWhite:0 alpha:originalMaskAlpha];
        //        if (!self.snapshotMaskView) {
        //            self.snapshotMaskView = [[UIView alloc] initWithFrame:self.snapshotImageView.bounds];
        //            [self.snapshotImageView addSubview:self.snapshotMaskView];
        //            self.snapshotMaskView.backgroundColor = [UIColor colorWithWhite:0 alpha:originalMaskAlpha];
        //        }
    }
    
    //    self.snapshotImageView.transform = CGAffineTransformMakeScale(originalScaleRate, originalScaleRate);
}

#pragma mark - judgeToPushOrPop

- (void)judgeToPushOrPop
{
    __block CGRect frame = TOP_VIEW.frame;
    if (frame.origin.x >= (frame.size.width / 3)) {
        [UIView animateWithDuration:0.2 animations:^{
            frame.origin.x = frame.size.width;
            TOP_VIEW.frame = frame;
            [self scaleSnapshotWithXOffset:frame.origin.x];
        } completion:^(BOOL finished) {
            [self popViewControllerAnimated:NO];
            
            self.snapshotImageView.hidden = YES;
            frame.origin.x = 0;
            TOP_VIEW.frame = frame;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            frame.origin.x = 0;
            TOP_VIEW.frame = frame;
            
            [self scaleSnapshotWithXOffset:frame.origin.x];
        } completion:^(BOOL finished) {
            self.snapshotImageView.hidden = YES;
        }];
    }
}

#pragma mark - gestureRecognizer delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    //    Log(@"%@ %@", gestureRecognizer, otherGestureRecognizer);
    [otherGestureRecognizer requireGestureRecognizerToFail:gestureRecognizer];
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController: (UIViewController*)controller
    animatedWithTransition: (UIViewAnimationTransition)transition {
    [self pushViewController:controller animated:NO];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(pushAnimationDidStop)];
    [UIView setAnimationTransition:transition forView:self.view cache:YES];
    [UIView commitAnimations];
}

- (UIViewController*)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition {
    UIViewController* poppedController = [self popViewControllerAnimated:NO];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(pushAnimationDidStop)];
    [UIView setAnimationTransition:transition forView:self.view cache:NO];
    [UIView commitAnimations];
    
    return poppedController;
}

- (void)pushAnimationDidStop {
    
}

@end
