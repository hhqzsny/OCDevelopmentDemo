//
//  ACTextView.m
//  淘纸工作端
//
//  Created by Ac on 16/5/26.
//  Copyright © 2016年 Ac. All rights reserved.
//

#import "ACTextView.h"

#import "UIView+XMGExtension.h"

@interface ACTextView ()

@property (strong, nonatomic) UILabel *placeholderLabel;

@end

@implementation ACTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self) {
        
        self.backgroundColor= [UIColor whiteColor];
        
        UILabel *placeholderLabel = [[UILabel alloc]init];//添加一个占位label
        
        placeholderLabel.backgroundColor= [UIColor clearColor];
        
        placeholderLabel.numberOfLines=0; //设置可以输入多行文字时可以自动换行
        
        [self addSubview:placeholderLabel];
        
        self.placeholderLabel= placeholderLabel; //赋值保存
        
        self.myPlaceholderColor= [UIColor lightGrayColor]; //设置占位文字默认颜色
        
        self.font= [UIFont systemFontOfSize:15]; //设置默认的字体
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self]; //通知:监听文字的改变
        
    }
    
    return self;
}

#pragma mark -监听文字改变

- (void)textDidChange {
    
    self.placeholderLabel.hidden = self.hasText;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    [_placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make){
//        make.top.equalTo(self).with.offset(8);
//        make.left.equalTo(self).with.offset(5);
//    }];
    
    self.placeholderLabel.y = 8; //设置UILabel 的 y值
    
    self.placeholderLabel.x = 5;//设置 UILabel 的 x 值
    
    self.placeholderLabel.width = self.frame.size.width - self.placeholderLabel.x*2.0; //设置 UILabel 的 x
    
    //根据文字计算高度
    
    CGSize maxSize = CGSizeMake(self.placeholderLabel.width,MAXFLOAT);
    
    self.placeholderLabel.height = [self.myPlaceholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
    
}

- (void)setMyPlaceholder:(NSString*)myPlaceholder{
    
    _myPlaceholder= [myPlaceholder copy];
    
    //设置文字
    
    self.placeholderLabel.text= myPlaceholder;
    
    //重新计算子控件frame
    
    [self setNeedsLayout];
    
}

- (void)setMyPlaceholderColor:(UIColor*)myPlaceholderColor{
    
    _myPlaceholderColor= myPlaceholderColor;
    
    //设置颜色
    
    self.placeholderLabel.textColor= myPlaceholderColor;
    
}

- (void)setFont:(UIFont*)font
{
    
    [super setFont:font];
    
    self.placeholderLabel.font= font;
    
    //重新计算子控件frame
    
    [self setNeedsLayout];
    
}

- (void)setText:(NSString*)text{
    
    [super setText:text];
    
    [self textDidChange]; //这里调用的就是 UITextViewTextDidChangeNotification 通知的回调
    
}

- (void)setAttributedText:(NSAttributedString*)attributedText
{
    
    [super setAttributedText:attributedText];
    
    [self textDidChange]; //这里调用的就是UITextViewTextDidChangeNotification 通知的回调
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:UITextViewTextDidChangeNotification];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
}


@end
