//
//  DetailsViewController.m
//  ScrollLoopView
//
//  Created by 黄华强 on 2017/2/27.
//  Copyright © 2017年 mark. All rights reserved.
//

#import "DetailsViewController.h"


@interface DetailsViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;//滚动视图
@property (nonatomic,strong) UIWebView *webView;//网页视图

@property (nonatomic,strong) UIButton *sureBtn;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    // Do any additional setup after loading the view.
}

- (void)setUpUI {
    
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = @"佳通轮胎";
    [self.view addSubview:self.scrollView];
    
    UIImageView * carImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [self.scrollView addSubview:carImageView];
    carImageView.image = [UIImage imageNamed:@"bgImage"];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 86)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:topView];
    [self addSubView:topView];
    
    UIView *midView = [[UIView alloc] initWithFrame:CGRectMake(0, 294, SCREEN_WIDTH, 32)];
    midView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:midView];
    [self addMidSubView:midView];
    
    
    [self.scrollView addSubview:self.webView];
    
    
    _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.2, SCREEN_HEIGHT - 136, SCREEN_WIDTH * 0.6, 44)];
    _sureBtn.backgroundColor = HHQ_HEX_COLOR(0xf42f34);
    [_sureBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [self.scrollView addSubview:_sureBtn];
}

- (void)addMidSubView:(UIView *)view {
    NSArray * strArr = @[@"免费安装",@"上门服务",@"正品保证"];
    for (NSInteger i = 0; i <= 2; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10 + i * 50, 10, 44, 12)];
        [btn setTitle:strArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:HHQ_HEX_COLOR(0x3a81f5) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        btn.layer.borderColor = [HHQ_HEX_COLOR(0x3a81f5) CGColor];
        
        btn.layer.borderWidth = 1.0f;
        [view addSubview:btn];
    }
}

- (void)addSubView:(UIView *)view {
    UILabel * oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, SCREEN_WIDTH - 16, 20)];
    oneLabel.textAlignment = NSTextAlignmentLeft;
    oneLabel.text = @"佳通轮胎";
    [view addSubview:oneLabel];
    
    UILabel * twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 30, SCREEN_WIDTH - 16, 15)];
    twoLabel.textAlignment = NSTextAlignmentLeft;
    twoLabel.text = @"配套经典，百万选择";
    twoLabel.font = [UIFont systemFontOfSize:13];
    twoLabel.textColor = HHQ_HEX_COLOR(0x999999);
    [view addSubview:twoLabel];
    
    UILabel *threeLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 46, SCREEN_WIDTH/2 - 8, 40)];
    threeLabel.text = @"￥99精币";
    threeLabel.textColor = HHQ_HEX_COLOR(0x3a81f5);
    [view addSubview:threeLabel];
    
    
    UILabel *fourLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 46, SCREEN_WIDTH/2 - 8, 40)];
    fourLabel.textAlignment = NSTextAlignmentRight;
    fourLabel.text = @"1022人购买";
    fourLabel.font = [UIFont systemFontOfSize:13];
    fourLabel.textColor = HHQ_HEX_COLOR(0x999999);
    [view addSubview:fourLabel];
    
}

/*
 _webView.scrollView.bounces = NO;
 _webView.scrollView.showsHorizontalScrollIndicator = NO;
 _webView.scrollView.scrollEnabled = NO;
 [_webView sizeToFit];
 
 ///////////////////////////////设置内容，这里包装一层div，用来获取内容实际高度（像素），htmlcontent是html格式的字符串//////////////
 NSString * htmlcontent = [NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", htmlcontent];
 [_webView loadHTMLString:htmlcontent baseURL:nil];
 
 ////////////////////////////////delegate的方法重载////////////////////////////////////////////
 - (void)webViewDidFinishLoad:(UIWebView *)webView
 {
 //获取页面高度（像素）
 NSString * clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.clientHeight"];
 float clientheight = [clientheight_str floatValue];
 //设置到WebView上
 webView.frame = CGRectMake(0, 0, self.view.frame.size.width, clientheight);
 //获取WebView最佳尺寸（点）
 CGSize frame = [webView sizeThatFits:webView.frame.size];
 
 //获取内容实际高度（像素）
 NSString * height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('webview_content_wrapper').clientHeight + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-top'))  + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-bottom'))"];
 float height = [height_str floatValue];
 //内容实际高度（像素）* 点和像素的比
 height = height * frame.height / clientheight;
 //再次设置WebView高度（点）
 webView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
 }
*/

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat webViewHeight=[webView.scrollView contentSize].height;
    HHQLOG(@"%@",webView);
    CGRect newFrame = webView.frame;
    newFrame.size.height = webViewHeight;
    webView.frame = newFrame;
    
    
    CGRect sureFrame = self.sureBtn.frame;
    sureFrame.origin.y = webView.frame.origin.y + webView.frame.size.height + 28;
    self.sureBtn.frame = sureFrame;
    
    //CGRect scrollFrame = self.scrollView.frame;
    CGFloat scHeight = sureFrame.origin.y + sureFrame.size.height + 28;
    HHQLOG(@"%f,%@",scHeight,_scrollView);
//    if (scHeight > SCREEN_HEIGHT) {
        //scrollFrame.size.height = scHeight;
        //self.scrollView.frame = scrollFrame;
        HHQLOG(@"%f,%@",scHeight,_scrollView);
        self.scrollView.contentSize = CGSizeMake(0, scHeight);
        HHQLOG(@"%f,%@",scHeight,_scrollView);
   // }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 334, SCREEN_WIDTH, SCREEN_HEIGHT - 498)];
        _webView.delegate = self;
        _webView.scrollView.bounces = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.scrollEnabled = NO;
        [_webView sizeToFit];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString * str = @"fhfshfgshdjfdfh都给我我sfgs各一份u国服隔夜饭个副业工副业国服夜光粉u语法隔夜饭fgdfgskdhfhsdkffgsdkfjhsdfshfgshfskfhskyfghsfkgslfksfsdfgsdfusfusdfhsudfhsdfhsdfufhslfsfuiehfiwofhlusfehsikfhuehfefuowlfusfshhufhkefslfuh话费送饭i哦好松岛枫i还送番号i偶尔番号乱世繁华商量好了发生的扶了扶黑素瘤度格语法fhslkvjdlgvsdvdhvdhvdlvxkvhxkvfhfsj话费收到回复疯狂的发货人法国人路i山沟沟可汇个款哥u番号如更厉款的发过了乳房个人UI东风公司服高";
            NSString * htmlstr = [NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", str];
            HHQLOG(@"%@",_webView);
            [_webView loadHTMLString:htmlstr baseURL:nil];
        });
        
        
    }
    return _webView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        //取消滚动条
        _scrollView.showsVerticalScrollIndicator = NO;
        //设置滚动视图代理
        _scrollView.delegate = self;
        _scrollView.backgroundColor = HHQ_HEX_COLOR(0xededed);
        
        //关闭弹簧效果
        //_scrollView.bounces = NO;
    }
    return _scrollView;
}

@end
