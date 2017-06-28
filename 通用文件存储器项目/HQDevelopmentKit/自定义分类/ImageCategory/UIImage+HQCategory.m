//
//  UIImage+HQCategory.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/4/12.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "UIImage+HQCategory.h"

@implementation UIImage (HQCategory)
+ (UIImage *)thumbnailHQImage:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimage;
}

@end
