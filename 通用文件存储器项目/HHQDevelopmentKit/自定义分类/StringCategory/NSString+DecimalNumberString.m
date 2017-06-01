//
//  NSString+DecimalNumberString.m
//  消费堡
//
//  Created by 黄华强 on 2017/5/23.
//  Copyright © 2017年 Michael. All rights reserved.
//

#import "NSString+DecimalNumberString.h"

@implementation NSString (DecimalNumberString)

+ (NSString *)reviseString:(NSString *)str {
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [str doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    //用高精度的NSDecimalNumber来处理
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    
    return [decNumber stringValue];
    
}

@end
