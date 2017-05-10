//
//  HHQThreeDimensionalScrollLoopView.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/4/13.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "HHQThreeDimensionalScrollLoopView.h"
#import "CustomLayout.h"
#import "ThreeDimensionalCell.h"

@interface HHQThreeDimensionalScrollLoopView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSTimer *timer;
@end

static NSString *KCellIdentifier = @"KCellIdentifier";

@implementation HHQThreeDimensionalScrollLoopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        
//        _timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(timerClicked:) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
    return self;
}


- (void)timerClicked:(NSTimer *)timer {
    CGPoint currentOffset = self.collectionView.contentOffset;
    CGFloat width = self.collectionView.frame.size.width;
    NSInteger currentIndex = currentOffset.x / width;
    
    [self.collectionView setContentOffset:CGPointMake(width * (currentIndex + 1), 0) animated:YES];
    
}

- (void)setUpUI {
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[[CustomLayout alloc] init]];
    [self addSubview:self.collectionView];
    
    
    [self.collectionView registerClass:[ThreeDimensionalCell class] forCellWithReuseIdentifier:KCellIdentifier];
    self.collectionView.backgroundColor = VIEW_BACKGROUNDCOLOR;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    // [self.collectionView setContentOffset:CGPointMake(width * 2, 0.0F)];
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.bgViewArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ThreeDimensionalCell *cell = (ThreeDimensionalCell *)[cView dequeueReusableCellWithReuseIdentifier:KCellIdentifier forIndexPath:indexPath];
    
    if (indexPath.item >= self.bgViewArr.count) {
        return cell;
    }
    
    cell.bgView = self.bgViewArr[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%d",indexPath.item);
    if ([self.delegate respondsToSelector:@selector(threeDimensionalScrollLoopView:didSelectItemAtIndex:)]) {
        [self.delegate threeDimensionalScrollLoopView:self didSelectItemAtIndex:indexPath.item];
        
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float targetX = scrollView.contentOffset.x;
    int numCount = [self.collectionView numberOfItemsInSection:0];
    float itemWidth = scrollView.frame.size.width;
    
    if (numCount>=3)
    {
        if (targetX <= 0) {
            [scrollView setContentOffset:CGPointMake(itemWidth *numCount, 0)];
        }
        else if (targetX >= itemWidth * (numCount + 1))
        {
            [scrollView setContentOffset:CGPointMake(0, 0)];
        }
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
    //无限循环....
    float targetX = _scrollView.contentOffset.x;
    int numCount = [self.collectionView numberOfItemsInSection:0];
    float itemWidth = _scrollView.frame.size.width;
    
    if (numCount>=3)
    {
        if (targetX < itemWidth/2) {
            [_scrollView setContentOffset:CGPointMake(targetX+itemWidth * numCount, 0)];
        }
        else if (targetX > itemWidth/2+itemWidth *numCount)
        {
            [_scrollView setContentOffset:CGPointMake(targetX-itemWidth * numCount, 0)];
        }
    }
    
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

@end
