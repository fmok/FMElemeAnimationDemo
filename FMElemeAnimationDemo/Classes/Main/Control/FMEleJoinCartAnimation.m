//
//  FMEleJoinCartAnimation.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/9.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMEleJoinCartAnimation.h"

@interface FMEleJoinCartAnimation()<CAAnimationDelegate>

@property (nonatomic, strong) CALayer *dotLayer;
@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation FMEleJoinCartAnimation

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Animation
- (void)joinCartAnimationWithStartRect:(CGRect)startRect endRect:(CGRect)endRect toVC:(UIViewController *)toVC
{
    CGFloat endPoint_x = endRect.origin.x+endRect.size.width/2.f;
    CGFloat endPoint_y = -(endRect.origin.y+endRect.size.height/2.f);
    
    CGFloat startPoint_X = startRect.origin.x;
    CGFloat startPoint_Y = startRect.origin.y;
    
    _path = [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(startPoint_X, startPoint_Y)];
    [_path addCurveToPoint:CGPointMake(endPoint_x, endPoint_y) controlPoint1:CGPointMake(startPoint_X, startPoint_Y) controlPoint2:CGPointMake(startPoint_X - 180, startPoint_Y - 100)];
    
    _dotLayer = [CALayer layer];
    _dotLayer.backgroundColor = [UIColor blueColor].CGColor;
    _dotLayer.frame = CGRectMake(0, 0, 20.f, 20.f);
    _dotLayer.cornerRadius = 10.f;
    [toVC.view.layer addSublayer:_dotLayer];
    
    [self groupAnimation];
}

- (void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.2f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,alphaAnimation];
    groups.duration = 0.3f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    [_dotLayer addAnimation:groups forKey:nil];
    [self performSelector:@selector(removeFromLayer:) withObject:_dotLayer afterDelay:0.3f];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([[anim valueForKey:@"animationName"]isEqualToString:@"groupsAnimation"] && _animationFinishedBlock) {
        self.animationFinishedBlock();
    }
}

- (void)removeFromLayer:(CALayer *)layer
{
    [layer removeFromSuperlayer];
}


@end
