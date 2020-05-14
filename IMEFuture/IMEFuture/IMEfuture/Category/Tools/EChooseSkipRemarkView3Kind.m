//
//  EChooseTaxRateView5Kind.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/7/20.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "EChooseSkipRemarkView3Kind.h"

#import "Header.h"
#import "MyAlertCenter.h"

#define string0 @"工厂产能不足"
#define string1 @"交期不能保证"

@interface EChooseSkipRemarkView3Kind () <UIGestureRecognizerDelegate,UITextFieldDelegate> {
    NSInteger _tag;//默认值为99
}

@property (nonatomic,strong) UIView *viewWhiteBG;
@property (nonatomic,strong) UILabel *label;

@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,strong) UIButton *button;

@property (nonatomic,strong) NSString *tax;


@end

@implementation EChooseSkipRemarkView3Kind

- (instancetype)initWithFrame:(CGRect)frame defaultSkipRemark:(NSString *)skipRemark buttonConfirmClick:(void(^)(NSString *confirmTax))block{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        if ([skipRemark isEqualToString:string0]) {
            _tag = 100;
        } else if ([skipRemark isEqualToString:string1]) {
            _tag = 101;
        } else if (skipRemark.length > 0) {
            _tag = 102;
        } else {
            _tag = 99;
        }
        self.tax = skipRemark;
        self.buttonBlock = block;
        
        [self addSubview:self.viewWhiteBG];
        [self.viewWhiteBG addSubview:self.label];
        
        
        NSArray *array = @[string0,string1];
        CGFloat btnW = (kMainW-90)/2.0;
        for (NSInteger i = 0;i < 3; i++) {
            if (i < 2) {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20+(btnW+10)*(i%2), 50+18+(32+10)*(i/2), btnW, 32)];
                [btn setTitle:array[i] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                btn.tag = i+100;
                [btn addTarget:self action:@selector(buttonSelectTax:) forControlEvents:UIControlEventTouchUpInside];
                [self.viewWhiteBG addSubview:btn];
                if (i==0 && [skipRemark isEqualToString:string0]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"ime_icon_tax选中"] forState:UIControlStateNormal];
                    [btn setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
                } else if (i==1 && [skipRemark isEqualToString:string1]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"ime_icon_tax选中"] forState:UIControlStateNormal];
                    [btn setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
                } else {
                    [btn setBackgroundImage:[UIImage imageNamed:@"ime_icon_tax未选中"] forState:UIControlStateNormal];
                    [btn setTitleColor:colorRGB(51, 51, 51) forState:UIControlStateNormal];
                }
            } else {
                UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20+(btnW+10)*(i%2), 50+18+(32+10)*(i/2), kMainW-80, 32)];
                textField.placeholder = @"其他";
                textField.font = [UIFont systemFontOfSize:14];
                textField.textAlignment = NSTextAlignmentLeft;
                textField.tag = i+100;
                textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
                textField.leftViewMode = UITextFieldViewModeAlways;
                
                [self.viewWhiteBG addSubview:textField];
                self.textField = textField;
                self.textField.delegate = self;
                if (_tag == 102) {
                    textField.background = [UIImage imageNamed:@"ime_icon_tax选中"];
                    textField.text = skipRemark;
                } else {
                    textField.background = [UIImage imageNamed:@"ime_icon_tax未选中"];
                }
            }
        }
        
      
        [self.viewWhiteBG addSubview:self.button];
        
        UITapGestureRecognizer *singleFingerOne  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
        singleFingerOne.numberOfTouchesRequired = 1;
        singleFingerOne.numberOfTapsRequired = 1;
        singleFingerOne.delegate = self;
        [self addGestureRecognizer:singleFingerOne];
    }
    return self;
}

