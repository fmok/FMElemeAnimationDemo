//
//  UIResponder+Router.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/17.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [self.nextResponder routerEventWithName:eventName userInfo:userInfo];
}

@end
