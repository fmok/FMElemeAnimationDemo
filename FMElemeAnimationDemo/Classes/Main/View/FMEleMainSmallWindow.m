//
//  FMEleMainSmallWindow.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/16.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMEleMainSmallWindow.h"

@interface FMEleMainSmallWindow()

@property (nonatomic, strong) UIView *bgView;

@end

@implementation FMEleMainSmallWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        [self addGes];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)configUI
{
    WS(weakSelf);
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    [self addSmallImageView];
}

#pragma mark - Public methods
- (void)addSmallImageView
{
    [self addSubview:self.smallImgView];
    self.smallImgView.transform = CGAffineTransformMakeTranslation(0, 0);
}

- (void)removeSmallImageView
{
    [self.smallImgView removeFromSuperview];
    self.smallImgView.transform = CGAffineTransformMakeTranslation(0, 0);
}

- (void)updateSmallImageContent:(UIView *)smallView
{
    
}

#pragma mark - Private methods
- (void)addGes
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.bgView addGestureRecognizer:tap];
}

#pragma mark - Events
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapBlankInSmallWindow)]) {
        [self.delegate tapBlankInSmallWindow];
    }
}

- (void)tapImageAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tapSmallImageView)]) {
        [self.delegate tapSmallImageView];
    }
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    WS(weakSelf);
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            // 1. Mark the interacting flag. Used when supplying it in delegate.
        }
            
            break;
        case UIGestureRecognizerStateChanged:
        {
            // 2. Calculate the percentage of guesture
            if (translation.y < 0) {
                NSLog(@"show detail with animating");
                return;
            }
            CGFloat fraction = translation.y / (double)CGRectGetWidth([[UIScreen mainScreen] bounds]);
            //Limit it between 0 and 1
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
//            CGRect originFrame = weakSelf.smallImgView.frame;
            weakSelf.smallImgView.transform = CGAffineTransformMakeTranslation(0, translation.y);
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            // 3. Gesture over. Check if the transition should happen or not
        }
            break;
        default:
            break;
    }
}

#pragma mark - getter & setter
- (FMEleMainSmallImgView *)smallImgView
{
    if (!_smallImgView) {
        _smallImgView = [[FMEleMainSmallImgView alloc] initWithFrame:CGRectZero];
        [_smallImgView addTarget:self action:@selector(tapImageAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smallImgView;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    }
    return _bgView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
