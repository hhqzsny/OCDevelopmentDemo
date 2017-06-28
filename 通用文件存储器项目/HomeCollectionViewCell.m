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
    
}

@end
