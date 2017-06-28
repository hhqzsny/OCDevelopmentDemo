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
#import "ACTextView.h"
#import "ImageCategoryHeader.h"
#import "UILabel+YBAttributeTextTapAction.h"


#define YBAlertShow(messageText,buttonName) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:(messageText) \
delegate:nil cancelButtonTitle:(buttonName) otherButtonTitles: nil];\
[alert show];


@interface HomeViewController ()<UICollectionViewDelegate,
                                 UICollectionViewDataSource,
                                 UICollectionViewDelegateFlowLayout,
                                 UICollectionViewDataSourcePrefetching>

@property (nonatomic,strong) UICollectionView *homeCollectionView;//首页收藏视图

@end

static NSString *homeCollectionViewCellID = @"homeCollectionViewCellID";

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
   // [self setUpUI];
    [self createUI];
}

- (void)createUI {
    [self.view addSubview:self.homeCollectionView];
}

- (void)setUpUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    
//    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [self.view addSubview:imageV];
//    
//    //[imageV HQSetImage:[UIImage imageNamed:@"bgImage"] withRadius:50];
//   // [imageV HQSetImage:[UIImage imageNamed:@"bgImage"] cornerRadius:50 bgColor:[UIColor whiteColor] opaque:true];
////    imageV.image = [UIImage imageNamed:@"bgImage"];
////    imageV.layer.cornerRadius = 50;
////    imageV.layer.masksToBounds = YES;
//    
//    [imageV HQSetImageUrlStr:@"http://n.sinaimg.cn/sports/20170609/mNx5-fyfzsyc1769533.jpg" placeholderImage:@"bgImage" cornerRadius:50 bgColor:[UIColor whiteColor]];
    
    
    //需要点击的字符相同
    NSString *label_text1 = @"我是个抽奖Label， 点我有奖，点我没奖哦";
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc]initWithString:label_text1];
    [attributedString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, label_text1.length)];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(12, 2)];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(17, 2)];
    //最好设置一下行高，不设的话默认是0
    NSMutableParagraphStyle *sty = [[NSMutableParagraphStyle alloc] init];
    sty.alignment = NSTextAlignmentCenter;
    sty.lineSpacing = 5;
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:sty range:NSMakeRange(0, label_text1.length)];
    
    UILabel *ybLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, self.view.bounds.size.width - 20, 60)];
    ybLabel1.backgroundColor = [UIColor yellowColor];
    ybLabel1.numberOfLines = 2;
    ybLabel1.attributedText = attributedString1;
    [self.view addSubview:ybLabel1];
    
    [ybLabel1 yb_addAttributeTapActionWithStrings:@[@"点我",@"点我"] delegate:self];
    
    //需要点击的字符不同
    NSString *label_text2 = @"您好！您是小明吗？你中奖了，领取地址“www.yb.com”,领奖码“9527”";
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
    [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, label_text2.length)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(19, 10)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(35, 4)];
    
    UILabel *ybLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, self.view.bounds.size.width - 20, 60)];
    ybLabel2.backgroundColor = [UIColor greenColor];
    ybLabel2.numberOfLines = 2;
    ybLabel2.attributedText = attributedString2;
    [self.view addSubview:ybLabel2];
    
    [ybLabel2 yb_addAttributeTapActionWithStrings:@[@"www.yb.com",@"9527"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        NSString *message = [NSString stringWithFormat:@"点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),(long)index];
        YBAlertShow(message, @"取消");
    }];
    //设置是否有点击效果，默认是YES
    ybLabel2.enabledTapEffect = NO;
    
    
    //需要点击的字符不同
    NSString *label_text3 = @"您好！您是小明吗？你中奖了，领取地址“ww\nw.yb.com”,领奖码“9527”ighdgi\ngherugyufgrgfuiwefgwef";
    NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc]initWithString:label_text3];
    [attributedString3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, label_text3.length)];
    [attributedString3 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(19, 11)];
    [attributedString3 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(36, 4)];
    
    UILabel *ybLabel3 = [UILabel new];
   
    ybLabel3.numberOfLines = 0;
    ybLabel3.attributedText = attributedString3;
    [self.view addSubview:ybLabel3];
    
    [ybLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ybLabel2.mas_bottom).offset(20);
        make.left.right.mas_equalTo(self.view);
    }];
    
    [ybLabel3 yb_addAttributeTapActionWithStrings:@[@"ww\nw.yb.com",@"9527"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        NSString *message = [NSString stringWithFormat:@"点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),(long)index];
        YBAlertShow(message, @"取消");
    }];
    //设置是否有点击效果，默认是YES
    ybLabel3.enabledTapEffect = YES;
    
}

//delegate
- (void)yb_attributeTapReturnString:(NSString *)string range:(NSRange)range index:(NSInteger)index{
    NSString *message = [NSString stringWithFormat:@"点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),(long)index];
    YBAlertShow(message, @"取消");
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 19;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 19;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeCollectionViewCellID forIndexPath:indexPath];
    cell.contentView.backgroundColor = HQ_RANDOM_COLOR;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(0, 0);
    } else {
        return CGSizeMake(SCREEN_WIDTH, 60);
    }
}

- (UICollectionView *)homeCollectionView {
    if (!_homeCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 16;
        flowLayout.minimumInteritemSpacing = 8;
        flowLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 32) / 3, (SCREEN_WIDTH - 32) * 2 / 3);
        _homeCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _homeCollectionView.delegate = self;
        _homeCollectionView.dataSource = self;
        _homeCollectionView.backgroundColor = [UIColor grayColor];
        [_homeCollectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:homeCollectionViewCellID];
    }
    
    return _homeCollectionView;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
