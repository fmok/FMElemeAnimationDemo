//
//  FMEleMainControl.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/8.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMEleMainControl.h"
#import "FMEleFoodDetailController.h"

NSString *const FMEleMainListCellIdentifier = @"FMEleMainListCell";

@interface FMEleMainControl()

@property (nonatomic, assign) CGFloat endPoint_x;
@property (nonatomic, assign) CGFloat endPoint_y;
@property (nonatomic, strong) CALayer *dotLayer;
@property (nonatomic, strong) UIBezierPath *path;

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

#pragma mark - Animation
- (void)joinCartAnimationWithStartRect:(CGRect)startRect endRect:(CGRect)endRect
{
    _endPoint_x = endRect.origin.x+endRect.size.width/2.f;
    _endPoint_y = -(endRect.origin.y+endRect.size.height/2.f);
    
    CGFloat startX = startRect.origin.x;
    CGFloat startY = startRect.origin.y;
    
    _path = [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(startX, startY)];
    
    //三点曲线
    [_path addCurveToPoint:CGPointMake(_endPoint_x, _endPoint_y)
             controlPoint1:CGPointMake(startX, startY)
             controlPoint2:CGPointMake(startX - 180, startY - 100)];
    _dotLayer = [CALayer layer];
    _dotLayer.backgroundColor = [UIColor blueColor].CGColor;
    _dotLayer.frame = CGRectMake(0, 0, 20.f, 20.f);
    _dotLayer.cornerRadius = 10.f;
    [self.vc.view.layer addSublayer:_dotLayer];
    [self groupAnimation];
}

- (void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.2f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,alphaAnimation];
    groups.duration = 0.3f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    [_dotLayer addAnimation:groups forKey:nil];
    [self performSelector:@selector(removeFromLayer:) withObject:_dotLayer afterDelay:0.3f];
}

- (void)removeFromLayer:(CALayer *)layerAnimation
{
    [layerAnimation removeFromSuperlayer];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([[anim valueForKey:@"animationName"]isEqualToString:@"groupsAnimation"]) {
        
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        shakeAnimation.duration = 0.15f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:0.9];
        shakeAnimation.toValue = [NSNumber numberWithFloat:1];
        shakeAnimation.autoreverses = YES;
        [self.vc.toolbar.bagBtn.layer addAnimation:shakeAnimation forKey:nil];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FMEleFoodDetailController *vc = [[FMEleFoodDetailController alloc] init];
    vc.title = [NSString stringWithFormat:@"food-%@",@(indexPath.row)];
    [self.vc.zl_navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FMEleMainListCell *cell = [tableView dequeueReusableCellWithIdentifier:FMEleMainListCellIdentifier forIndexPath:indexPath];
    [cell updateData];
    WS(weakSelf);
    __weak typeof(cell) weakCell = cell;
    cell.block = ^(NSInteger count, BOOL isBoom) {
        if (isBoom) {
            CGRect startRect = [weakCell convertRect:weakCell.addBtn.frame toView:self.vc.view];
            CGRect endRect = [weakSelf.vc.view convertRect:weakSelf.vc.toolbar.bagBtn.frame toView:weakSelf.vc.toolbar];
            [weakSelf joinCartAnimationWithStartRect:startRect endRect:endRect];
        }
    };
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
    if (infoAlpha>1) {
        infoAlpha = 1;
    }
    [self.vc.headerView.infoView setSubViewsAlpha:infoAlpha];
}



@end
