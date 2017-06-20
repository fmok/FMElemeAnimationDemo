//
//  FMCascadeView.m
//  FMCascadeView
//
//  Created by fm on 2017/6/20.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMCascadeView.h"
#import "LeftControl.h"
#import "RightControl.h"

@interface FMCascadeView()

@property (nonatomic, strong) LeftControl *leftControl;
@property (nonatomic, strong) RightControl *rightControl;

@end

@implementation FMCascadeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftTableView];
        [self addSubview:self.rightTableView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(weakSelf);
        make.width.mas_equalTo(Screen_width*0.3);
    }];
    [self.rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftTableView.mas_right);
        make.top.and.right.and.bottom.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)configuration
{
    [self.leftControl registerCell];
    [self.rightControl registerCell];
}

- (void)loadData
{
    [self.leftControl loadData];
    [self.rightControl loadData];
}

- (BOOL)isRightListIsDragging
{
    return self.rightTableView.isDragging;
}

#pragma mark - getter & setter
- (UITableView *)leftTableView
{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.delegate = self.leftControl;
        _leftTableView.dataSource = self.leftControl;
    }
    return _leftTableView;
}

- (UITableView *)rightTableView
{
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTableView.showsVerticalScrollIndicator = NO;
        _rightTableView.delegate = self.rightControl;
        _rightTableView.dataSource = self.rightControl;
    }
    return _rightTableView;
}

- (LeftControl *)leftControl
{
    if (!_leftControl) {
        _leftControl = [[LeftControl alloc] init];
        _leftControl.cascadeView = self;
    }
    return _leftControl;
}

- (RightControl *)rightControl
{
    if (!_rightControl) {
        _rightControl = [[RightControl alloc] init];
        _rightControl.cascadeView = self;
    }
    return _rightControl;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
