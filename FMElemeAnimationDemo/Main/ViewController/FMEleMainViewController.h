//
//  FMEleMainViewController.h
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/8.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMBaseViewController.h"
#import "FMEleMainHeaderView.h"

@interface FMEleMainViewController : FMBaseViewController

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UILabel *navTitleLabel;
@property (nonatomic, strong) FMEleMainHeaderView *headerView;

@end
