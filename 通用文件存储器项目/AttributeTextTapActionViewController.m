//
//  AttributeTextTapActionViewController.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/7/6.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "AttributeTextTapActionViewController.h"
#import "UILabel+YBAttributeTextTapAction.h"


#define YBAlertShow(messageText,buttonName) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:(messageText) \
delegate:nil cancelButtonTitle:(buttonName) otherButtonTitles: nil];\
[alert show];

@interface AttributeTextTapActionViewController ()<YBAttributeTapActionDelegate>

@end

@implementation AttributeTextTapActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"富文本点击效果";
    [self createUI];
}

- (void)createUI {
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
