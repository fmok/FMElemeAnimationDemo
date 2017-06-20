//
//  LeftControl.h
//  FMSegmentControl
//
//  Created by fm on 2017/6/20.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMCascadeView.h"
#import "LeftCell.h"

@interface LeftControl : NSObject<
    UITableViewDelegate,
    UITableViewDataSource>

@property (nonatomic, weak) FMCascadeView *cascadeView;

- (void)registerCell;
- (void)loadData;

@end
