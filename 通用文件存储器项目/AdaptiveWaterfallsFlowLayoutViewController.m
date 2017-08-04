//
//  AdaptiveWaterfallsFlowLayoutViewController.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/7/5.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "AdaptiveWaterfallsFlowLayoutViewController.h"
#import "HQCustomFlowLayout.h"
#import "AdaptiveWaterfallsFlowLayoutCell.h"

NSString *const cellID = @"cellID";

@interface AdaptiveWaterfallsFlowLayoutViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong,nonnull) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation AdaptiveWaterfallsFlowLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自适应流水布局";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    
}
//创建UI界面
- (void)createUI {
    [self.view addSubview:self.collectionView];
}

#pragma mark - collectionView代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AdaptiveWaterfallsFlowLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.label.text = [NSString stringWithFormat:@"%ld:%@",(long)indexPath.item,self.dataArray[indexPath.item]];
    
    return cell;
}


#pragma mark - 懒加载方法

//collectionView懒加载方法
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        //流布局设置
        HQCustomFlowLayout *flowLayout = [[HQCustomFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 8;
        flowLayout.minimumInteritemSpacing = 8;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        //设置预估size以让系统自动根据约束计算cell的size
        flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
        
        //collectionView设置
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[AdaptiveWaterfallsFlowLayoutCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}

//model数组的懒加载方法
- (NSArray *)dataArray {
    if (!_dataArray) {
        //随机生成model个数
        NSInteger count = arc4random_uniform(100) + 20;
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:count];
        
        for (NSInteger index = 0; index < count; index ++) {
            NSInteger strCount = arc4random_uniform(100) + 10;
            
            NSMutableString *tempStr = [NSMutableString stringWithString:@"发发"];
            for (NSInteger strIndex = 0; strIndex < strCount; strIndex ++) {
                [tempStr appendString:@"代收"];
            }
            
            [tempArr addObject:tempStr];
        }
        
        _dataArray = tempArr;
    }
    
    return _dataArray;
}

//内存警告处理方法
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
