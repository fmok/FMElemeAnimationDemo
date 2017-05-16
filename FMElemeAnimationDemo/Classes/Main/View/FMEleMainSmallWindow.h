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
- (void)tapSmallImageView;

@end

@interface FMEleMainSmallWindow : UIView

@property (nonatomic, weak) id<FMEleMainSmallWindowDelegate>delegate;
@property (nonatomic, strong) FMEleMainSmallImgView *smallImgView;

- (void)addSmallImageView;
- (void)removeSmallImageView;
- (void)updateSmallImageContent:(UIView *)smallView;

@end
