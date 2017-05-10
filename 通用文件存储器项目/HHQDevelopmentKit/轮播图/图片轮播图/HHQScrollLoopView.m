//
//  HHQScrollLoopView.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/3/10.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "HHQScrollLoopView.h"
#import "ScrollLoopCollectionViewCell.h"
#import "UIImageView+WebCache.h"


static NSTimeInterval NSTimeIntervalDefault = 2.0;
static NSString *identify = @"cellidentify";

@interface HHQScrollLoopView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalImageCount;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation HHQScrollLoopView



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initsConfig];
        [self.collectionView registerClass:[ScrollLoopCollectionViewCell class] forCellWithReuseIdentifier:identify];
        
    }
    
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initsConfig];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    
    if (images.count > 1) {
        _totalImageCount =  _images.count * 2;
        [self setupTimer];
        _pageControl.numberOfPages = images.count;
    }
    
    if (images.count == 1) {
        _totalImageCount = 1;
        
    }
    [_collectionView reloadData];
}



/**
 设置轮播图的基本属性
 */
- (void)initsConfig{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = layout;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate  = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    [collectionView registerClass:[ScrollLoopCollectionViewCell class] forCellWithReuseIdentifier:identify];
    _collectionView = collectionView;
    [self addSubview:collectionView];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    _pageControl = pageControl;
    
    [self addSubview:pageControl];
    
}


- (void)setupTimer{

    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:NSTimeIntervalDefault target:self selector:@selector(AutoScroll) userInfo:nil repeats:YES];
    
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

}

- (void)AutoScroll{
    
    int currentIndex = [self currentIndex];

    int targetIndex = currentIndex + 1;
    if (targetIndex >= _totalImageCount) {
        
        targetIndex = _totalImageCount * 0.5;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        return;
    }

    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];

}


- (int)currentIndex{

    if (_collectionView.frame.size.width == 0) {
        return 0;
    }
    int index = 0;
    
    index = (_collectionView.contentOffset.x) /_flowLayout.itemSize.width;

    return index;
}

- (void)invalidateTimer
{
    [self.timer invalidate];
     self.timer = nil;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _totalImageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ScrollLoopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    long index = indexPath.item % self.images.count;
    //cell.label.text = [NSString stringWithFormat:@"%zd",index];

    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.images[index]] placeholderImage:[UIImage imageNamed:self.images[index]]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if ([self.delegate respondsToSelector:@selector(scrollLoopView:didSelectItemAtIndex:)]) {
        
        [self.delegate scrollLoopView:self didSelectItemAtIndex:indexPath.item % self.images.count];
    }
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    int currentIndex = [self currentIndex];
    NSInteger index = currentIndex + 1;
    
    if (index >= _totalImageCount ) {
        index = _totalImageCount * 0.5;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        return;
        
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentIndex = [self currentIndex];
    NSInteger index = currentIndex + 1;
    
    if (index >= _totalImageCount ) {
        index = _totalImageCount * 0.5;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        return;
        
    }
    
    if (index <= 1) {
        index = _totalImageCount * 0.5;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        return;
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentIndex = [self currentIndex];

    _pageControl.currentPage = currentIndex % self.images.count;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _flowLayout.itemSize = self.frame.size;
    _collectionView.frame = self.bounds;
    
    if (_collectionView.contentOffset.x == 0 && _totalImageCount) {
        
        int tarIndex = _totalImageCount * 0.5;
        
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:tarIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    _pageControl.frame = CGRectMake((self.frame.size.width - 100)/2, self.frame.size.height - 20, 100, 20);
    
    
}


- (void)dealloc
{
    [self invalidateTimer];
}



@end
