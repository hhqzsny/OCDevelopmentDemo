//
//  ScrollLoopCollectionViewCell.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/3/10.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "ScrollLoopCollectionViewCell.h"

@implementation ScrollLoopCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化时设置cell的UI
        [self setUpUI:frame];
    }
    return self;
}



/**
 初始化cell的UI

 @param frame 初始化时传入的frame
 */
- (void)setUpUI:(CGRect)frame {
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _imageView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_imageView];
    
    
}

@end
