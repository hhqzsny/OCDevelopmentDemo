//
//  NSString+HHQCategory.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/3/10.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "NSString+HHQCategory.h"

@implementation NSString (HHQCategory)


#pragma mark - 处理字符串的方法

/**
 计算文字高度的方法实现

 @param string 需要计算高度的文字
 @param width 文字宽度
 @param fontSize 文字大小
 @return 计算出的文字高度
 */
+ (CGFloat)HHQHeightWithString:(NSString *)string andWidth:(CGFloat)width andFontSize:(CGFloat)fontSize {
    
    //设定最大尺寸
    CGSize size = CGSizeMake(width, MAXFLOAT);
    //设定文字属性
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],  NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    //计算文字frame
    CGRect frame =  [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    //返回计算后的文字高度
    return frame.size.height;
    
}

@end
