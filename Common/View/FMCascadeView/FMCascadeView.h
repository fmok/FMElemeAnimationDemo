//
//  FMCascadeView.h
//  FMCascadeView
//
//  Created by fm on 2017/6/20.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FMCascadeViewDelegate <NSObject>

#pragma mark - LeftControl
- (void)registerLeftCell:(UITableView * _Nullable)tableView identifier:(NSString * _Nullable)identifier;
- (CGFloat)fm_left_tableView:(UITableView * _Nullable)tableView heightForRowAtIndexPath:(NSIndexPath * _Nullable)indexPath;
- (void)fm_left_tableView:(UITableView * _Nullable)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nullable)indexPath;

#pragma mark - RightControl
- (void)registerRightCell:(UITableView * _Nullable)tableView identifier:(NSString * _Nullable)identifier;
- (CGFloat)fm_right_tableView:(UITableView * _Nullable)tableView heightForRowAtIndexPath:(NSIndexPath * _Nullable)indexPath;
- (CGFloat)fm_right_tableView:(UITableView * _Nullable)tableView heightForHeaderInSection:(NSInteger)section;
- (void)fm_right_tableView:(UITableView * _Nullable)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nullable)indexPath;

@end

@protocol FMCascadeViewDataSource <NSObject>

#pragma mark - LeftControl
- (NSInteger)fm_left_tableView:(UITableView * _Nullable)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * _Nullable)fm_left_tableView:(UITableView * _Nullable)tableView cellForRowAtIndexPath:(NSIndexPath * _Nullable)indexPath identifier:(NSString * _Nullable)identifier;
- (NSInteger)fm_left_numberOfSectionsInTableView:(UITableView * _Nullable)tableView;

#pragma mark - RightControl
- (NSInteger)fm_right_tableView:(UITableView * _Nullable)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * _Nullable)fm_right_tableView:(UITableView * _Nullable)tableView cellForRowAtIndexPath:(NSIndexPath * _Nullable)indexPath identifier:(NSString * _Nullable)identifier;
- (NSInteger)fm_right_numberOfSectionsInTableView:(UITableView * _Nullable)tableView;
- (NSString * _Nullable)fm_right_tableView:(UITableView * _Nullable)tableView titleForHeaderInSection:(NSInteger)section;

@end

@interface FMCascadeView : UIView

@property (nonatomic, weak) id<FMCascadeViewDelegate> _Nullable delegate;
@property (nonatomic, weak) id<FMCascadeViewDataSource> _Nullable dataSource;

@property (nonatomic, strong, readonly) UITableView *_Nullable leftTableView;
@property (nonatomic, strong, readonly) UITableView *_Nullable rightTableView;

- (void)configuration;
- (void)loadData;
- (BOOL)isRightListIsDragging;
- (BOOL)isRightListIsDecelerating;

@end
