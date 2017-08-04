//
//  HQCustomFlowLayout.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/7/5.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "HQCustomFlowLayout.h"

@interface HQCustomFlowLayout ()

//item属性数组
@property(nonatomic,strong)NSMutableArray * attributeArray;

//存放每列的高度
@property(nonatomic,strong)NSMutableDictionary * columHeightDic;
@end

@implementation HQCustomFlowLayout

-(instancetype)init{
    self = [super init];
    if (self) {
        self.attributeArray = [NSMutableArray array];
        self.columHeightDic = [NSMutableDictionary dictionary];
        
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    for (NSInteger i = 0; i < 3; i++) {
        
        NSString * key = [NSString stringWithFormat:@"%ld",(long)i];
        [self.columHeightDic setObject:@(10) forKey:key];
    }
    
    [self.attributeArray removeAllObjects];
    //item数
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < items; i ++) {
        
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        
        
        [self.attributeArray addObject:attrs];
        
    }
    
}


- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    

    
        NSMutableArray *tempArray = [NSMutableArray array];
        for (UICollectionViewLayoutAttributes *attributes in self.attributeArray) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [tempArray addObject:attributes];
            }
        }

    return tempArray;
}

-(CGSize)collectionViewContentSize{
    CGSize superSize = [super collectionViewContentSize];
    __block NSString * maxColum = @"0";
    [self.columHeightDic enumerateKeysAndObjectsUsingBlock:^(NSString * key, NSNumber * obj, BOOL * _Nonnull stop) {
        if ([obj floatValue] > [self.columHeightDic[maxColum] floatValue]) {
            maxColum = key;
        }
    }];
    
    superSize.height = 10 + [self.columHeightDic[maxColum] floatValue];
    
    return superSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
   UICollectionViewLayoutAttributes *layoutAtt = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    __block NSString * minHeightCloum = @"0";
    [self.columHeightDic enumerateKeysAndObjectsUsingBlock:^(NSString * colum, NSNumber * maxY, BOOL * _Nonnull stop) {
        
        if ([maxY floatValue]<[self.columHeightDic[minHeightCloum] floatValue]) {
            minHeightCloum = colum;
        }
    }];
    
    

    
 
    
    //计算位置
    CGFloat x = 10 + (10 + layoutAtt.frame.size.width) * [minHeightCloum intValue];
    
    CGFloat y =  [self.columHeightDic[minHeightCloum] floatValue] + 10;
    
    
    [self.columHeightDic setObject:@(y + layoutAtt.frame.size.height) forKey:minHeightCloum];
    
    layoutAtt.frame = CGRectMake(x, y, layoutAtt.frame.size.width, layoutAtt.frame.size.height);
    
    return layoutAtt;
}

@end
