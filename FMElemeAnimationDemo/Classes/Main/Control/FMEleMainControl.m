//
//  FMEleMainControl.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/8.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMEleMainControl.h"
#import "FMEleFoodDetailController.h"
#import "FMEleJoinCartAnimation.h"

NSString *const FMEleMainListCellIdentifier = @"FMEleMainListCell";

@interface FMEleMainControl()

@property (nonatomic, strong) CALayer *dotLayer;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, copy) FMEleJoinCartAnimation *joinCartAnimation;

@end

@implementation FMEleMainControl

#pragma mark - Public methods
- (void)registerCell
{
    [self.vc.myTableView registerClass:[FMEleMainListCell class] forCellReuseIdentifier:FMEleMainListCellIdentifier];
}

- (void)loadData
{
    [self.vc.headerView updateHeaderView];
}

#pragma mark - FMEleMainListCellDelegate
- (void)dealCountAction:(NSInteger)currentCount isBoom:(BOOL)isBoom object:(FMEleMainListCell *)obj
{
    WS(weakSelf);
    if (isBoom) {
        CGRect startRect = [obj convertRect:obj.addBtn.frame toView:weakSelf.vc.view];
        CGRect endRect = [weakSelf.vc.view convertRect:weakSelf.vc.toolbar.bagBtn.frame toView:weakSelf.vc.toolbar];
        [weakSelf.joinCartAnimation joinCartAnimationWithStartRect:startRect endRect:endRect toVC:weakSelf.vc];
        weakSelf.joinCartAnimation.animationFinishedBlock = ^() {
            CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            shakeAnimation.duration = 0.15f;
            shakeAnimation.fromValue = [NSNumber numberWithFloat:0.9];
            shakeAnimation.toValue = [NSNumber numberWithFloat:1];
            shakeAnimation.autoreverses = YES;
            [weakSelf.vc.toolbar.bagBtn.layer addAnimation:shakeAnimation forKey:nil];
        };
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FMEleFoodDetailController *vc = [[FMEleFoodDetailController alloc] init];
    vc.title = [NSString stringWithFormat:@"food-%@",@(indexPath.row)];
    [self.vc.zl_navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor grayColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:16.f];
    label.text = [NSString stringWithFormat:@"   *** package - %@ ***", @(section)];
    return label;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FMEleMainListCell *cell = [tableView dequeueReusableCellWithIdentifier:FMEleMainListCellIdentifier forIndexPath:indexPath];
    [cell updateData:indexPath.section index:indexPath.row];
    cell.delegate = self;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    CGFloat contentOffsetY = [change[@"new"] CGPointValue].y;
    NSLog(@"\n*** %@ ***\n", @(contentOffsetY));
    // 标题显隐 + 列表偏移
    if (H_header_view - contentOffsetY <= 64.f) {
        self.vc.navTitleLabel.hidden = NO;
        [self.vc.myTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(64.f);
        }];
    } else {
        self.vc.navTitleLabel.hidden = YES;
        if (contentOffsetY <= 0) {
            // 向下滑动
            CGFloat offsetY = H_header_view + contentOffsetY;
            NSLog(@"&&&&&& %@ &&&&&&", @(offsetY));
            [self.vc.myTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(H_header_view);
            }];
        } else {
            // 向上滑动
            [self.vc.myTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(H_header_view-contentOffsetY);
            }];
        }
    }
    // 头部控件透明度变化
    CGFloat infoAlpha = 1.0;
    infoAlpha = (H_header_view-64.f-contentOffsetY)/(H_header_view-64.f);
    if (infoAlpha>1) {
        infoAlpha = 1;
    }
    [self.vc.headerView.infoView setSubViewsAlpha:infoAlpha];
}

#pragma mark - getter & setter
- (FMEleJoinCartAnimation *)joinCartAnimation
{
    if (!_joinCartAnimation) {
        _joinCartAnimation = [[FMEleJoinCartAnimation alloc] init];
    }
    return _joinCartAnimation;
}


@end
