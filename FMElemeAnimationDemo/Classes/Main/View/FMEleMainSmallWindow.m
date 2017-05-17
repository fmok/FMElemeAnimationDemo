//
//  FMEleMainSmallWindow.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/16.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMEleMainSmallWindow.h"

CGFloat const fractionLimit = 0.1;
CGFloat const alphaLimit = 0.07;

@interface FMEleMainSmallWindow()
{
    __block BOOL isNeedBreakPanGes;
}
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong, readwrite) FMEleMainSmallImgView *smallImgView;

@end

@implementation FMEleMainSmallWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
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
    self.smallImgView = nil;
}

- (void)setSmallImageFrame:(CGRect)frame center:(CGPoint)point
{
    self.smallImgView.frame = frame;
    self.smallImgView.center = point;
}

- (void)updateSmallImageContent:(UIView *)smallView
{
    [self.smallImgView setContentImage:smallView];
}

- (void)showAnimationComplete
{
    [self setTopDesContent];
    [self setBottomContent];
}

#pragma mark - Private methods
- (void)setTopDesContent
{
    [self addSubview:self.desLabel];
    [self updateTopDesConstraints];
}

- (void)setDesTitle:(NSString *)des
{
    self.desLabel.text = des;
}

- (void)setDesAlpha:(CGFloat)alpha
{
    if (alpha > 1) {
        alpha = 1;
    }
    self.desLabel.alpha = alpha;
}

- (void)updateTopDesConstraints
{
    WS(weakSelf);
    [self.desLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.smallImgView);
        make.bottom.equalTo(weakSelf.smallImgView.mas_top).offset(-20.f);
    }];
}

- (void)setBottomContent
{
    [self.smallImgView setBottomContent];
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(showFoodDetail)]) {
        [self.delegate showFoodDetail];
    }
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    WS(weakSelf);
    //
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    //Limit it between 0 and 1
    CGFloat fraction = translation.y / (double)Screen_height;
    fraction = fminf(fmaxf(fraction, 0.0), 1.0);
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (translation.y < 0) {
                if (!isNeedBreakPanGes && weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(showFoodDetail)]) {
                    isNeedBreakPanGes = YES;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)1*NSEC_PER_SEC), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        isNeedBreakPanGes = NO;
                    });
                    [weakSelf.delegate showFoodDetail];
                }
            } else {
                if (fraction <= alphaLimit) {
                    [weakSelf setDesAlpha:(fraction/alphaLimit)];
                }
                if (fraction < fractionLimit) {
                    [weakSelf setDesTitle:@"下滑关闭"];
                } else {
                    [weakSelf setDesTitle:@"释放关闭"];
                }
                weakSelf.smallImgView.transform = CGAffineTransformMakeTranslation(0, translation.y);
                weakSelf.desLabel.transform = CGAffineTransformMakeTranslation(0, translation.y);
                [weakSelf updateTopDesConstraints];
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if (fraction <= fractionLimit) {
                [UIView animateWithDuration:0.1 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:10 options:UIViewAnimationOptionLayoutSubviews animations:^{
                    weakSelf.desLabel.transform = CGAffineTransformIdentity;
                    weakSelf.smallImgView.transform = CGAffineTransformIdentity;
                    [weakSelf setDesAlpha:0];
                } completion:nil];
            } else {
                [UIView animateWithDuration:0.2 animations:^{
                    weakSelf.desLabel.transform = CGAffineTransformMakeTranslation(0, Screen_height);
                    weakSelf.smallImgView.transform = CGAffineTransformMakeTranslation(0, Screen_height);
                } completion:^(BOOL finished) {
                    if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(tapBlankInSmallWindow)]) {
                        [weakSelf.delegate tapBlankInSmallWindow];
                    }
                }];
            }
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
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageAction:)];
        [_smallImgView.contentImgView addGestureRecognizer:tap];
    }
    return _smallImgView;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (UILabel *)desLabel
{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _desLabel.backgroundColor = [UIColor clearColor];
        _desLabel.textColor = [UIColor whiteColor];
        _desLabel.textAlignment = NSTextAlignmentCenter;
        _desLabel.font = [UIFont systemFontOfSize:14.f];
        _desLabel.numberOfLines = 1;
    }
    return _desLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
