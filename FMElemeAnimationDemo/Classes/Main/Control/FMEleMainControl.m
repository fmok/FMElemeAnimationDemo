//
//  FMEleMainControl.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/8.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMEleMainControl.h"
#import "FMEleFoodDetailController.h"

NSString *const FMEleMainListCellIdentifier = @"FMEleMainListCell";

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
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FMEleMainListCell *cell = [tableView dequeueReusableCellWithIdentifier:FMEleMainListCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",@(indexPath.row)];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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



@end
