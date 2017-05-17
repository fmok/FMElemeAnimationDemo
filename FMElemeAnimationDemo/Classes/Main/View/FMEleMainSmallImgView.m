//
//  FMEleMainSmallImgView.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/16.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMEleMainSmallImgView.h"

@interface FMEleMainSmallImgView()

@property (nonatomic ,strong) UILabel *desLabel;
@property (nonatomic, strong) UIView *contentImgView;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation FMEleMainSmallImgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.desLabel];
        [self addSubview:self.contentImgView];
        [self addSubview:self.bottomView];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    CGFloat H = self.frame.size.height;
    [self.desLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.equalTo(weakSelf);
        make.height.mas_equalTo(H*0.1);
    }];
    [self.contentImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf.desLabel.mas_bottom);
        make.height.mas_equalTo(H*0.5);
    }];
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.equalTo(weakSelf.contentImgView);
//        make.bottom.equalTo(weakSelf);
        make.top.equalTo(weakSelf.contentImgView.mas_bottom);
        make.height.mas_equalTo(H*0.4);
    }];
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)setContentImage:(UIView *)image
{
    WS(weakSelf);
    [self.contentImgView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentImgView);
    }];
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

#pragma mark - getter & setter
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

- (UIView *)contentImgView
{
    if (!_contentImgView) {
        _contentImgView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentImgView.backgroundColor = [UIColor redColor];
    }
    return _contentImgView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
