//
//  FMEleMainHeaderInfoView.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/8.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMEleMainHeaderInfoView.h"
#import "UIImageView+WebCache.h"

@interface FMEleMainHeaderInfoView()

@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *desLabel;

@end

@implementation FMEleMainHeaderInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgImgView];
        [self addSubview:self.imgView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.desLabel];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)updateConstraints
{
    __weak typeof(self) weakSelf = self;
    [self.bgImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(64.f);
        make.left.equalTo(weakSelf).offset(10.f);
        make.size.mas_equalTo(CGSizeMake(50.f, 50.f));
    }];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.imgView.mas_right).offset(10.f);
        make.top.equalTo(weakSelf.imgView);
    }];
    [self.desLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.imgView.mas_bottom);
        make.left.equalTo(weakSelf.imgView.mas_right).offset(10.f);
    }];
    
    [super updateConstraints];
}

#pragma mark - Events
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    NSLog(@"跳转商家详情");
    [self.nextResponder routerEventWithName:MD_The_Store userInfo:nil];
}

#pragma mark - Public methods
- (void)updateInfoView
{
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:@"http://img.redocn.com/sheying/20140926/changdou_3143149.jpg"] placeholderImage:nil options:SDWebImageRetryFailed completed:nil];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img.woyaogexing.com/touxiang/katong/20140110/864ea8353fe3edd3.jpg%21200X200.jpg"] placeholderImage:nil options:SDWebImageRetryFailed completed:nil];
    self.titleLabel.text = @"肯德基宅急送（育知东路店）";
    self.desLabel.text = @"商家配送  平均40分钟  配送费￥9";
    [self setNeedsUpdateConstraints];
}

- (void)setSubViewsAlpha:(CGFloat)alpha
{
    self.imgView.alpha = alpha;
    self.titleLabel.alpha = alpha;
    self.desLabel.alpha = alpha;
}

#pragma mark - getter & setter
- (UIImageView *)bgImgView
{
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgImgView.backgroundColor = [UIColor blueColor];
        _bgImgView.contentMode = UIViewContentModeTop;
    }
    return _bgImgView;
}

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.backgroundColor = [UIColor yellowColor];
    }
    return _imgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UILabel *)desLabel
{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _desLabel.font = [UIFont systemFontOfSize:12.f];
        _desLabel.textColor = [UIColor whiteColor];
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
