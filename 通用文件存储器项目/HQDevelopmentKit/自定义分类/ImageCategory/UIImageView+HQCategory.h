//
//  UIImageView+HQCategory.h
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/4/12.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (HQCategory)
- (void)HQSetImage:(UIImage *)image;
- (void)HQSetImage:(UIImage *)image withRadius:(CGFloat)radius;

- (void)HQSetImage:(UIImage *)img cornerRadius:(CGFloat)radius bgColor:(UIColor *)color opaque:(BOOL)opaque;

- (void)HQSetImageUrlStr:(NSString *)urlStr placeholderImage:(NSString *)imageStr cornerRadius:(CGFloat)radius bgColor:(UIColor *)color;

@end
