//
//  ThreeDimensionalShufflingFigureViewController.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/7/4.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "ThreeDimensionalShufflingFigureViewController.h"
#import "HQThreeDimensionalScrollLoopView.h"

@interface ThreeDimensionalShufflingFigureViewController ()
@property (nonatomic,strong) NSArray<UIView *> *bgViewArray;
@end

@implementation ThreeDimensionalShufflingFigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"3D轮播图";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

- (void)createUI {
    HQThreeDimensionalScrollLoopView *myScrollView = [[HQThreeDimensionalScrollLoopView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 3, SCREEN_WIDTH, SCREEN_HEIGHT / 3)];
    myScrollView.bgViewArr = self.bgViewArray;
    [self.view addSubview:myScrollView];
}

- (NSArray<UIView *> *)bgViewArray {
    if (!_bgViewArray) {
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:4];
        for (NSInteger index = 0; index < 4; index ++) {
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 3)];
            imageV.image = [UIImage imageNamed:@"bgImage"];
            [tempArr addObject:imageV];
        }
        _bgViewArray = tempArr;
        
    }
    return _bgViewArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
