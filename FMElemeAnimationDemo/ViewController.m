//
//  ViewController.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/8.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "ViewController.h"
#import "FMEleMainViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *startBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.zl_navigationBarHidden = YES;
    WS(weakSelf);
    [self.view addSubview:self.startBtn];
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

#pragma mark - Private methods
- (void)startClick:(UIButton *)sender
{
    FMEleMainViewController *vc = [[FMEleMainViewController alloc] init];
    vc.title = @"肯德基宅急送（育知东路店）";
    [self.zl_navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter & setter
- (UIButton *)startBtn
{
    if (!_startBtn) {
        _startBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        _startBtn.backgroundColor = [UIColor yellowColor];
        [_startBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_startBtn setTitle:@"start" forState:UIControlStateNormal];
        _startBtn.layer.cornerRadius = 50.f;
        [_startBtn addTarget:self action:@selector(startClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
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
