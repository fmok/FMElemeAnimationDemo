//
//  FMEleMainSmallImgView.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/16.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMEleMainSmallImgView.h"
#import "UIImageView+WebCache.h"

@interface FMEleMainSmallImgView()

@property (nonatomic, strong, readwrite) UIImageView *contentImgView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *desTextLabel;
@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation FMEleMainSmallImgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentImgView];
        self.layer.cornerRadius = 10.f;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    CGFloat H = self.frame.size.height;
    [self.contentImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(weakSelf);
        make.height.mas_equalTo(H*0.7);
    }];
    
    [super updateConstraints];
}

#pragma mark - Private methods
- (void)updateBottomViewConstraints
{
    WS(weakSelf);
    CGFloat H = self.frame.size.height;
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.contentImgView);
        make.top.equalTo(weakSelf.contentImgView.mas_bottom);
        make.height.mas_equalTo(H*0.3);
    }];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bottomView).offset(10.f);
        make.top.equalTo(weakSelf.bottomView).offset(10.f);
    }];
    [self.desTextLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bottomView).offset(10.f);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(10.f);
    }];
    
    [self.addBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.bottomView).offset(-10.f);
        make.bottom.equalTo(weakSelf.bottomView).offset(-10.f);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
}

- (void)drawCorner:(UIView *)view cornerDirection:(UIRectCorner)rectCorner
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.frame byRoundingCorners:rectCorner cornerRadii:CGSizeMake(10.0f, 10.0f)];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.bounds = view.frame;
    layer.position = view.center;
    layer.path = path.CGPath;
    view.layer.mask = layer;
}

#pragma mark - Public methods
- (void)setContentImage:(UIView *)tmpImage
{
    WS(weakSelf);
    [self.contentImgView addSubview:tmpImage];
    [tmpImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentImgView);
    }];
    [self.contentImgView sd_setImageWithURL:[NSURL URLWithString:@"http://www.qqxoo.com/uploads/allimg/170504/135QaS5-3.jpg"] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [tmpImage removeFromSuperview];
    }];
}

- (void)setBottomContent
{
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.titleLabel];
    [self.bottomView addSubview:self.desTextLabel];
    [self.bottomView addSubview:self.addBtn];
    
    [self updateBottomViewConstraints];
    
    self.titleLabel.text = @"香辣鸡腿堡";
    self.desTextLabel.text = @"劲辣、香脆可口，略略略";
    
    [self updateBottomViewConstraints];
}

#pragma mark - Evevnts
- (void)addChartAction:(UIButton *)sender
{
    [self.nextResponder routerEventWithName:MD_ADD_CHART userInfo:nil];
}

#pragma mark - getter & setter
- (UIImageView *)contentImgView
{
    if (!_contentImgView) {
        _contentImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _contentImgView.backgroundColor = [UIColor clearColor];
        _contentImgView.userInteractionEnabled = YES;
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

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
    }
    return _titleLabel;
}

- (UILabel *)desTextLabel
{
    if (!_desTextLabel) {
        _desTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _desTextLabel.textColor = [UIColor grayColor];
        _desTextLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _desTextLabel;
}

- (UIButton *)addBtn
{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _addBtn.backgroundColor = [UIColor blueColor];
        _addBtn.layer.cornerRadius = 15.f;
        _addBtn.clipsToBounds = YES;
        [_addBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        _addBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_addBtn addTarget:self action:@selector(addChartAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
