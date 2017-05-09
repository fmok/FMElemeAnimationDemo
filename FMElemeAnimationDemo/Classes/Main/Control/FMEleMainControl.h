//
//  FMEleMainControl.h
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/8.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMEleMainViewController.h"
#import "FMEleMainListCell.h"

@interface FMEleMainControl : NSObject<
    UITableViewDelegate,
    UITableViewDataSource>

@property (nonatomic, weak) FMEleMainViewController *vc;

- (void)registerCell;
- (void)loadData;

@end
