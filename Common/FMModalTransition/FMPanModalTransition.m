//
//  FMPanModalTransition.m
//  Demo2
//
//  Created by fm on 2017/5/11.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMPanModalTransition.h"

@interface FMPanModalTransition()
{
    CGRect _fromRect;
    UIView *_fromView;
}

@property (nonatomic, strong, readwrite) FMPercentDrivenInteractiveTransition * _Nullable mPercentDrivenInteractiveTransition;

@end

@implementation FMPanModalTransition

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.mPercentDrivenInteractiveTransition = [[FMPercentDrivenInteractiveTransition alloc] init];
    }
    return self;
}

#pragma mark - Public methods
- (void)presentModalViewControllerWithFromVC:(UIViewController * _Nullable)fromVC fromRect:(CGRect)fromRect fromView:(UIView *)fromView toVC:(UIViewController * _Nullable)toVC animated:(BOOL)animated completion:(void (^ __nullable)(void))completion
{
    _fromRect = fromRect;
    _fromView = fromView;
    toVC.transitioningDelegate = self;
//    [self.mPercentDrivenInteractiveTransition wireToViewController:toVC];
    [fromVC presentViewController:toVC animated:animated completion:completion];
}

- (void)dismissViewController:(UIViewController * _Nullable)objVC animated: (BOOL)flag completion: (void (^ __nullable)(void))completion
{
    objVC.transitioningDelegate = self;
    [objVC dismissViewControllerAnimated:flag completion:completion];
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    if (toVC.isBeingPresented) {
        [containerView addSubview:toView];
        toView.frame = fromView.frame;
        [toView addSubview:_fromView];
        _fromView.frame = _fromRect;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            CGFloat H = _fromRect.size.height*fromView.frame.size.width/_fromRect.size.width;
            _fromView.frame = CGRectMake(fromView.frame.origin.x, fromView.frame.origin.y, fromView.frame.size.width, H);
        } completion:^(BOOL finished) {
            [_fromView removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    
    if (fromVC.isBeingDismissed) {
        [containerView insertSubview:toView belowSubview:fromVC.view];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromView.frame = _fromRect;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}

//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
//{
//    return self.mPercentDrivenInteractiveTransition.interacting ? self.mPercentDrivenInteractiveTransition : nil;
//}


@end

