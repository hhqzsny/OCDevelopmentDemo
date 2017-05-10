//
//  JDSKViewController.m
//  JDSKDemo
//
//  Created by 黄华强 on 2017/2/27.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "JDSKViewController.h"
#import "HHQScrollLoopView.h"
#import "DetailsViewController.h"
#import "ZCNetRequestTool.h"
#import "HHQThreeDimensionalScrollLoopView.h"
#import "ImageCategoryHeader.h"

@interface JDSKViewController ()<scrollLoopViewDelegate,UIScrollViewDelegate,HHQThreeDimensionalScrollLoopDelegate>
@property (nonatomic,strong)UIView *topView;//顶部视图
@property (nonatomic,strong)UIView *bottomView;//底部视图
@property (nonatomic,strong)UIScrollView *scrollView;//滚动视图
@end

@implementation JDSKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [ZCNetRequestTool NetRequestPOSTWithRequestURL:@"http://120.76.227.12/consume/index.php/home/index/test" WithParameter:nil WithReturnValeuBlock:^(id returnValue) {
        NSLog(@"%@",returnValue[@"msg"]);
    } WithErrorCodeBlock:^(id errorCode) {
        
    } WithNetworkBlock:^(BOOL netConnetState) {
        
    }];

    
    
    [self setUpUI];
    // Do any additional setup after loading the view.
}


- (void)setUpUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"经典时刻";
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.topView];
    
    [self addTitle:@"黑色星期五" superView:self.topView];
    HHQScrollLoopView *loop = [[HHQScrollLoopView alloc] initWithFrame:CGRectMake(0, 48, SCREEN_WIDTH, SCREEN_WIDTH * 0.35)];
    loop.delegate = self;
    loop.images =@[@"http://web.img.chuanke.com/fragment/9d595bc8fb5bf049ce3db527ede08abc.jpg",
                   @"http://web.img.chuanke.com/fragment/d662adfaebdc9aa3dac4b04299aa48e1.jpg",
                   @"http://web.img.chuanke.com/fragment/8003092be7e6cc3222c760c89e74a20d.jpg"
                   ];
    

    
    [self.topView addSubview:loop];
    
    NSDictionary *dict = @{@"imageName":@"bgImage",@"text1":@"15元洗车卷",@"text2":@"可省20元"};
    NSArray *dictArr = @[dict,dict,dict,dict,dict,dict,dict];
    
    [self.scrollView addSubview:self.bottomView];
    [self addTitle:@"经典时刻" superView:self.bottomView];
    [self addCarBtn:dictArr superView:self.bottomView];
    
    HHQThreeDimensionalScrollLoopView *threeDView = [[HHQThreeDimensionalScrollLoopView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT + 200, SCREEN_WIDTH, 200)];
    [self.scrollView addSubview:threeDView];
    self.scrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT + 400);
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        imageView.image = [UIImage thumbnailHHQImage:[UIImage imageNamed:@"bgImage"] toSize:CGSizeMake(SCREEN_WIDTH, 200)];
        [arr addObject:imageView];
    }
    
    threeDView.delegate = self;
    
    
    threeDView.bgViewArr = arr;
    
}

-(void)threeDimensionalScrollLoopView:(HHQThreeDimensionalScrollLoopView *)scrollLoopView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了%ld",(long)index);
}


- (void)addCarBtn:(NSArray *)dictArr superView:(UIView *)superView {
    NSInteger count = dictArr.count;
    
    
    for (NSInteger index = 0; index < count ; index++) {
        NSInteger row = index/3;
        NSInteger col = index%3;
        NSInteger btnWidth = (SCREEN_WIDTH - 40)/3;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(col * (btnWidth + 10) + 10, row * (50 + btnWidth) + 48, btnWidth, btnWidth)];
        [superView addSubview:btn];
        btn.tag = 100 + index;
        [btn setImage:[UIImage imageNamed:dictArr[index][@"imageName"]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(col * (btnWidth + 10) + 10, (row + 1) * (btnWidth + 50), btnWidth, 20)];
        label1.textAlignment = NSTextAlignmentLeft;
        label1.font = [UIFont systemFontOfSize:15];
        label1.text = dictArr[index][@"text1"];
        [superView addSubview:label1];
        
        UILabel *label2 =  [[UILabel alloc] initWithFrame:CGRectMake(col * (btnWidth + 10) + 10, (row + 1) * (btnWidth + 50) + 20, btnWidth, 15)];
        label2.textAlignment = NSTextAlignmentLeft;
        label2.font = [UIFont systemFontOfSize:13];
        label2.text = dictArr[index][@"text2"];
        label2.textColor = HHQ_HEX_COLOR(0x666666);
        [superView addSubview:label2];
        
        if (index == (count - 1)) {
          NSInteger height = row * (50 + btnWidth) + 100 + btnWidth + self.bottomView.frame.origin.y;
            CGRect bottomFrame = self.bottomView.frame;
            bottomFrame.size.height = row * (50 + btnWidth) + 100 + btnWidth;
            self.bottomView.frame = bottomFrame;
            if (height > SCREEN_HEIGHT) {
                self.scrollView.contentSize = CGSizeMake(0, height);
            }
        }
        
    }
}

- (void)btnClicked:(UIButton *)btn {
    NSInteger index = btn.tag - 100;
    NSLog(@"%d",index);
    DetailsViewController * detailsVC = [[DetailsViewController alloc] init];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    [self.navigationController pushViewController:detailsVC animated:YES];
    
}

- (void)scrollLoopView:(HHQScrollLoopView *)scrollLoopView didSelectItemAtIndex:(NSInteger)index{
    HHQLOG(@"点击了第%d行",index);
    
}

//添加标题的方法封装
- (void)addTitle:(NSString *)title superView:(UIView *)superView {
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(10, 16, 2, 16)];
    blueView.backgroundColor = HHQ_HEX_COLOR(0x3a81f5);
    [superView addSubview:blueView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 16, SCREEN_WIDTH - 44, 16)];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [superView addSubview:titleLabel];
}

//顶部视图懒加载
-(UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 72, SCREEN_WIDTH, SCREEN_WIDTH/2)];
        _topView.backgroundColor = [UIColor whiteColor];
        
    }
    return _topView;
}
//底部视图懒加载
-(UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topView.frame.origin.y + self.topView.frame.size.height + 8, SCREEN_WIDTH, SCREEN_HEIGHT/2 - 80)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
    }
    return _bottomView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        //取消滚动条
        _scrollView.showsVerticalScrollIndicator = NO;
        //设置滚动视图代理
        _scrollView.delegate = self;
        _scrollView.backgroundColor = HHQ_HEX_COLOR(0xededed);

    }
    return _scrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
