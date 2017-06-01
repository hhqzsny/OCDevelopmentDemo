//
//  HHQPlaceholderTextView.m
//  通用文件存储器项目
//
//  Created by 黄华强 on 2017/5/24.
//  Copyright © 2017年 黄华强. All rights reserved.
//

#import "HHQPlaceholderTextView.h"

@interface HHQPlaceholderTextView ()<UITextViewDelegate>

@property (nonatomic,strong) UILabel *placeholderLabel;
@property (nonatomic,strong) UILabel *remainingWordsLabel;

@end

@implementation HHQPlaceholderTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        _maxNumberWords = 150;
        _placeholder = @"请输入内容";
    }
    return self;
}

- (void)textViewDidChange:(UITextView *)textView {
    
    NSUInteger textViewWords = textView.text.length;
    
    if (textViewWords == 0) {
        [self.placeholderLabel setHidden:NO];
    } else {
        [self.placeholderLabel setHidden:YES];
    }
    
    
    if (textViewWords == 10) {
        NSString *str = [textView.text substringToIndex:20];
    }
    
    
    
    if (textViewWords >= _maxNumberWords) {
        textView.text = [textView.text substringToIndex:textViewWords];
        self.remainingWordsLabel.text = @"剩余0字";
    } else {
        self.remainingWordsLabel.text = [NSString stringWithFormat:@"剩余%u字",_maxNumberWords - textViewWords];
    }
    
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    [_placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).offset(5);
        make.right.mas_equalTo(self).offset(-5);
    }];
}

- (void)setMaxNumberWords:(NSInteger)maxNumberWords {
    _maxNumberWords = maxNumberWords;
    self.remainingWordsLabel.text = [NSString stringWithFormat:@"剩余%lu字",(long)_maxNumberWords];
    [_remainingWordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self).offset(-5);
        make.left.mas_equalTo(self).offset(5);
    }];
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [UILabel new];
        [self addSubview:_placeholderLabel];
        [_placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self).offset(5);
            make.right.mas_equalTo(self).offset(-5);
        }];
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        _placeholderLabel.font = self.font;
    }
    return _placeholderLabel;
}

- (UILabel *)remainingWordsLabel {
    
    if (!_remainingWordsLabel) {
        _remainingWordsLabel = [UILabel new];
        [self addSubview:_remainingWordsLabel];
        [_remainingWordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(self).offset(-5);
            
        }];
        _remainingWordsLabel.textColor = [UIColor lightGrayColor];
        _remainingWordsLabel.font = self.font;
    }
    
    return _remainingWordsLabel;
}

@end
