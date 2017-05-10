//
//  NSString+HHQCategory.h
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/3/10.
//  Copyright © 2017年 黄华强. All rights reserved.
//


/**
 这是一个对NSString进行功能扩展的分类
 */

#import <UIKit/UIKit.h>

@interface NSString (HHQCategory)


/**
 计算文字高度的方法声明
 
 @param string 需要计算高度的文字
 @param width 文字宽度
 @param fontSize 文字大小
 @return 计算出的文字高度
 */
+ (CGFloat)HHQHeightWithString:(NSString *)string andWidth:(CGFloat)width andFontSize:(CGFloat)fontSize;


@end
