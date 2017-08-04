//
//  HomeViewController.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/5/10.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionViewCell.h"
#import "HQPlaceholderTextView.h"
#import "HQCustomFlowLayout.h"
#import "ACTextView.h"
#import "ImageCategoryHeader.h"


@interface HomeViewController ()<UICollectionViewDelegate,
                                 UICollectionViewDataSource,
                                 UICollectionViewDelegateFlowLayout,
                                 UICollectionViewDataSourcePrefetching>

@property (nonatomic,strong) UICollectionView *homeCollectionView;//首页收藏视图
@property (nonatomic,strong) NSArray<SectionModel *> *demoModelArray;//小demo模型数组

@end

static NSString *homeCollectionViewCellID = @"homeCollectionViewCellID";

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    
    [self createUI];
}

- (void)createUI {
    [self.view addSubview:self.homeCollectionView];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.demoModelArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.demoModelArray[section].modelArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.demoModelArray[indexPath.section].modelArray[indexPath.item].controllerNameStr;
    [self.navigationController pushViewController:[NSClassFromString(className) new] animated:YES];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeCollectionViewCellID forIndexPath:indexPath];
    cell.contentView.backgroundColor = HQ_RANDOM_COLOR;
    cell.model = self.demoModelArray[indexPath.section].modelArray[indexPath.item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

        return CGSizeMake(SCREEN_WIDTH, 60);

}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"                                       forIndexPath:indexPath];
    headView.backgroundColor = HQ_RANDOM_COLOR;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.demoModelArray[indexPath.section].sectionName;
    [headView addSubview:label];
    
    return headView;
}

- (UICollectionView *)homeCollectionView {
    if (!_homeCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 16;
        flowLayout.minimumInteritemSpacing = 8;
        flowLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
//        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 32) / 3, (SCREEN_WIDTH - 32) * 2 / 3);
        flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize;
        _homeCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _homeCollectionView.delegate = self;
        _homeCollectionView.dataSource = self;
        _homeCollectionView.backgroundColor = [UIColor grayColor];
        [_homeCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];
        [_homeCollectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:homeCollectionViewCellID];
    }
    
    return _homeCollectionView;
}


- (NSArray<SectionModel *> *)demoModelArray {
    if (!_demoModelArray) {
        _demoModelArray = [HomeModel homeModelArrayWithPlist:@"首页model.plist"];
    }
    return _demoModelArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
