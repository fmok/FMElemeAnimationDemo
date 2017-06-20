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
#import "FMEleBottomToolBar.h"
#import "FMEleMainSmallWindow.h"
#import "FMCascadeView.h"

#define SECTION_COUNT 20

@interface FMEleMainViewController : FMBaseViewController

@property (nonatomic, strong) FMCascadeView *cascadeView;
@property (nonatomic, strong) UILabel *navTitleLabel;
@property (nonatomic, strong) FMEleMainHeaderView *headerView;
@property (nonatomic, strong) FMEleBottomToolBar *toolbar;

@property (nonatomic, strong) FMEleMainSmallWindow *smallWindow;

@end
