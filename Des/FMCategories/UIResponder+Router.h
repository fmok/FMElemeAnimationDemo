//
//  UIResponder+Router.h
//  news
//
//  Created by fm on 16/6/28.
//  Copyright © 2016年 malei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (Router)

/**
 *  发送一个路由器消息, 对eventName感兴趣的 UIResponsder 可以对消息进行处理
 *
 *  @param eventName 发生的事件名称
 *  @param userInfo  传递消息时, 携带的数据, 数据传递过程中, 会有新的数据添加
 *
 *  Created by lsb on 16/6/23.   https://github.com/lsb332/UIResponderEX
 *
 */
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end
