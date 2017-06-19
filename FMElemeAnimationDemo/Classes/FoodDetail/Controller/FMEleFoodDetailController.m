//
//  FMEleFoodDetailController.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/9.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMEleFoodDetailController.h"
#import "FMEleFoodDetailControl.h"
#import "UIImageView+WebCache.h"

@interface FMEleFoodDetailController ()
{
    UIPanGestureRecognizer *pan;
}

@property (nonatomic, strong) FMEleFoodDetailControl *control;
@property (nonatomic, strong) UIButton *backBtn;

@end

@implementation FMEleFoodDetailController

- (void)dealloc
{
    NSLog(@"\n*** %@ ** %s ***\n", self.class, __func__);
    [self.view removeGestureRecognizer:pan];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    [self configUI];
    [self.control loadData];
}

#pragma mark - Private methods
- (void)configUI
{
    
}

#pragma mark - Public methods
- (void)customUI
{
    WS(weakSelf);
    [self.view addSubview:self.foodTableView];
    [self.foodTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(8.f);
        make.top.equalTo(weakSelf.view).offset(30.f);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.headerView.contentImgView sd_setImageWithURL:[NSURL URLWithString:@"http://www.qqxoo.com/uploads/allimg/170504/135QaS5-3.jpg"] placeholderImage:nil options:SDWebImageRetryFailed completed:nil];
    [self.headerView setBottomContent];
}

#pragma mark - Events
- (void)backAction:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenSmallWindow" object:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    //Limit it between 0 and 1
    CGFloat fraction = translation.y / (double)Screen_height;
    fraction = fminf(fmaxf(fraction, 0.0), 1.0);
    if (fraction >= 0.15) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

#pragma mark - Override methods
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [self.control routerEventWithName:eventName userInfo:userInfo];
}

#pragma mark - getter & setter
- (UITableView *)foodTableView
{
    if (!_foodTableView) {
        _foodTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _foodTableView.delegate = self.control;
        _foodTableView.dataSource = self.control;
        _foodTableView.tableHeaderView = self.headerView;
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

- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_backBtn setImage:[UIImage imageNamed:@"top_navigation_back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (FMEleMainSmallImgView *)headerView
{
    if (!_headerView) {
        _headerView = [[FMEleMainSmallImgView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, Screen_height*3/4.f)];
    }
    return _headerView;
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
