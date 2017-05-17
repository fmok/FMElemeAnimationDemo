//
//  FMEleMainSmallWindow.h
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/16.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMEleMainSmallImgView.h"

@protocol FMEleMainSmallWindowDelegate <NSObject>

- (void)tapBlankInSmallWindow;
- (void)showFoodDetail;

@end

@interface FMEleMainSmallWindow : UIView

@property (nonatomic, weak) id<FMEleMainSmallWindowDelegate>delegate;

- (void)addSmallImageView;
- (void)removeSmallImageView;
- (void)setSmallImageFrame:(CGRect)frame;
- (void)setSmallImageCenter:(CGPoint)point;
- (void)updateSmallImageContent:(UIView *)smallView;
- (void)setBottomContent;


@end
