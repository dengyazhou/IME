//
//  EChooseTaxRateView5Kind.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/7/20.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "EChooseTaxRateView5Kind.h"

#import "Header.h"
#import "MyAlertCenter.h"

@interface EChooseTaxRateView5Kind () <UIGestureRecognizerDelegate,UITextFieldDelegate> {
    NSInteger _tag;//默认值为99
}

@property (nonatomic,strong) UIView *viewWhiteBG;
@property (nonatomic,strong) UILabel *label;

@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,strong) UIButton *button;

@property (nonatomic,strong) NSString *tax;


@end

@implementation EChooseTaxRateView5Kind

- (instancetype)initWithFrame:(CGRect)frame defaultTax:(NSString *)tax buttonConfirmClick:(void (^)(NSString *))block{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        _tag = 99;
        self.tax = tax;
        self.buttonBlock = block;
        
        [self addSubview:self.viewWhiteBG];
        [self.viewWhiteBG addSubview:self.label];
        
        
//        NSArray *array = @[@"16%",@"6%",@"3%",@"0%"];
        NSArray *array = @[@"13%",@"16%",@"6%",@"3%"];
        CGFloat btnW = (kMainW-100)/3.0;
        for (NSInteger i = 0;i < 5; i++) {
            if (i < 4) {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20+(btnW+10)*(i%3), +50+18+(32+10)*(i/3), btnW, 32)];
                [btn setTitle:array[i] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                btn.tag = i+100;
                [btn addTarget:self action:@selector(buttonSelectTax:) forControlEvents:UIControlEventTouchUpInside];
                [self.viewWhiteBG addSubview:btn];
                if (i==0 && [tax isEqualToString:@"13"]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"ime_icon_tax选中"] forState:UIControlStateNormal];
                    [btn setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
                } else if (i==1 && [tax isEqualToString:@"16"]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"ime_icon_tax选中"] forState:UIControlStateNormal];
                    [btn setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
                } else if (i==2 && [tax isEqualToString:@"6"]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"ime_icon_tax选中"] forState:UIControlStateNormal];
                    [btn setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
                } else if (i==3 && [tax isEqualToString:@"3"]) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"ime_icon_tax选中"] forState:UIControlStateNormal];
                    [btn setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
                } else {
                    [btn setBackgroundImage:[UIImage imageNamed:@"ime_icon_tax未选中"] forState:UIControlStateNormal];
                    [btn setTitleColor:colorRGB(51, 51, 51) forState:UIControlStateNormal];
                }
            } else {
                UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20+(btnW+10)*(i%3), +50+18+(32+10)*(i/3), btnW, 32)];
                textField.placeholder = @"自定义";
                textField.font = [UIFont systemFontOfSize:14];
                textField.textAlignment = NSTextAlignmentCenter;
                textField.tag = i+100;
                textField.delegate = self;
                textField.keyboardType = UIKeyboardTypeDecimalPad;
                textField.inputAccessoryView = [self addToolbar];
                [textField addTarget:self action:@selector(addTargerTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
                [self.viewWhiteBG addSubview:textField];
                self.textField = textField;
                if ((![tax isEqualToString:@"13"])&&(![tax isEqualToString:@"16"])&&(![tax isEqualToString:@"6"])&&(![tax isEqualToString:@"3"])) {
                    textField.background = [UIImage imageNamed:@"ime_icon_tax选中"];
                    textField.text = tax;
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

- (UIToolbar *)addToolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kMainW, 38)];
    toolbar.tintColor = colorRGB(0, 168, 255);
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space,bar];
    return toolbar;
}

- (void)textFieldDone {
    [self.textField resignFirstResponder];
};

- (void)buttonSelectTax:(UIButton *)sender {
    for (NSInteger i = 100; i < 104; i++) {
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
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    for (NSInteger i = 100; i < 104; i++) {
        UIButton *btn = [self.viewWhiteBG viewWithTag:i];
        [btn setBackgroundImage:[UIImage imageNamed:@"ime_icon_tax未选中"] forState:UIControlStateNormal];
        [btn setTitleColor:colorRGB(51, 51, 51) forState:UIControlStateNormal];
    }
    self.textField.background = [UIImage imageNamed:@"ime_icon_tax选中"];
    _tag = textField.tag;
    
}

- (void)addTargerTextFieldEditingChanged:(UITextField *)textField {
    if (textField.text.length >= 3) {
        NSRange rang0 = NSMakeRange(0, 1);
        NSRange rang1 = NSMakeRange(1, 1);
//        NSRange rang2 = NSMakeRange(2, 1);
        
        NSString *firstS = [textField.text substringWithRange:rang0];
        NSString *secondS = [textField.text substringWithRange:rang1];
//        NSString *thirdS = [textField.text substringWithRange:rang2];
        if ([firstS isEqualToString:@"0"]) {
            textField.text = [textField.text substringFromIndex:1];
        } else {
            if ([firstS isEqualToString:@"1"]&&[secondS isEqualToString:@"0"]) {
                textField.text = @"100";
            } else {
                textField.text = [textField.text substringToIndex:2];
            }
            
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
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
        _label.text = @"开具增值税发票的税率";
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
        [_button setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
    }
    return _button;
}

- (void)buttonConfirm {
    if (_tag == 99) {//没有选择
//        self.tax;
    } else if (_tag == 100) {
        self.tax = @"13";
    } else if (_tag == 101) {
        self.tax = @"16";
    } else if (_tag == 102) {
        self.tax = @"6";
    } else if (_tag == 103) {
        self.tax = @"3";
    } else if (_tag == 104) {
        if (self.textField.text.length == 0) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"税率不能为空"];
            return;
        }
        self.tax = self.textField.text;
    }
    
    self.hidden = YES;
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
