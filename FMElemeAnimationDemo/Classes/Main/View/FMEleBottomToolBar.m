//
//  FMEleBottomToolBar.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/9.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMEleBottomToolBar.h"

@interface FMEleBottomToolBar()

@property (nonatomic, strong) UIButton *bagBtn;
@property (nonatomic, strong) UIButton *accountBtn;

@end

@implementation FMEleBottomToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addSubview:self.bagBtn];
        [self addSubview:self.accountBtn];
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.bagBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10.f);
        make.top.equalTo(weakSelf).offset(-10.f);
        make.size.mas_equalTo(CGSizeMake(50.f, 50.f));
    }];
    [self.accountBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.right.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma mark - Events
- (void)bagAction:(UIButton *)sender
{
    NSLog(@"跳转购物车");
}

- (void)accountAction:(UIButton *)sender
{
    NSLog(@"去结算");
}

#pragma mark - getter & setter
- (UIButton *)bagBtn
{
    if (!_bagBtn) {
        _bagBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _bagBtn.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.8];
        [_bagBtn setTitle:@"bag" forState:UIControlStateNormal];
        [_bagBtn addTarget:self action:@selector(bagAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bagBtn;
}

- (UIButton *)accountBtn
{
    if (!_accountBtn) {
        _accountBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _accountBtn.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.8];
        [_accountBtn setTitle:@" account " forState:UIControlStateNormal];
        [_accountBtn addTarget:self action:@selector(accountAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _accountBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
