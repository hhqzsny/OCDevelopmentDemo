//
//  CircleLayout.m
//  UICollectionViewDemo
//
//  Created by Lee on 14-2-14.
//  Copyright (c) 2014年 Lee. All rights reserved.
//

#import "CustomLayout.h"

@implementation CustomLayout

-(CGSize)collectionViewContentSize
{
    float width = self.collectionView.frame.size.width *([self.collectionView numberOfItemsInSection:0 ]+2);
    float height= self.collectionView.frame.size.height;
    CGSize  size = CGSizeMake(width, height);
    return size;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{

        
        return YES;
}
#pragma mark - UICollectionViewLayout
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //3D代码
    UICollectionViewLayoutAttributes* attributes = attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    UICollectionView *collection = self.collectionView;
    float width = collection.frame.size.width;
    float x = collection.contentOffset.x;
    CGFloat arc = M_PI * 2.0f;
    

    NSInteger numberOfVisibleItems = [self.collectionView numberOfItemsInSection:0 ];
    
    attributes.center = CGPointMake(x + collection.frame.size.width/2 , collection.frame.size.height/2);
    
    CGFloat a = 4 * tanf(arc/2.0f/numberOfVisibleItems);
    CGFloat b = a + 1;
    CGFloat c = a / b;
    
    attributes.size = CGSizeMake(collection.frame.size.width * c, collection.frame.size.height * c);

    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0f/(2 * SCREEN_WIDTH);
    
    
    CGFloat angleFloat = indexPath.row-x/width+1;
    CGFloat radius = attributes.size.width/2/ tanf(arc/2.0f/numberOfVisibleItems);
    CGFloat angle = angleFloat/ numberOfVisibleItems * arc;
    transform = CATransform3DRotate(transform, angle, 0.0f, 1.0f, 0.0f);
    transform = CATransform3DTranslate(transform, 0.f, 0.0f, radius);
    attributes.transform3D = transform;
    
    NSInteger angleInt = (NSInteger)angleFloat;
    NSInteger tempInt = angleInt / numberOfVisibleItems;
    if ((angleFloat - tempInt * numberOfVisibleItems) == 0) {
        attributes.zIndex = 1;
    } else {
        attributes.zIndex = 0;
    }
    
    
    return attributes;
}
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    if ([arr count] >0) {
        return arr;
    }

    
    NSMutableArray* attributesArr = [NSMutableArray array];
    for (NSInteger i=0 ; i < [self.collectionView numberOfItemsInSection:0 ]; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [attributesArr addObject:attributes];
        }

    }
    return attributesArr;
}


@end
