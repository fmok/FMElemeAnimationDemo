//
//  FMEleFoodDetailController.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/9.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMEleFoodDetailController.h"
#import "FMEleFoodDetailControl.h"

@interface FMEleFoodDetailController ()

@property (nonatomic, strong) FMEleFoodDetailControl *control;

@end

@implementation FMEleFoodDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self fixNav];
//    [self configUI];
}

#pragma mark - Private methods
- (void)fixNav
{
    // 去掉导航底部的线
    [self.zl_navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.zl_navigationBar setShadowImage:[[UIImage alloc] init]];
    // backgroundView.alpha 设为 0
    [self.zl_navigationBar setValue:@(0) forKeyPath:@"backgroundView.alpha"];
}

- (void)configUI
{
    WS(weakSelf);
    [self.view addSubview:self.foodTableView];
    [self.foodTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}

#pragma mark - getter & setter
- (UITableView *)foodTableView
{
    if (!_foodTableView) {
        _foodTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _foodTableView.delegate = self.control;
        _foodTableView.dataSource = self.control;
    }
    return _foodTableView;
}

- (FMEleFoodDetailControl *)control
{
    if (!_control) {
        _control = [[FMEleFoodDetailControl alloc] init];
        _control.vc = self;
    }
    return _control;
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
