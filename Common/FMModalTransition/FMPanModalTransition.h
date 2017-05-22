//
//  FMPanModalTransition.h
//  Demo2
//
//  Created by fm on 2017/5/11.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FMPercentDrivenInteractiveTransition.h"

@interface FMPanModalTransition : NSObject<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>

@property (nonatomic, strong, readonly) FMPercentDrivenInteractiveTransition * _Nullable mPercentDrivenInteractiveTransition;

- (void)presentModalViewControllerWithFromVC:(UIViewController * _Nullable)fromVC fromRect:(CGRect)fromRect fromView:(UIView * _Nullable)fromView toVC:(UIViewController * _Nullable)toVC animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

- (void)dismissViewController:(UIViewController * _Nullable)objVC animated:(BOOL)flag completion:(void (^ __nullable)(void))completion;

@end
