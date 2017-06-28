//
//  HQThreeDimensionalScrollLoopView.h
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/4/13.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HQThreeDimensionalScrollLoopView;
@protocol HQThreeDimensionalScrollLoopDelegate <NSObject>

@optional
- (void)threeDimensionalScrollLoopView:(HQThreeDimensionalScrollLoopView *)scrollLoopView didSelectItemAtIndex:(NSInteger)index;

@end

@interface HQThreeDimensionalScrollLoopView : UIView
@property (nonatomic,strong) NSArray<UIView *>* bgViewArr;
@property (nonatomic,weak) id<HQThreeDimensionalScrollLoopDelegate> delegate;
@end
