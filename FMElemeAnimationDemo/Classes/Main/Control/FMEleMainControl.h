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
#import "LeftCell.h"

@interface FMEleMainControl : NSObject<
    FMEleMainListCellDelegate,
    FMEleMainSmallWindowDelegate,
    FMCascadeViewDelegate,
    FMCascadeViewDataSource>

@property (nonatomic, weak) FMEleMainViewController *vc;

- (void)loadData;
- (void)hiddenSmallWindow;
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;
- (void)updateToOrginFrame:(NSNotification *)notifi;

@end
