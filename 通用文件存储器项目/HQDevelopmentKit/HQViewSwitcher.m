//
//  HQViewSwitcher.m
//  WenDuEducation
//
//  Created by 黄华强 on 2017/9/4.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "HQViewSwitcher.h"

@interface HQViewSwitcher ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) HQViewSwitcherStyle style;

@property (nonatomic,copy) NSArray<UILabel *> *labelArray;
@property (nonatomic,assign) NSInteger titleCount;

@property (nonatomic,strong) UIScrollView *titleScrollView;
@property (nonatomic,strong) UIView *identifierView;

@property (nonatomic,strong) UIScrollView *contentScrollView;
@property (nonatomic,assign) BOOL isDragging;

@property (nonatomic,copy) NSArray<UIView *> *contentViewArray;
@property (nonatomic,copy) NSArray<UITableView *> *contentTableViewArray;

@end


static NSInteger const tagOffset = 10010;



@implementation HQViewSwitcher

- (instancetype)initWithStyle:(HQViewSwitcherStyle)style frame:(CGRect)frame {
    
    if (self = [[HQViewSwitcher alloc] initWithFrame:frame]) {
        _style = style;
    }
    
    return self;
}


#pragma mark - 公开方法实现

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
    //设置一些初始值
        _style = HQViewSwitcherStyleDefault;
        _titleFont = [UIFont systemFontOfSize:15];
        _titleViewHeight = 40;
        _selectTitleColor = [UIColor blueColor];
        _titleColor = [UIColor lightGrayColor];
        
    }
    
    return self;
}


- (UITableView *)tableViewFormIndex:(NSInteger)index {
    if (self.contentTableViewArray.count > index) {
        return self.contentTableViewArray[index];
    } else {
        return nil;
    }
}


#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger tag = tableView.tag - tagOffset;
    
    if ([self.delegate respondsToSelector:@selector(viewSwitcher:index:cellForRowAtIndexPath:)]) {
        
        return [self.delegate viewSwitcher:self numberOfRowsInIndex:tag];
        
    } else {
        
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger tag = tableView.tag - tagOffset;
    
    return [self.delegate viewSwitcher:[self tableViewFormIndex:tag] index:tag cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(viewSwitcher:index:didSelectCellAtIndexPath:)]) {
        
        NSInteger tag = tableView.tag - tagOffset;
        
        [self.delegate viewSwitcher:self index:tag didSelectCellAtIndexPath:indexPath];
        
    }
    
}

#pragma mark - 点击方法

- (void)titleLabelClicked:(UITapGestureRecognizer *)gesture {
    NSInteger tag = [gesture view].tag - tagOffset;
    _isDragging = NO;
    [self.contentScrollView setContentOffset:CGPointMake(tag * self.frame.size.width, 0) animated:YES];
    
    [self changeTitleWithIndex:tag];
    
    
    
}


- (void)changeTitleWithIndex:(NSInteger)tag {
    

    
    for (NSInteger index = 0; index < self.labelArray.count; index ++) {
        
        UILabel *arrLabel = self.labelArray[index];
        
        if (index == tag) {
            arrLabel.textColor = self.selectTitleColor;
            
            [UIView animateWithDuration:0.3 animations:^{
                _identifierView.frame = CGRectMake(arrLabel.frame.origin.x + 8, self.titleViewHeight - 2, arrLabel.frame.size.width - 16, 2);
            }];
            
            
            CGFloat labelMaxX = CGRectGetMaxX(arrLabel.frame);
            CGFloat labelMinX = CGRectGetMinX(arrLabel.frame);
            
            if (labelMaxX + 38 - self.titleScrollView.contentOffset.x > self.frame.size.width) {
                
                CGFloat offSetX = 0;
                
                if (labelMaxX + 38 >= self.titleScrollView.contentSize.width) {
                    offSetX = labelMaxX - self.frame.size.width;
                } else {
                    offSetX = labelMaxX + 38 - self.frame.size.width;
                }
                
                [self.titleScrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
            }
            
            if (labelMinX - 38 - self.titleScrollView.contentOffset.x < 0) {
                CGFloat offSetX = 0;
                
                if (labelMinX - 38 <= 0) {
                    offSetX = 0;
                } else {
                    offSetX = labelMinX - 38;
                }
                
                [self.titleScrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
            }
            
        } else {
            arrLabel.textColor = self.titleColor;
        }
        
        
    }
    
    if ([self.delegate respondsToSelector:@selector(viewSwitcher:didSelectTitleAtIndex:)]) {
        
        [self.delegate viewSwitcher:self didSelectTitleAtIndex:tag];
    }

}


#pragma mark - scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!_isDragging) {
        return;
    }
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = (offsetX + self.frame.size.width / 2) / self.frame.size.width;
    [self changeTitleWithIndex:index];
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isDragging = YES;
}


