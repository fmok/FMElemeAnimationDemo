//
//  Tools.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/22.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (UIView *)customSnapShotFromView:(UIView *)inputView
{
    // Make an image from the input view.
    CGSize size = inputView.bounds.size;
    size.height -= 1;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.1;
    snapshot.backgroundColor = [UIColor clearColor];
    
    return snapshot;
}

@end
