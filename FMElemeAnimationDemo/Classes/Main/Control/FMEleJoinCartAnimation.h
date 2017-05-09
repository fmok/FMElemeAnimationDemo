//
//  FMEleJoinCartAnimation.h
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/9.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMEleJoinCartAnimation : NSObject

@property (nonatomic, copy) void(^animationFinishedBlock)();

- (void)joinCartAnimationWithStartRect:(CGRect)startRect endRect:(CGRect)endRect toVC:(UIViewController *)toVC;

@end
