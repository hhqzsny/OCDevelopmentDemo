//
//  HomeModel.h
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/6/29.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

+ (NSArray *)homeModelArrayWithPlist:(NSString *)plistName;

@property (nonatomic,copy) NSString *imageNameStr;
@property (nonatomic,copy) NSString *introduceStr;
@property (nonatomic,copy) NSString *controllerNameStr;

@end

@interface SectionModel : NSObject

@property (nonatomic,copy) NSString *sectionName;
@property (nonatomic,strong) NSArray<HomeModel *> *modelArray;

@end
