//
//  HomeCollectionViewCell.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/6/28.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@interface HomeCollectionViewCell ()
@property (nonatomic,strong) UIImageView *iconImageView;//介绍图片
@property (nonatomic,strong) UILabel *introduceLabel;//介绍文本
@end

@implementation HomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _iconImageView = [UIImageView new];
    _introduceLabel = [UILabel new];
    
    [self.contentView addSubview:_iconImageView];
    [self.contentView addSubview:_introduceLabel];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).offset(5);
        make.right.mas_equalTo(self.contentView).offset(-5);
        make.height.mas_equalTo(_iconImageView.mas_width).multipliedBy(16.0/9);
    }];
    _iconImageView.backgroundColor = [UIColor redColor];
    _iconImageView.image = [UIImage imageNamed:@"bgImage"];
}

@end
