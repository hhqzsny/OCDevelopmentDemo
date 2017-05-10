//
//  UIImageView+HHQCategory.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/4/12.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "UIImageView+HHQCategory.h"

@implementation UIImageView (HHQCategory)
-(void)HHQSetImage:(UIImage *)image {
    CGSize size = self.frame.size;
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.image = newimage;

}

- (void)HHQSetImage:(UIImage *)image withRadius:(CGFloat)radius {
    CGSize size = self.frame.size;
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.image = [self UIBezierPathClip:newImage cornerRadius:radius];
}

- (UIImage *)UIBezierPathClip:(UIImage *)img cornerRadius:(CGFloat)c {
    int w = img.size.width * img.scale;
    int h = img.size.height * img.scale;
    CGRect rect = CGRectMake(0, 0, w, h);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, h), false, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:c] addClip];
    [img drawInRect:rect];
    UIImage *ret = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return ret;
}

//- (UIImage *)CGContextClip:(UIImage *)img cornerRadius:(CGFloat)c {
//    int w = img.size.width * img.scale;
//    int h = img.size.height * img.scale;
//    
//    
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, h), false, 1.0);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextMoveToPoint(context, 0, c);
//    CGContextAddArcToPoint(context, 0, 0, c, 0, c);
//    CGContextAddLineToPoint(context, w-c, 0);
//    CGContextAddArcToPoint(context, w, 0, w, c, c);
//    CGContextAddLineToPoint(context, w, h-c);
//    CGContextAddArcToPoint(context, w, h, w-c, h, c);
//    CGContextAddLineToPoint(context, c, h);
//    CGContextAddArcToPoint(context, 0, h, 0, h-c, c);
//    CGContextAddLineToPoint(context, 0, c);
//    CGContextClosePath(context);
//    
//    CGContextClip(context);     // 先裁剪 context，再画图，就会在裁剪后的 path 中画
//    [img drawInRect:CGRectMake(0, 0, w, h)];       // 画图
//    CGContextDrawPath(context, kCGPathFill);
//    
//    UIImage *ret = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return ret;
//}


@end
