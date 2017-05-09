//
//  FMBaseViewController.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/8.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMBaseViewController.h"
#import "YYFPSLabel.h"

@interface FMBaseViewController ()

@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@end

@implementation FMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.zl_automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavLeftBarButtonItem];
}

#pragma mark - Public methods
- (void)showFpsLabel
{
    WS(weakSelf);
    [self.view addSubview:self.fpsLabel];
    [self.fpsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view).offset(0.f);
        make.top.equalTo(weakSelf.view).offset(20.f);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
}

#pragma mark - Private methods
- (void)setNavLeftBarButtonItem
{
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_back"] style:UIBarButtonItemStylePlain target:self action:@selector(popVC)];
    self.zl_navigationItem.leftBarButtonItems = @[backBtn];
    [self.zl_navigationBar setBarTintColor:[UIColor whiteColor]];
    self.zl_navigationBar.tintColor = [UIColor grayColor];
}

- (void)popVC
{
    [self.zl_navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter & setter
- (YYFPSLabel *)fpsLabel
{
    if (!_fpsLabel) {
        _fpsLabel = [[YYFPSLabel alloc] init];
    }
    return _fpsLabel;
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
