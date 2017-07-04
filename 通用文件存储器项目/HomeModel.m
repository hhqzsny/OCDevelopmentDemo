//
//  HomeModel.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/6/29.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

+ (NSArray *)homeModelArrayWithPlist:(NSString *)plistName {
    NSString *pathStr = [[NSBundle mainBundle] pathForAuxiliaryExecutable:plistName];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:pathStr];
    
    NSMutableArray *sectionTempArray = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (NSDictionary *sectionDict in dataArray) {
        SectionModel *sectionModel = [SectionModel new];
        [sectionModel setValuesForKeysWithDictionary:sectionDict];
        
        NSArray *modelDictArray = sectionModel.modelArray;
        
        NSMutableArray *modelTempArray = [NSMutableArray arrayWithCapacity:modelDictArray.count];
        for (NSDictionary *modelDict in modelDictArray) {
            HomeModel *model = [HomeModel new];
            [model setValuesForKeysWithDictionary:modelDict];
            
            [modelTempArray addObject:model];
        }
        sectionModel.modelArray = modelTempArray;
        
        [sectionTempArray addObject:sectionModel];
    }
    

    return sectionTempArray;
}


@end

@implementation SectionModel



@end