#pragma mark - setter方法
- (void)setDelegate:(id<HQViewSwitcherDelegate>)delegate {
    _delegate = delegate;
    
    self.titleCount = [delegate viewSwitcherNumberOfIndexs:self];
    switch (self.style) {
            //平均
        case HQViewSwitcherStyleDefault:
        {
            [self addSubview:self.titleScrollView];
            
        }
            break;
            //适应
        case HQViewSwitcherStyleTableView:
        {
            [self addSubview:self.titleScrollView];
        }
            break;
        default:
            break;
    }
    

    [self addSubview:self.contentScrollView];
    
    
    _isDragging = NO;
    [self.contentScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self changeTitleWithIndex:0];
    
}


#pragma mark - 懒加载
- (NSArray<UILabel *> *)labelArray {
    if (!_labelArray) {
        _labelArray = [NSArray array];
    }
    
    return _labelArray;
}




- (UIScrollView *)titleScrollView {
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.titleViewHeight)];
        
        NSDictionary *attrs = @{NSFontAttributeName : self.titleFont};
        
        CGFloat titleTotalWidth = 0;
        
        NSMutableArray<UILabel *> *tempLabelArray = [NSMutableArray arrayWithCapacity:_titleCount];
        for (NSInteger index = 0; index < _titleCount; index ++) {
            
            NSString *titleString = [self.delegate viewSwitcher:self titleForIndex:index];
            CGSize textSize = [titleString boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleTotalWidth, 0, textSize.width + 16, self.titleViewHeight - 2)];
            titleTotalWidth = titleTotalWidth + textSize.width + 16;
            
            titleLabel.textColor = self.titleColor;
            titleLabel.font = self.titleFont;
            titleLabel.backgroundColor = [UIColor whiteColor];
            titleLabel.text = titleString;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.tag = tagOffset + index;
            
            titleLabel.userInteractionEnabled = YES;
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClicked:)];
            [titleLabel addGestureRecognizer:gesture];
            
            [_titleScrollView addSubview:titleLabel];
            
            [tempLabelArray addObject:titleLabel];
            
            
        }
        
        self.labelArray = tempLabelArray;
        
        if (titleTotalWidth < self.frame.size.width) {
            
            CGFloat titleWidth = self.frame.size.width / self.labelArray.count;
            
            for (NSInteger index = 0; index < self.labelArray.count; index ++) {
                UILabel *label = self.labelArray[index];
                label.frame = CGRectMake(index * titleWidth, 0, titleWidth, self.titleViewHeight - 2);
            }
            
            titleTotalWidth = self.frame.size.width;
        }
        
        _identifierView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleViewHeight - 2, 1, 2)];
        _identifierView.backgroundColor = self.selectTitleColor;
        [_titleScrollView addSubview:_identifierView];
        
        
        _titleScrollView.contentSize = CGSizeMake(titleTotalWidth, 0);
        _titleScrollView.bounces = NO;
        _titleScrollView.showsVerticalScrollIndicator = NO;
        _titleScrollView.showsHorizontalScrollIndicator = NO;
    }
    
    return _titleScrollView;
}

- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleViewHeight, self.frame.size.width, self.frame.size.height - self.titleViewHeight)];
        _contentScrollView.bounces = YES;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.delegate = self;
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        
        switch (_style) {
            case HQViewSwitcherStyleDefault:
            {
                
                if ([self.delegate respondsToSelector:@selector(viewSwitcher:viewForIndex:withFrame:)]) {
                    
                    for (NSInteger index = 0; index < _labelArray.count; index ++) {
                        
                        UIView *view = [self.delegate viewSwitcher:self viewForIndex:index withFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - self.titleViewHeight)];
                        view.frame = CGRectMake(index * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height - self.titleViewHeight);
                        
                        [tempArray addObject:view];
                        [_contentScrollView addSubview:view];
                        
                    }
                    
                    self.contentViewArray = tempArray;
                    
                }
                
            }
                break;
                
            case HQViewSwitcherStyleTableView:
            {
                for (NSInteger index = 0; index < _labelArray.count; index ++) {
                    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(index * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height - self.titleViewHeight)];
                    tableView.delegate = self;
                    tableView.dataSource = self;
                    tableView.tag = tagOffset + index;
                    
                    [tempArray addObject:tableView];
                    [_contentScrollView addSubview:tableView];
                    
                }
                
                self.contentTableViewArray = tempArray;
                
            }
                break;
            default:
                break;
        }
        
        
        _contentScrollView.contentSize = CGSizeMake(_labelArray.count * self.frame.size.width, 0);
        
    }
    
    return _contentScrollView;
}

- (NSArray<UIView *> *)contentViewArray {
    if (!_contentViewArray) {
        _contentViewArray = [NSArray array];
    }
    
    return _contentViewArray;
}

- (NSArray<UIView *> *)contentTableViewArray {
    if (!_contentTableViewArray) {
        _contentTableViewArray = [NSArray array];
    }
    
    return _contentTableViewArray;
}


@end
