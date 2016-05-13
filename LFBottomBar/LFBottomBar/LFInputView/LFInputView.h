//
//  LFInputView.h
//  LFBottomBar
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LFTextView.h"

@protocol LFInputViewDelegate <NSObject>

- (void)keyboardWillClickSendWithText:(NSString *)text;

@end
@interface LFInputView : UIView

@property (nonatomic,weak) id<LFInputViewDelegate>delegate;
@end