- (void)buttonSelectTax:(UIButton *)sender {
    for (NSInteger i = 100; i < 102; i++) {
        UIButton *btn = [self.viewWhiteBG viewWithTag:i];
        if (sender.tag == i) {
            [btn setBackgroundImage:[UIImage imageNamed:@"ime_icon_tax选中"] forState:UIControlStateNormal];
            [btn setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
        } else {
            [btn setBackgroundImage:[UIImage imageNamed:@"ime_icon_tax未选中"] forState:UIControlStateNormal];
            [btn setTitleColor:colorRGB(51, 51, 51) forState:UIControlStateNormal];
        }
    }
    self.textField.background = [UIImage imageNamed:@"ime_icon_tax未选中"];
    [self.textField resignFirstResponder];
    _tag = sender.tag;
    
    if (_tag == 99) {
        [_button setTitleColor:colorRGB(163, 241, 255) forState:UIControlStateNormal];
        _button.enabled = NO;
    } else {
        [_button setTitleColor:colorGong forState:UIControlStateNormal];
        _button.enabled = YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    for (NSInteger i = 100; i < 102; i++) {
        UIButton *btn = [self.viewWhiteBG viewWithTag:i];
        [btn setBackgroundImage:[UIImage imageNamed:@"ime_icon_tax未选中"] forState:UIControlStateNormal];
        [btn setTitleColor:colorRGB(51, 51, 51) forState:UIControlStateNormal];
    }
    self.textField.background = [UIImage imageNamed:@"ime_icon_tax选中"];
    _tag = textField.tag;
    
    if (_tag == 99) {
        [_button setTitleColor:colorRGB(163, 241, 255) forState:UIControlStateNormal];
        _button.enabled = NO;
    } else {
        [_button setTitleColor:colorGong forState:UIControlStateNormal];
        _button.enabled = YES;
    }
    
}

- (UIView *)viewWhiteBG {
    if (!_viewWhiteBG) {
        _viewWhiteBG = [[UIView alloc] init];
        _viewWhiteBG.bounds = CGRectMake(0, 0, kMainW-40, 215);
        _viewWhiteBG.layer.cornerRadius = 7;
        _viewWhiteBG.layer.masksToBounds = YES;
        _viewWhiteBG.backgroundColor = [UIColor whiteColor];
    }
    return _viewWhiteBG;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.viewWhiteBG.frame), 50)];
        _label.text = @"选择暂不报价的原因";
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:16];
        _label.textColor = colorRGB(51, 51, 51);
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 50, CGRectGetWidth(self.viewWhiteBG.frame), 0.5)];
        viewLine.backgroundColor = colorRGB(221, 221, 221);
        [self.viewWhiteBG addSubview:viewLine];
    }
    return _label;
}

- (UIButton *)button {
    if (!_button) {
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.viewWhiteBG.frame)-44-0.5, CGRectGetWidth(self.viewWhiteBG.frame), 0.5)];
        viewLine.backgroundColor = colorRGB(221, 221, 221);
        [self.viewWhiteBG addSubview:viewLine];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, CGRectGetHeight(self.viewWhiteBG.frame)-44, CGRectGetWidth(self.viewWhiteBG.frame), 44);
        [_button setTitle:@"确认" forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:16];
        [_button addTarget:self action:@selector(buttonConfirm) forControlEvents:UIControlEventTouchUpInside];
        if (_tag == 99) {
            [_button setTitleColor:colorRGB(163, 241, 255) forState:UIControlStateNormal];
            _button.enabled = NO;
        } else {
            [_button setTitleColor:colorGong forState:UIControlStateNormal];
            _button.enabled = YES;
        }
        
    }
    return _button;
}

- (void)buttonConfirm {
    if (_tag == 99) {//没有选择
//        self.tax;
    } else if (_tag == 100) {
        self.tax = string0;
    } else if (_tag == 101) {
        self.tax = string1;
    } else if (_tag == 102) {
        
        if (self.textField.text.length == 0) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"原因不能为空"];
            return;
        }
        self.tax = self.textField.text;
    }
    
//    self.hidden = YES;
    [self removeFromSuperview];
    [self.textField resignFirstResponder];
    
    if (self.buttonBlock) {
        self.buttonBlock(self.tax);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.viewWhiteBG.center = self.center;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.viewWhiteBG]) {
        return NO;
    }
    return YES;
}
- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)tap{
    if (self.viewWhiteBG.center.y == self.center.y) {//税率选择框在上面，点击空白就让键盘下去；税率选择框在中间，点击空白就隐藏
//        self.hidden = YES;
        [self removeFromSuperview];
    } else {
        [self.textField resignFirstResponder];
    }
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {//在底部
        self.viewWhiteBG.center = self.center;
    } else {//在上面
        self.viewWhiteBG.center = CGPointMake(self.center.x, self.center.y-rect.size.height/2);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
