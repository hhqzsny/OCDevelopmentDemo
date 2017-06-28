//
//  UIImage+HQCategory.h
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/4/12.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HQCategory)
+ (UIImage *)thumbnailHQImage:(UIImage *)image toSize:(CGSize)size;
@end
