//
//  AdaptiveWaterfallsFlowLayoutCell.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/7/6.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "AdaptiveWaterfallsFlowLayoutCell.h"

@interface AdaptiveWaterfallsFlowLayoutCell ()



@end

@implementation AdaptiveWaterfallsFlowLayoutCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _label = [UILabel new];
    [self.contentView addSubview:_label];
    self.contentView.backgroundColor = HQ_RANDOM_COLOR;
    
    _label.numberOfLines = 0;
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(self.contentView);
        make.width.mas_equalTo((SCREEN_WIDTH - 40) / 3);
    }];
}

@end
