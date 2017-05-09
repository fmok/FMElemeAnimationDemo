//
//  FMEleMainListCell.h
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/8.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btnPulsBlock)(NSInteger count, BOOL animated);

@interface FMEleMainListCell : UITableViewCell

@property (nonatomic, strong, readonly) UIButton *addBtn;
@property (nonatomic, copy) btnPulsBlock block;

- (void)updateData:(NSInteger)section index:(NSInteger)index;

@end
