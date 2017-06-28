//
//  UIImageView+HQCategory.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/4/12.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "UIImageView+HQCategory.h"
#import <UIImageView+AFNetworking.h>
#import <UIImageView+WebCache.h>

@implementation UIImageView (HQCategory)
-(void)HQSetImage:(UIImage *)image {
    CGSize size = self.frame.size;
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.image = newimage;

}

- (void)HQSetImage:(UIImage *)image withRadius:(CGFloat)radius {
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

- (void)HQSetImageUrlStr:(NSString *)urlStr placeholderImage:(NSString *)imageStr cornerRadius:(CGFloat)radius bgColor:(UIColor *)color {
    CGSize size = self.frame.size;
    
    self.image = [self UIBezierPathClip:[UIImage imageNamed:imageStr] size:size cornerRadius:radius color:color opaque:true];
    
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:imageStr]];
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
//    __weak typeof(self) weakSelf = self;
//    [self setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:imageStr] success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
//        weakSelf.image = [weakSelf UIBezierPathClip:image size:size cornerRadius:radius color:color opaque:true];
//    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
//        
//    }];
}

- (void)HQSetImage:(UIImage *)img cornerRadius:(CGFloat)radius bgColor:(UIColor *)color opaque:(BOOL)opaque {
    CGSize size = self.frame.size;
    
    self.image = [self UIBezierPathClip:img size:size cornerRadius:radius color:color opaque:true];
}

- (UIImage *)UIBezierPathClip:(UIImage *)img size:(CGSize)size cornerRadius:(CGFloat)radius color:(UIColor *)color opaque:(BOOL)opaque {

    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(size, opaque, 1.0);
    
    [color setFill];
    UIRectFill(rect);
    
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    
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
