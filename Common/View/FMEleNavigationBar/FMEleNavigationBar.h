//
//  FMEleNavigationBar.h
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/8.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMEleNavigationBar : UINavigationBar

@property (nonatomic, strong ,readonly) UINavigationItem *navigationItem;

@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;

- (instancetype)initWithRootVC:(UIViewController *)rootVC;

@end
