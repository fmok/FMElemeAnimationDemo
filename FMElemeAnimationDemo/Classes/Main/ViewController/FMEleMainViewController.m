//
//  FMEleMainViewController.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/8.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMEleMainViewController.h"
#import "FMEleMainControl.h"
#import "FMEleNavigationBar.h"

@interface FMEleMainViewController ()

@property (nonatomic, strong) FMEleMainControl *control;
@property (nonatomic, strong) FMEleNavigationBar *navigationBar;

@end

@implementation FMEleMainViewController

- (void)dealloc
{
    [self.myTableView removeObserver:self.control forKeyPath:@"contentOffset" context:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
    [self.control registerCell];
    [self customNav];
    [self.control loadData];
    [self.myTableView addObserver:self.control forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self.myTableView sendSubviewToBack:self.headerView];
}

#pragma mark - Private methods
- (void)configUI
{
    WS(weakSelf);
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(weakSelf.view);
        make.height.mas_equalTo(H_header_view);
    }];
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(H_header_view);
        make.bottom.equalTo(weakSelf.view);
    }];
    [self.view addSubview:self.toolbar];
    [self.toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(H_EleBottomToolBar);
    }];
}

- (void)customNav
{
    self.zl_navigationBarHidden = YES;
    self.navigationBar.navigationItem.titleView = self.navTitleLabel;
    [self.navTitleLabel sizeToFit];
    [self.view addSubview:self.navigationBar];
}

#pragma mark - Override 
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    if ([eventName isEqualToString:MD_The_Store]) {
        FMBaseViewController *vc = [[FMBaseViewController alloc] init];
        vc.title = @"商家详情";
        [self.zl_navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - getter & setter
- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _myTableView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        _myTableView.delegate = self.control;
        _myTableView.dataSource = self.control;
        _myTableView.contentInset = UIEdgeInsetsMake(0, 0, H_EleBottomToolBar, 0);
    }
    return _myTableView;
}

- (FMEleMainControl *)control
{
    if (!_control) {
        _control = [[FMEleMainControl alloc] init];
        _control.vc = self;
    }
    return _control;
}

- (FMEleNavigationBar *)navigationBar
{
    if (!_navigationBar) {
        _navigationBar = [[FMEleNavigationBar alloc] initWithRootVC:self];
        [_navigationBar setTintColor:[UIColor whiteColor]];
        // 去掉导航底部的线
        [_navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [_navigationBar setShadowImage:[[UIImage alloc] init]];
        // backgroundView.alpha 设为 0
        [_navigationBar setValue:@(0) forKeyPath:@"backgroundView.alpha"];
    }
    return _navigationBar;
}

- (UILabel *)navTitleLabel
{
    if (!_navTitleLabel) {
        _navTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _navTitleLabel.textColor = [UIColor whiteColor];
        _navTitleLabel.font = [UIFont systemFontOfSize:18.f];
        _navTitleLabel.text = self.title;
        _navTitleLabel.hidden = YES;
    }
    return _navTitleLabel;
}

- (FMEleMainHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[FMEleMainHeaderView alloc] initWithFrame:CGRectZero];
    }
    return _headerView;
}

- (FMEleBottomToolBar *)toolbar
{
    if (!_toolbar) {
        _toolbar = [[FMEleBottomToolBar alloc] initWithFrame:CGRectZero];
    }
    return _toolbar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
