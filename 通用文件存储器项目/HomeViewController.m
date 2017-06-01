//
//  HomeViewController.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/5/10.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "HomeViewController.h"
#import "HHQPlaceholderTextView.h"
#import "ACTextView.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    self.view.backgroundColor = VIEW_BACKGROUNDCOLOR;
    self.title = @"首页";
    HHQPlaceholderTextView *pTV = [[HHQPlaceholderTextView alloc] initWithFrame:CGRectMake(100, 80, 200, 200)];
    pTV.placeholder = @"请输入内HD方式方法好舒服横槊赋诗负石赴河冯绍峰收到回复容";
    pTV.maxNumberWords = 100;
    [self.view addSubview:pTV];

    ACTextView *acTV = [[ACTextView alloc] initWithFrame:CGRectMake(10, 300, 200, 200)];
    acTV.myPlaceholder = @"请输多喝点水风沙大干坏事大概多少噶蛋糕店萨达根深蒂固入内容";
    acTV.font = [UIFont systemFontOfSize:SCREEN_WIDTH * 0.04];
    [self.view addSubview:acTV];
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
