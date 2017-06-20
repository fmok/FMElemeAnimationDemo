//
//  FMEleMainSmallImgView.h
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/16.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define W_SMALL_IMAGE Screen_width*0.8
#define H_SMALL_IMAGE Screen_height*0.6

@interface FMEleMainSmallImgView : UIView

@property (nonatomic, strong, readonly) UIImageView *contentImgView;

- (void)setContentImage:(UIView *)tmpImage;
- (void)setBottomContent;

@end
