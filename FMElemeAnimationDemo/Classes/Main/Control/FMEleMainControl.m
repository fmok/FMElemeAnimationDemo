//
//  FMEleMainControl.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/8.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMEleMainControl.h"
#import "FMEleFoodDetailController.h"
#import "FMEleJoinCartAnimation.h"

NSString *const FMEleMainListCellIdentifier = @"FMEleMainListCell";

@interface FMEleMainControl()
{
    CGRect currentSelectImgRect;
    BOOL isSmallWindowAnimating;
    CGRect oldFrame;
}

@property (nonatomic, strong) CALayer *dotLayer;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, copy) FMEleJoinCartAnimation *joinCartAnimation;
@property (nonatomic, strong) FMPanModalTransition *transition;

@end

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

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    if ([eventName isEqualToString:MD_The_Store]) {
        FMBaseViewController *vc = [[FMBaseViewController alloc] init];
        vc.title = @"商家详情";
        [self.vc.zl_navigationController pushViewController:vc animated:YES];
    } else if ([eventName isEqualToString:MD_ADD_CHART]) {
        // 添加购物车
//        [self hiddenSmallWindow];
    }
}

- (void)updateToOrginFrame:(NSNotification *)notifi
{
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        self.vc.smallWindow.smallImgView.frame = oldFrame;
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - Private methods
- (void)showSmallWindowWithStartView:(UIView *)startView withAnimation:(BOOL)isAnimating
{
    WS(weakSelf);
    [self.vc.view addSubview:self.vc.smallWindow];
    self.vc.smallWindow.frame = self.vc.view.frame;
    [self.vc.smallWindow addSmallImageView];
    if (isAnimating) {
        isSmallWindowAnimating = YES;
        [self.vc.smallWindow setSmallImageFrame:currentSelectImgRect center:CGPointMake(CGRectGetMidX(currentSelectImgRect), CGRectGetMidY(currentSelectImgRect))];
        __weak typeof(startView) weakStartView = startView;
        [self.vc.smallWindow updateSmallImageContent:[Tools customSnapShotFromView:weakStartView]];
        [UIView transitionWithView:self.vc.smallWindow duration:0.3 options:UIViewAnimationOptionLayoutSubviews|UIViewAnimationOptionCurveEaseIn animations:^{
            [weakSelf.vc.smallWindow setSmallImageFrame:CGRectMake(0, 0, W_SMALL_IMAGE, H_SMALL_IMAGE) center:weakSelf.vc.smallWindow.center];
        } completion:^(BOOL finished) {
            [weakSelf.vc.smallWindow showAnimationComplete];
            isSmallWindowAnimating = NO;
        }];
    } else {
        [self.vc.smallWindow updateSmallImageContent:[Tools customSnapShotFromView:startView]];
        [self.vc.smallWindow setSmallImageFrame:CGRectMake(0, 0, W_SMALL_IMAGE, H_SMALL_IMAGE) center:weakSelf.vc.smallWindow.center];
        [self.vc.smallWindow showAnimationComplete];
    }
}

- (void)hiddenSmallWindow
{
    if (!isSmallWindowAnimating) {
        [self.vc.smallWindow removeSmallImageView];
        [self.vc.smallWindow removeFromSuperview];
    }
}

#pragma mark - FMEleMainListCellDelegate
- (void)dealCountAction:(NSInteger)currentCount isBoom:(BOOL)isBoom object:(FMEleMainListCell *)obj
{
    WS(weakSelf);
    if (isBoom) {
        CGRect startRect = [obj convertRect:obj.addBtn.frame toView:weakSelf.vc.view];
        CGRect endRect = [weakSelf.vc.view convertRect:weakSelf.vc.toolbar.bagBtn.frame toView:weakSelf.vc.toolbar];
        [weakSelf.joinCartAnimation joinCartAnimationWithStartRect:startRect endRect:endRect toVC:weakSelf.vc];
        weakSelf.joinCartAnimation.animationFinishedBlock = ^() {
            CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            shakeAnimation.duration = 0.15f;
            shakeAnimation.fromValue = [NSNumber numberWithFloat:0.9];
            shakeAnimation.toValue = [NSNumber numberWithFloat:1];
            shakeAnimation.autoreverses = YES;
            [weakSelf.vc.toolbar.bagBtn.layer addAnimation:shakeAnimation forKey:nil];
        };
    }
}

#pragma mark - FMEleMainSmallWindowDelegate
- (void)tapBlankInSmallWindow
{
    [self hiddenSmallWindow];
}

- (void)showFoodDetail
{
    FMEleFoodDetailController *vc = [[FMEleFoodDetailController alloc] init];
    oldFrame = self.vc.smallWindow.smallImgView.frame;
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        self.vc.smallWindow.smallImgView.frame = CGRectMake(0, 0, Screen_width, Screen_width*oldFrame.size.height/oldFrame.size.width);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.vc presentViewController:vc animated:NO completion:^{
                [vc customUI];
            }];
        });
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FMEleMainListCell *currentCell = [tableView cellForRowAtIndexPath:indexPath];
    currentSelectImgRect = [currentCell convertRect:currentCell.imgView.frame toView:self.vc.view];
    [self showSmallWindowWithStartView:currentCell.imgView withAnimation:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor grayColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:16.f];
    label.text = [NSString stringWithFormat:@"   *** package - %@ ***", @(section)];
    return label;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FMEleMainListCell *cell = [tableView dequeueReusableCellWithIdentifier:FMEleMainListCellIdentifier forIndexPath:indexPath];
    [cell updateData:indexPath.section index:indexPath.row];
    cell.delegate = self;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
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
    if (infoAlpha > 1) {
        infoAlpha = 1;
    }
    [self.vc.headerView.infoView setSubViewsAlpha:infoAlpha];
}

#pragma mark - getter & setter
- (FMEleJoinCartAnimation *)joinCartAnimation
{
    if (!_joinCartAnimation) {
        _joinCartAnimation = [[FMEleJoinCartAnimation alloc] init];
    }
    return _joinCartAnimation;
}

- (FMPanModalTransition *)transition
{
    if (!_transition) {
        _transition = [FMPanModalTransition new];
    }
    return _transition;
}

@end
