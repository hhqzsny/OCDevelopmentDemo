//
//  HHQScrollLoopView.h
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/3/10.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HHQScrollLoopView;
@protocol scrollLoopViewDelegate <NSObject>

@optional

- (void)scrollLoopView:(HHQScrollLoopView *)scrollLoopView didSelectItemAtIndex:(NSInteger)index;


@end

@class scrollLoopViewDelegate;
@interface HHQScrollLoopView : UIView


@property (nonatomic, strong) NSArray *images;
@property (nonatomic, weak) id<scrollLoopViewDelegate>delegate;


@end
