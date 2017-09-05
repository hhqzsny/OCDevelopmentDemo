//
//  HQViewSwitcher.h
//  WenDuEducation
//
//  Created by 黄华强 on 2017/9/4.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HQViewSwitcher;

typedef NS_ENUM(NSInteger, HQViewSwitcherStyle) {
    HQViewSwitcherStyleDefault,//title平均分配屏幕宽度
    HQViewSwitcherStyleTableView,//title根据各自文本长度自动适应延展
};


@protocol HQViewSwitcherDelegate <NSObject>

@required

- (NSInteger)viewSwitcherNumberOfIndexs:(HQViewSwitcher *)viewSwitcher ;

- (NSString *)viewSwitcher:(HQViewSwitcher *)viewSwitcher titleForIndex:(NSInteger)index ;


@optional

- (UIView *)viewSwitcher:(HQViewSwitcher *)viewSwitcher viewForIndex:(NSInteger)index withFrame:(CGRect)frame;

- (UITableViewCell *)viewSwitcher:(UITableView *)tableView index:(NSInteger)index cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)viewSwitcher:(HQViewSwitcher *)viewSwitcher numberOfRowsInIndex:(NSInteger)index ;

- (void)viewSwitcher:(HQViewSwitcher *)viewSwitcher index:(NSInteger)index didSelectCellAtIndexPath:(NSIndexPath *)indexPath;

- (void)viewSwitcher:(HQViewSwitcher *)viewSwitcher didSelectTitleAtIndex:(NSInteger)index;


@end


@interface HQViewSwitcher : UIView

@property (nonatomic,strong) UIColor *selectTitleColor;
@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,assign) CGFloat titleViewHeight;
@property (nonatomic,strong) UIFont *titleFont;

@property (nonatomic,weak) id<HQViewSwitcherDelegate> delegate;

- (instancetype)initWithStyle:(HQViewSwitcherStyle)style frame:(CGRect)frame ;

- (UITableView *)tableViewFormIndex:(NSInteger)index;

@end
