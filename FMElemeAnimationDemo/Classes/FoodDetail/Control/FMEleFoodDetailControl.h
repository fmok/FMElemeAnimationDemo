//
//  FMEleFoodDetailControl.h
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/9.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMEleFoodDetailController.h"
#import "FMEleFoodDetailCell.h"

@interface FMEleFoodDetailControl : NSObject<
    UITableViewDelegate,
    UITableViewDataSource>

@property (nonatomic, weak) FMEleFoodDetailController *vc;

- (void)loadData;
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end
