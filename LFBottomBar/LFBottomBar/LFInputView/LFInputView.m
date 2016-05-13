//
//  LFInputView.m
//  LFBottomBar
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "LFInputView.h"
#define lFInputViewMinWidth 40
#define lFInputViewMaxWidth 90
@interface LFInputView ()<UITextViewDelegate,LFTextViewDeleagte>
@property (weak, nonatomic)  LFTextView *textView;
@property (weak, nonatomic)  UIButton *changeTypeBtn;

@property (assign, nonatomic) CGFloat inputviewY;

@property (assign, nonatomic) CGFloat currentH;
@end
@implementation LFInputView

- (instancetype)init{

    if (self = [super init]) {
        
        [self setUpUI];
        self.inputviewY = [UIScreen mainScreen].bounds.size.height - lFInputViewMinWidth;
        self.currentH = lFInputViewMinWidth;
        self.frame = CGRectMake(0, self.inputviewY, [UIScreen mainScreen].bounds.size.width, lFInputViewMinWidth);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

- (void)setUpUI{
  
    LFTextView *textView = [[LFTextView alloc] init];
    self.textView = textView ;
    self.textView.delegate = self;
    textView.placeHolder = @"能说点什么呢";
    [self addSubview:textView];
    
    UIButton *changeTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.changeTypeBtn = changeTypeBtn;
    [changeTypeBtn setImage:[UIImage imageNamed:@"emotion"] forState:UIControlStateNormal];
    [changeTypeBtn setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateSelected];
    
    [self addSubview:changeTypeBtn];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
   
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat W = self.bounds.size.width;
    CGFloat H = self.bounds.size.height;
    CGFloat marginX = 10;
    CGFloat iconWH = 40;
    self.textView.frame = CGRectMake(10, 0,W - 2*marginX - iconWH, H);
    self.changeTypeBtn.frame = CGRectMake(CGRectGetMaxX(self.textView.frame), H-iconWH, iconWH, iconWH);
   
}

- (void)textViewDidChange:(UITextView *)textView{
    
    CGFloat W = textView.bounds.size.width-10;
    CGFloat changeH = 0;

    CGFloat height = [textView.text boundingRectWithSize:CGSizeMake(W, lFInputViewMaxWidth) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textView.font} context:nil].size.height;
    
//    NSLog(@"height========%f",height);
    if (height < lFInputViewMinWidth) {
        height = lFInputViewMinWidth;
    }
    if (height > lFInputViewMaxWidth) {
        height = lFInputViewMaxWidth;
    }
    changeH = height - lFInputViewMinWidth;
    self.currentH = height;
    self.frame = CGRectMake(0, self.inputviewY-changeH, [UIScreen mainScreen].bounds.size.width, height);
    [self.inputView setNeedsDisplay];
    
   
}

- (void)keyboardWillChange:(NSNotification *)noti{

    NSDictionary *dict = noti.userInfo;
    CGFloat endPointY = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat duration = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.inputviewY = endPointY-lFInputViewMinWidth;
         self.frame = CGRectMake(0, self.inputviewY-(self.currentH - lFInputViewMinWidth), [UIScreen mainScreen].bounds.size.width, self.currentH);
       
    }];
}

- (void)textViewDidClickSendKeyboard:(UITextView *)textView{

    [self endEditing:YES];
    if ([self.delegate respondsToSelector:@selector(keyboardWillClickSendWithText:)]) {
        [self.delegate keyboardWillClickSendWithText:textView.text];
    }
}

@end
