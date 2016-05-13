//
//  LFTextView.h
//  LFBookReader
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 xyb100. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LFTextViewDeleagte <NSObject>

- (void)textViewDidChange:(UITextView *)textView;
- (void)textViewDidClickSendKeyboard:(UITextView *)textView;

@end

@interface LFTextView : UIView
@property (nonatomic,copy) NSString *placeHolder;
@property (nonatomic,weak) id<LFTextViewDeleagte>delegate;

@end
