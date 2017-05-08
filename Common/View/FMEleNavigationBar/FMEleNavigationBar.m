//
//  FMEleNavigationBar.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/8.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMEleNavigationBar.h"

@interface FMEleNavigationBar()

@property (nonatomic, weak) UIViewController *rootViewController;
@property (nonatomic, strong, readwrite) UINavigationItem *navigationItem;

@end

@implementation FMEleNavigationBar

- (instancetype)initWithRootVC:(UIViewController *)rootVC {
    
    self = [super initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rootVC.view.frame), 64)];
    if (self) {
        self.rootViewController = rootVC;
        self.translucent = NO;
        [self configaure];
    }
    return self;
}

- (void)configaure {
    //左侧
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_back"] style:UIBarButtonItemStylePlain target:self.rootViewController action:NSSelectorFromString(@"popVC")];
    self.navigationItem.leftBarButtonItem = back;
    [self pushNavigationItem:self.navigationItem animated:NO];
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem {
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (UINavigationItem *)navigationItem {
    if (!_navigationItem) {
        _navigationItem = [[UINavigationItem alloc] initWithTitle:@""];
    }
    return _navigationItem;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
