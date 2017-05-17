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
@property (nonatomic, strong, readonly) FMEleMainSmallImgView *smallImgView;

- (void)addSmallImageView;
- (void)removeSmallImageView;
- (void)setSmallImageFrame:(CGRect)frame center:(CGPoint)point;
- (void)updateSmallImageContent:(UIView *)smallView;
- (void)setBottomContent;
- (void)showAnimationComplete;

@end
