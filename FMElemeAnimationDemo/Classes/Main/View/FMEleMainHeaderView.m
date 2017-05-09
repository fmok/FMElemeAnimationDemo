//
//  FMEleMainHeaderView.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/8.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMEleMainHeaderView.h"

@implementation FMEleMainHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.infoView];
    }
    return self;
}

- (void)updateConstraints
{
    __weak typeof(self) weakSelf = self;
    [self.infoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.and.right.equalTo(weakSelf);
    }];
    [super updateConstraints];
}


#pragma mark - Public methods
- (void)updateHeaderView
{
    [self.infoView updateInfoView];
}

#pragma mark - getter & setter
- (FMEleMainHeaderInfoView *)infoView
{
    if (!_infoView) {
        _infoView = [[FMEleMainHeaderInfoView alloc] init];
    }
    return _infoView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
