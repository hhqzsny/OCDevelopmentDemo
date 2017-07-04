//
//  ViewAdaptiveLayoutViewController.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/6/29.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "ViewAdaptiveFlowLayoutViewController.h"
#import "ViewAdaptiveFlowLayoutCollectionViewCell.h"

NSString *const cellID = @"cellID";

@interface ViewAdaptiveFlowLayoutViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong,nonnull) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray<ViewAdaptiveFlowLayoutModel *> *dataArray;
@end

@implementation ViewAdaptiveFlowLayoutViewController

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
    ViewAdaptiveFlowLayoutCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    
    return cell;
}


#pragma mark - 懒加载方法

//collectionView懒加载方法
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        //流布局设置
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 8;
        flowLayout.minimumInteritemSpacing = 8;
        //设置预估size以让系统自动根据约束计算cell的size
        flowLayout.estimatedItemSize = CGSizeMake(SCREEN_WIDTH / 4, SCREEN_WIDTH / 3);
        
        //collectionView设置
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ViewAdaptiveFlowLayoutCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}

//model数组的懒加载方法
- (NSArray<ViewAdaptiveFlowLayoutModel *> *)dataArray {
    if (!_dataArray) {
        //随机生成model个数
        NSInteger count = arc4random_uniform(50) + 20;
        //初始化用于装model的临时可变数组
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:count];
        //利用循环生成model
        for (NSInteger arrIndex = 0; arrIndex < count; arrIndex ++) {
            //随机生成cell宽度和字数
            NSInteger cellWidth = arc4random_uniform(19) + 3;
            NSInteger wordNum = arc4random_uniform(100);
            
            NSMutableString *mStr = [[NSMutableString alloc] initWithString:@"发发发舒服舒服"];
            //利用循环生成长度不一的字符串
            for (NSInteger index = 0; index < wordNum; index ++) {
                [mStr appendString:@"福施福"];
            }
            //给model初始化并赋值
            ViewAdaptiveFlowLayoutModel *model = [ViewAdaptiveFlowLayoutModel new];
            model.contentStr = mStr;
            model.cellWidth = cellWidth * 10;
            
            [tempArray addObject:model];
        }
        
        //临时数组赋值给model数组
        _dataArray = tempArray;
        
    }
    
    return _dataArray;
}

//内存警告处理方法
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
