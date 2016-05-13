//
//  LFTextView.m
//  LFBookReader
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "LFTextView.h"

@interface LFTextView ()<UITextViewDelegate>
@property (nonatomic,weak) UILabel *plactHolderLable;
@property (nonatomic,weak) UITextView *textView;
@end
@implementation LFTextView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    

    UITextView *textView = [[UITextView alloc] init];
    self.textView = textView;
//    self.textView.backgroundColor = [UIColor grayColor];
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.delegate = self;
    self.textView.returnKeyType = UIReturnKeySend;
    [self addSubview:textView];
    

    UILabel *placeHolderLable = [[UILabel alloc] init];
    placeHolderLable.font = [UIFont systemFontOfSize:15];
    placeHolderLable.textColor = [UIColor grayColor];
    self.plactHolderLable = placeHolderLable;
    placeHolderLable.text = @"写点什么呢";
    self.placeHolder = @"写点什么呢 (不少于5个字)";
    self.plactHolderLable.textAlignment = NSTextAlignmentLeft;
    [self addSubview:placeHolderLable];

    
}

- (void)layoutSubviews{

    [super layoutSubviews];
//    CGFloat marginX = 10;
    CGFloat W = self.bounds.size.width;
    self.textView.frame = CGRectMake(0, 3,W, self.bounds.size.height-6);
    self.plactHolderLable.frame = CGRectMake(5, 5, self.bounds.size.width, self.bounds.size.height-10);
    [self.textView setContentOffset:CGPointMake(0, (self.textView.contentSize.height - self.textView.frame.size.height) / 2)];
    
//    NSLog(@"--=%f--%f",self.textView.contentSize.height,self.textView.frame.size.height);
}

- (void)setPlaceHolder:(NSString *)placeHolder{

    _placeHolder = placeHolder;
    self.plactHolderLable.text = placeHolder;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if (textView.text.length == 0) {
        self.plactHolderLable.hidden = NO;
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    if ([text isEqualToString:@"\n"]) {
        if ([self.delegate respondsToSelector:@selector(textViewDidClickSendKeyboard:)]) {
           [self.delegate textViewDidClickSendKeyboard:textView];
        }
        textView.text = @"";
        [self textViewDidChange:textView];
        
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        
        self.plactHolderLable.hidden = YES;
        
    }else{
        self.plactHolderLable.hidden = NO;
        
        
    }
    
  
    if ([self.delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.delegate textViewDidChange:textView];
    }
}

@end
