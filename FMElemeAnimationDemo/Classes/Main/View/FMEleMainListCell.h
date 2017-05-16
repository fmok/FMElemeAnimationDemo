//
//  FMEleMainListCell.h
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/8.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMEleMainListCell;

@protocol FMEleMainListCellDelegate <NSObject>

- (void)dealCountAction:(NSInteger)currentCount isBoom:(BOOL)isBoom object:(FMEleMainListCell *)obj;

@end

@interface FMEleMainListCell : UITableViewCell

@property (nonatomic, strong, readonly) UIImageView *imgView;
@property (nonatomic, strong, readonly) UIButton *addBtn;
@property (nonatomic, weak) id<FMEleMainListCellDelegate>delegate;

- (void)updateData:(NSInteger)section index:(NSInteger)index;

@end
