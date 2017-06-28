//
//  NSString+DecimalNumberString.h
//  消费堡
//
//  Created by 黄华强 on 2017/5/23.
//  Copyright © 2017年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DecimalNumberString)

/**
 精度丢失字符串转换保存

 @param str 会丢失精度的后台传过来的nsnumber却用string接收
 @return 转换后能正常显示的string
 */
+ (NSString *)reviseString:(NSString *)str;

@end
