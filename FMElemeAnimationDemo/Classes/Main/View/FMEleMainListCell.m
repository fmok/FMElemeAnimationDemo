//
//  FMEleMainListCell.m
//  FMElemeAnimationDemo
//
//  Created by fm on 2017/5/8.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "FMEleMainListCell.h"
#import "UIImageView+WebCache.h"

@interface FMEleMainListCell()
{
    NSInteger currentCount;
}

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong, readwrite) UIButton *addBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation FMEleMainListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.imgView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.desLabel];
        [self addSubview:self.addBtn];
        [self addSubview:self.countLabel];
        [self addSubview:self.deleteBtn];
        currentCount = 0;
    }
    return self;
}

- (void)updateConstraints
{
    WS(weakSelf);
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10.f);
        make.top.equalTo(weakSelf).offset(10.f);
        make.size.mas_equalTo(CGSizeMake(60.f, 60.f));
    }];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.imgView.mas_right).offset(10.f);
        make.top.equalTo(weakSelf.imgView.mas_top).offset(5.f);
    }];
    [self.desLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.imgView.mas_right).offset(10.f);
        make.bottom.equalTo(weakSelf.imgView.mas_bottom).offset(-5.f);
    }];
    [self.addBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-10.f);
        make.bottom.equalTo(weakSelf).offset(-10.f);
    }];
    [self.countLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.addBtn.mas_left).offset(-5.f);
        make.centerY.equalTo(weakSelf.addBtn);
        make.width.mas_equalTo(20.f);
    }];
    [self.deleteBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.countLabel.mas_left).offset(-5.f);
        make.centerY.equalTo(weakSelf.countLabel);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [super updateConstraints];
}

#pragma mark - Public methods
- (void)updateData:(NSInteger)section index:(NSInteger)index
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://www.qqxoo.com/uploads/allimg/170504/135QaS5-3.jpg"] placeholderImage:nil options:SDWebImageRetryFailed completed:nil];
    self.titleLabel.text = [NSString stringWithFormat:@"滋补养生小炒肉 %@-%@", @(section), @(index)];
    self.desLabel.text = @"月售71份  好评率100%";
    [self setNeedsUpdateConstraints];
}

#pragma mark - Private methods
- (void)showDelete:(BOOL)show
{
//    WS(weakSelf);
    self.deleteBtn.hidden = !show;
    if (show) {
        
    } else {
        
    }
}

- (void)updateCountLabel
{
    self.countLabel.text = [NSString stringWithFormat:@"%@",@(currentCount)];
    [self setNeedsUpdateConstraints];
}

#pragma mark - Events
- (void)addAction:(UIButton *)sender
{
    NSLog(@"添加一份");
    if (currentCount == 0) {
        // 首次显示 deleteBtn、 countLabel
        self.countLabel.hidden = NO;
        [self showDelete:YES];
    }
    currentCount++;
    [self updateCountLabel];
    if (self.deleteBtn && [self.delegate respondsToSelector:@selector(dealCountAction:isBoom:object:)]) {
        [self.delegate dealCountAction:currentCount isBoom:YES object:self];
    }
}

- (void)deleteAction:(UIButton *)sender
{
    NSLog(@"删除一份");
    currentCount--;
    [self updateCountLabel];
    if (currentCount <= 0) {
        self.countLabel.hidden = YES;
        [self showDelete:NO];
    }
    if (self.deleteBtn && [self.delegate respondsToSelector:@selector(dealCountAction:isBoom:object:)]) {
        [self.delegate dealCountAction:currentCount isBoom:NO object:self];
    }
}

- (void)prepareForReuse
{
    
}

#pragma mark - getter & setter
- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.layer.cornerRadius = 2.f;
        _imgView.layer.borderColor = [UIColor grayColor].CGColor;
        _imgView.layer.borderWidth = .5;
    }
    return _imgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UILabel *)desLabel
{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _desLabel.font = [UIFont systemFontOfSize:14.f];
        _desLabel.textColor = [UIColor grayColor];
    }
    return _desLabel;
}

- (UIButton *)addBtn
{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [_addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _countLabel.backgroundColor = [UIColor clearColor];
        _countLabel.font = [UIFont systemFontOfSize:15.f];
        _countLabel.textColor = [UIColor blackColor];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.hidden = YES;
    }
    return _countLabel;
}

- (UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_deleteBtn setTitle:@"--" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _deleteBtn.layer.cornerRadius = 11.f;
        [_deleteBtn.layer setBorderColor:[UIColor blueColor].CGColor];
        [_deleteBtn.layer setBorderWidth:.5];
        [_deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.hidden = YES;
    }
    return _deleteBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
