//
//  RightControl.m
//  FMSegmentControl
//
//  Created by fm on 2017/6/20.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "RightControl.h"

NSString *const RightCellIdentifier = @"RightCell";

@implementation RightControl

#pragma mark - Public methods
- (void)registerCell
{
    if (self.cascadeView.delegate && [self.cascadeView.delegate respondsToSelector:@selector(registerRightCell:identifier:)]) {
        [self.cascadeView.delegate registerRightCell:self.cascadeView.rightTableView identifier:RightCellIdentifier];
    }
}

- (void)loadData
{
    [self.cascadeView.rightTableView reloadData];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cascadeView.delegate && [self.cascadeView.delegate respondsToSelector:@selector(fm_right_tableView:heightForRowAtIndexPath:)]) {
        return [self.cascadeView.delegate fm_right_tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.cascadeView.delegate && [self.cascadeView.delegate respondsToSelector:@selector(fm_right_tableView:heightForHeaderInSection:)]) {
        return [self.cascadeView.delegate fm_right_tableView:tableView heightForHeaderInSection:section];
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did selected at : %@ - %@", @(indexPath.section), @(indexPath.row));
    if (self.cascadeView.delegate && [self.cascadeView.delegate respondsToSelector:@selector(fm_right_tableView:didSelectRowAtIndexPath:)]) {
        [self.cascadeView.delegate fm_right_tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.cascadeView.dataSource && [self.cascadeView.dataSource respondsToSelector:@selector(fm_right_tableView:numberOfRowsInSection:)]) {
        return [self.cascadeView.dataSource fm_right_tableView:tableView numberOfRowsInSection:section];
    }
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cascadeView.dataSource && [self.cascadeView.dataSource respondsToSelector:@selector(fm_right_tableView:cellForRowAtIndexPath:identifier:)]) {
        return [self.cascadeView.dataSource fm_right_tableView:tableView cellForRowAtIndexPath:indexPath identifier:RightCellIdentifier];
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.cascadeView.dataSource && [self.cascadeView.dataSource respondsToSelector:@selector(fm_right_numberOfSectionsInTableView:)]) {
        return [self.cascadeView.dataSource fm_right_numberOfSectionsInTableView:tableView];
    }
    return CGFLOAT_MIN;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.cascadeView.dataSource && [self.cascadeView.dataSource respondsToSelector:@selector(fm_right_tableView:titleForHeaderInSection:)]) {
        return [self.cascadeView.dataSource fm_right_tableView:tableView titleForHeaderInSection:section];
    }
    return @"";
}


@end
