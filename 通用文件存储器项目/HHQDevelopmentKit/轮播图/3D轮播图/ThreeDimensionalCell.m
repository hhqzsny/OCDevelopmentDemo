//
//  ShowImageCell.m
//  UICollectionViewDemo
//
//  Created by Lee on 14-2-17.
//  Copyright (c) 2014年 Lee. All rights reserved.
//

#import "ThreeDimensionalCell.h"

@implementation ThreeDimensionalCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        

    }
    return self;
}

- (void)setBgView:(UIView *)bgView {
    _bgView = bgView;
    _bgView.frame = self.bounds;
    [self.contentView addSubview:_bgView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
