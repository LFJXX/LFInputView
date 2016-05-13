//
//  ViewController.m
//  LFBottomBar
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import "ViewController.h"
#import "LFInputView.h"
@interface ViewController ()<LFInputViewDelegate>
@property (nonatomic,strong) LFInputView *inputView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inputView = [[LFInputView alloc] init];
    self.inputView.delegate = self;
    [self.view addSubview:self.inputView];
}

- (void)keyboardWillClickSendWithText:(NSString *)text{

    if (text.length == 0) {
        NSLog(@"发送内容不能为空");
        return;
    }
    
    NSLog(@"text==========%@",text);
}

- (IBAction)btnclick:(id)sender {
    [self.inputView endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

@end
