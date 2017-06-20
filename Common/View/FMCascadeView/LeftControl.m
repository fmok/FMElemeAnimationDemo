//
//  LeftControl.m
//  FMSegmentControl
//
//  Created by fm on 2017/6/20.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "LeftControl.h"

NSString *const LeftCellIdentifier = @"LeftCell";

@implementation LeftControl

#pragma mark - Public methods
- (void)registerCell
{
    if (self.cascadeView.delegate && [self.cascadeView.delegate respondsToSelector:@selector(registerLeftCell:identifier:)]) {
        [self.cascadeView.delegate registerLeftCell:self.cascadeView.leftTableView identifier:LeftCellIdentifier];
    }
}

- (void)loadData
{
    [self.cascadeView.leftTableView reloadData];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cascadeView.delegate && [self.cascadeView.delegate respondsToSelector:@selector(fm_left_tableView:heightForRowAtIndexPath:)]) {
        return [self.cascadeView.delegate fm_left_tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did selected at : %@ - %@", @(indexPath.section), @(indexPath.row));
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
    [self.cascadeView.rightTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
    if (self.cascadeView.delegate && [self.cascadeView.delegate respondsToSelector:@selector(fm_left_tableView:didSelectRowAtIndexPath:)]) {
        [self.cascadeView.delegate fm_left_tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.cascadeView.dataSource && [self.cascadeView.dataSource respondsToSelector:@selector(fm_left_tableView:numberOfRowsInSection:)]) {
        return [self.cascadeView.dataSource fm_left_tableView:tableView numberOfRowsInSection:section];
    }
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cascadeView.dataSource && [self.cascadeView.dataSource respondsToSelector:@selector(fm_left_tableView:cellForRowAtIndexPath:identifier:)]) {
        return [self.cascadeView.dataSource fm_left_tableView:tableView cellForRowAtIndexPath:indexPath identifier:LeftCellIdentifier];
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.cascadeView.dataSource && [self.cascadeView.dataSource respondsToSelector:@selector(fm_left_numberOfSectionsInTableView:)]) {
        return [self.cascadeView.dataSource fm_left_numberOfSectionsInTableView:tableView];
    }
    return CGFLOAT_MIN;
}


@end
