//
//  UIViewChaKanCiPingLaiYuan.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/14.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "UIViewTuiHou.h"
#import "VoHeader.h"

@interface UIViewTuiHou () <UITextViewDelegate>

@end

@implementation UIViewTuiHou

- (void)initViewTuiHuoButtonClick:(void(^)(NSString *string,NSString *string1))block {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.buttonBlock = block;
    self.textfield.inputAccessoryView = [self addToolbar];
    
    self.textView.inputAccessoryView = [self addToolbar];
    self.textView.delegate = self;
    
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {
        self.viewBGCenterY.constant = 0;
    } else {
        self.viewBGCenterY.constant = -100;
    }
}

- (UIToolbar *)addToolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 38)];
    toolbar.tintColor = colorRGB(0, 168, 255);
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space,bar];
    return toolbar;
}

- (void)textFieldDone {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.labelQingTianXieBeiZhu.hidden = YES;
    } else {
        self.labelQingTianXieBeiZhu.hidden = NO;
    }
}

- (IBAction)buttonQueRen:(UIButton *)sender {
    if (!(self.textfield.text.length>0)) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入退货数量"];
        return;
    }
    if (!(self.textView.text.length>0)) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入退货备注"];
        return;
    }
    self.buttonBlock(self.textfield.text,self.textView.text);
    [self removeFromSuperview];
}

- (IBAction)buttonQuXiao:(UIButton *)sender {
    [self removeFromSuperview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
