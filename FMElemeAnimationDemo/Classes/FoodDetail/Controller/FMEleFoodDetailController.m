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
    [self configUI];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    [self addGes];
}

#pragma mark - Private methods
- (void)addGes
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)configUI
{
    WS(weakSelf);
//    [self.view addSubview:self.smallWindow];
//    [self.smallWindow mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(weakSelf.view);
//        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width*0.8, self.view.frame.size.height*0.6));
//    }];
}

#pragma mark - ges
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

//- (FMEleDetailSmallWindow *)smallWindow
//{
//    if (!_smallWindow) {
//        _smallWindow = [[FMEleDetailSmallWindow alloc] initWithFrame:CGRectZero];
//    }
//    return _smallWindow;
//}

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
