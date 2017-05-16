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
}

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
- (void)presentModalViewControllerWithFromVC:(UIViewController * _Nullable)fromVC andToVC:(UIViewController * _Nullable)toVC animated:(BOOL)animated withFromRect:(CGRect)fromRect completion:(void (^ __nullable)(void))completion
{
    _fromRect = fromRect;
    toVC.transitioningDelegate = self;
    [self.mPercentDrivenInteractiveTransition wireToViewController:toVC];
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
    
    CGRect startFrame = _fromRect;
    CGRect endFrame = CGRectMake(0, 0, fromView.frame.size.width, fromView.frame.size.height);
    
    if (toVC.isBeingPresented) {
        [containerView addSubview:toView];
        
        toView.frame = startFrame;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toView.frame = endFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            [containerView addSubview:fromView];
            [containerView sendSubviewToBack:fromView];
        }];
    }
    
    if (fromVC.isBeingDismissed) {
        
        [containerView insertSubview:toView belowSubview:fromView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            fromView.alpha = 0.f;
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

