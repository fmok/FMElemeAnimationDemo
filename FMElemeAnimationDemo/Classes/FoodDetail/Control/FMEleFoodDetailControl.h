//
//  FMEleFoodDetailControl.h
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/9.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMEleFoodDetailController.h"

@interface FMEleFoodDetailControl : NSObject<
    UITableViewDelegate,
    UITableViewDataSource>

@property (nonatomic, weak) FMEleFoodDetailController *vc;

@end
