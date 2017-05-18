//
//  FMEleFoodDetailController.h
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/9.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMBaseViewController.h"
#import "FMEleMainSmallImgView.h"

@interface FMEleFoodDetailController : FMBaseViewController

@property (nonatomic, strong) UITableView *foodTableView;
@property (nonatomic, strong) FMEleMainSmallImgView *headerView;

- (void)customUI;

@end
