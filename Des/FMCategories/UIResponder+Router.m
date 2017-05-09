//
//  UIResponder+Router.m
//  news
//
//  Created by fm on 16/6/28.
//  Copyright © 2016年 malei. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
