//
//  EChooseViewCaiDingDan.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2016/11/1.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "EChooseViewCaiDingDan.h"

#import "Header.h"

#import "LineView.h"

@interface EChooseViewCaiDingDan () {
    NSString *_labelType;
    NSMutableArray *_arrayType;
    NSMutableArray *_arrayTypeNoOrYes;
    NSString *_labelState;
    NSMutableArray *_arrayState;
    NSMutableArray *_arrayStateNoOrYes;
    NSString *_labelTime;
    NSString *_time0;
    NSString *_time1;
    
    NSString *_strSuoShuXiangMu;
    NSString *_strGongYingShang;
    
    NSMutableArray *_array3;
    
     CGFloat _height_NavBar;
}

@property(nonatomic,strong) UIView *viewTop;
@property(nonatomic,strong) UIButton *button;

@property (nonatomic,strong) UIView *viewTotal;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *viewZero;
@property (nonatomic,strong) UIView *viewOne;
@property (nonatomic,strong) UIView *viewOn1;
@property (nonatomic,strong) UIView *viewTwo;
@property (nonatomic,strong) UIView *viewThree;

@property (nonatomic,strong) UIView *viewBottom;

@property (nonatomic,strong) UIView *viewDatePickerBg;

@property (nonatomic,strong) UIColor *color;

@end

@implementation EChooseViewCaiDingDan

- (instancetype)initWithFrame:(CGRect)frame withTitleState:(NSString *)labelType withState:(NSArray *)arrayType withArrayTypeNoOrYes:(NSMutableArray *)arrayTypeNoOrYes withTitleState:(NSString *)labelState withState:(NSArray *)arrayState withArrayStateNoOrYes:(NSMutableArray *)arrayStateNoOrYes withTitleTime:(NSString *)labelTime withTime0:(NSString *)time0 withTime1:(NSString *)time1 with:(NSArray *)array3 withColor:(UIColor *)color {
    self = [super initWithFrame:frame];
    if (self) {
        _height_NavBar = Height_NavBar;
        
        self.color = color;
        self.viewTop = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, _height_NavBar+42.5)];
        self.viewTop.backgroundColor = [UIColor clearColor];
        [self addSubview:_viewTop];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(kMainW-90, _height_NavBar, 90, 42.5);
        [self.button addTarget:self action:@selector(buttonClickErCiDianJi) forControlEvents:UIControlEventTouchUpInside];
        [self.viewTop addSubview:self.button];
        
        
        self.viewTotal = [[UIView alloc] init];
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.backgroundColor = colorRGB(241, 241, 241);
        
        self.viewZero = [[UIView alloc] init];
        self.viewZero.backgroundColor = [UIColor whiteColor];
        UILabel *label0 = [[UILabel alloc] init];
        label0.frame = CGRectMake(15, 10, 150, 20);
        label0.textColor = colorRGB(117, 117, 117);
        label0.text = labelType;
        [self.viewZero addSubview:label0];
        
        UILabel *labelLine0 = (UILabel *)[LineView lineWithFrame:CGRectMake(CGRectGetMinX(label0.frame), CGRectGetMaxY(label0.frame)+10, frame.size.width-15*2, 0.5) withColor:colorRGB(221, 221, 221)];
        [self.viewZero addSubview:labelLine0];
        
        UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
        button0.frame = CGRectMake(0, CGRectGetMaxY(labelLine0.frame)+20, 0, 0);
        button0.backgroundColor = [UIColor redColor];
        [self.viewZero addSubview:button0];
        _arrayType = [[NSMutableArray alloc] init];
        for (int i = 0; i < arrayType.count; i++) {
            CGSize size = [arrayType[i] boundingRectWithSize:CGSizeMake(1000, 14) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            CGFloat arrW = size.width + 30;
            CGFloat arrB = CGRectGetMaxX(button0.frame);
            if ((arrB+10+arrW+10) > kMainW) {
                //换行
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = 100 + i;
                button.frame = CGRectMake(15, CGRectGetMaxY(button0.frame)+15, arrW, 35);
                [button setTitle:arrayType[i] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                [button addTarget:self action:@selector(buttonClick0:) forControlEvents:UIControlEventTouchUpInside];
                [self.viewZero addSubview:button];
                button0 = button;
            } else {
                //不换行
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = 100 + i;
                button.frame = CGRectMake(arrB + 15, CGRectGetMinY(button0.frame), arrW, 35);
                [button setTitle:arrayType[i] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                [button addTarget:self action:@selector(buttonClick0:) forControlEvents:UIControlEventTouchUpInside];
                [self.viewZero addSubview:button];
                button0 = button;
            }
            [_arrayType addObject:button0];
        }
        if (arrayType.count == 2) {//如果数组数为2直接隐藏询盘类型
            self.viewZero.frame = CGRectMake(0, 0, frame.size.width, 0);
        } else {
            self.viewZero.frame = CGRectMake(0, 0, frame.size.width, 20+CGRectGetMaxY(button0.frame));
        }

        _arrayTypeNoOrYes = arrayTypeNoOrYes;
        for (int i = 0; i < _arrayTypeNoOrYes.count; i++) {
            UIButton *button = _arrayType[i];
            if ([_arrayTypeNoOrYes[i] isEqualToString:@"NO"]) {
                [button setTitleColor:colorRGB(32, 32, 32) forState:UIControlStateNormal];
                button.backgroundColor = colorRGB(232, 232, 232);
            }
            if ([_arrayTypeNoOrYes[i] isEqualToString:@"YES"]) {
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                button.backgroundColor = color;
            }
        }
        
        self.viewOne = [[UIView alloc] init];
        self.viewOne.backgroundColor = [UIColor whiteColor];
        UILabel *label1 = [[UILabel alloc] init];
        label1.frame = CGRectMake(15, 10, 150, 20);
        label1.textColor = colorRGB(117, 117, 117);
        label1.text = labelState;
        [self.viewOne addSubview:label1];
        
        UILabel *labelLine1 = (UILabel *)[LineView lineWithFrame:CGRectMake(CGRectGetMinX(label1.frame), CGRectGetMaxY(label1.frame)+10, frame.size.width-15*2, 0.5) withColor:colorRGB(221, 221, 221)];
        [self.viewOne addSubview:labelLine1];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(0, CGRectGetMaxY(labelLine1.frame)+20, 0, 0);
        button1.backgroundColor = [UIColor redColor];
        [self.viewOne addSubview:button1];
        _arrayState = [[NSMutableArray alloc] init];
        for (int i = 0; i < arrayState.count; i++) {
            CGSize size = [arrayState[i] boundingRectWithSize:CGSizeMake(1000, 14) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            CGFloat arrW = size.width + 30;
            CGFloat arrB = CGRectGetMaxX(button1.frame);
            if ((arrB+10+arrW+10) > kMainW) {
                //换行
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = 100 + i;
                button.frame = CGRectMake(15, CGRectGetMaxY(button1.frame)+15, arrW, 35);
                [button setTitle:arrayState[i] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                [button addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
                [self.viewOne addSubview:button];
                button1 = button;
            } else {
                //不换行
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = 100 + i;
                button.frame = CGRectMake(arrB + 15, CGRectGetMinY(button1.frame), arrW, 35);
                [button setTitle:arrayState[i] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                [button addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
                [self.viewOne addSubview:button];
                button1 = button;
            }
            [_arrayState addObject:button1];
        }
        self.viewOne.frame = CGRectMake(0, CGRectGetMaxY(self.viewZero.frame), frame.size.width, 20+CGRectGetMaxY(button1.frame));
        _arrayStateNoOrYes = arrayStateNoOrYes;
        for (int i = 0; i < _arrayStateNoOrYes.count; i++) {
            UIButton *button = _arrayState[i];
            if ([_arrayStateNoOrYes[i] isEqualToString:@"NO"]) {
                [button setTitleColor:colorRGB(32, 32, 32) forState:UIControlStateNormal];
                button.backgroundColor = colorRGB(232, 232, 232);
            }
            if ([_arrayStateNoOrYes[i] isEqualToString:@"YES"]) {
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                button.backgroundColor = color;
            }
        }
        
        
        self.viewOn1 = [[UIView alloc] init];
        self.viewOn1.backgroundColor = [UIColor whiteColor];
        UILabel *labelOn1 = [[UILabel alloc] init];
        labelOn1.frame = CGRectMake(15, 10, 100, 30);
        labelOn1.textColor = colorRGB(117, 117, 117);
        labelOn1.text = @"所属项目";
        [self.viewOn1 addSubview:labelOn1];
        
        UITextField *textFieldOn1 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labelOn1.frame)+10, 10, frame.size.width-(CGRectGetMaxX(labelOn1.frame)+10)-15, 30)];
        textFieldOn1.borderStyle = UITextBorderStyleRoundedRect;
        textFieldOn1.placeholder = @"请输入";
        [textFieldOn1 addTarget:self action:@selector(textFieldSuoShuXiangMu:) forControlEvents:UIControlEventAllEditingEvents];
        textFieldOn1.tag = 10;
        textFieldOn1.inputAccessoryView = [self addToolbar];
        [self.viewOn1 addSubview:textFieldOn1];
        
        UILabel *labelOn2 = [[UILabel alloc] init];
        labelOn2.frame = CGRectMake(15, CGRectGetMaxY(labelOn1.frame)+10, 100, 30);
        labelOn2.textColor = colorRGB(117, 117, 117);
        labelOn2.text = @"供应商";
        [self.viewOn1 addSubview:labelOn2];
        
        UITextField *textFieldOn2 = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labelOn1.frame)+10, CGRectGetMaxY(textFieldOn1.frame)+10, frame.size.width-(CGRectGetMaxX(labelOn1.frame)+10)-15, 30)];
        textFieldOn2.borderStyle = UITextBorderStyleRoundedRect;
        textFieldOn2.placeholder = @"请输入";
        [textFieldOn2 addTarget:self action:@selector(textFieldGongYinShang:) forControlEvents:UIControlEventAllEditingEvents];
        textFieldOn2.tag = 11;
        textFieldOn2.inputAccessoryView = [self addToolbar];
        [self.viewOn1 addSubview:textFieldOn2];
        
        self.viewOn1.frame = CGRectMake(0, CGRectGetMaxY(self.viewOne.frame), frame.size.width, CGRectGetMaxY(textFieldOn2.frame)+10);
        

        self.viewTwo = [[UIView alloc] init];
        self.viewTwo.backgroundColor = [UIColor whiteColor];
        UILabel *label2 = [[UILabel alloc] init];
        label2.frame = CGRectMake(15, 15, 150, 20);
        label2.textColor = colorRGB(117, 117, 117);
        label2.text = labelTime;
        [self.viewTwo addSubview:label2];
        
        UILabel *labelLine2 = (UILabel *)[LineView lineWithFrame:CGRectMake(CGRectGetMinX(label2.frame), CGRectGetMaxY(label2.frame)+3, frame.size.width-15*2, 0.5) withColor:colorRGB(221, 221, 221)];
        [self.viewTwo addSubview:labelLine2];
        
        
        _time0 = time0;
        _time1 = time1;
        UITextField *textField2;
        for (int i = 0; i < 2; i++) {
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15 + i%2*(((frame.size.width-15*3)/2) + 15), CGRectGetMaxY(labelLine2.frame)+20+i/2*(35+15), (frame.size.width-15*3)/2, 35)];
            textField.borderStyle = UITextBorderStyleRoundedRect;
            textField.placeholder = @"请选择";
            textField.inputView = [UIView new];
            textField.tintColor = [UIColor clearColor];
            [textField addTarget:self action:@selector(textFieldClick2:) forControlEvents:UIControlEventAllEditingEvents];
            textField.tag = i+10;
            if (i == 0) {
                textField.text = _time0;
            } else if (i == 1) {
                textField.text = _time1;
            }
            [self.viewTwo addSubview:textField];
            textField2 = textField;
        }
        self.viewTwo.frame = CGRectMake(0, CGRectGetMaxY(self.viewOn1.frame), frame.size.width, 20+CGRectGetMaxY(textField2.frame));
        
        self.viewThree = [[UIView alloc] init];
        self.viewThree.backgroundColor = colorRGB(232, 232, 232);
        
        _array3 = [[NSMutableArray alloc] init];
        for (int i = 0; i < 2; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(15 + i%2*(((frame.size.width-15*2-10)/2) + 10), 15, (frame.size.width-15*2-10)/2, 40);
            if (i == 0) {
                button.backgroundColor = [UIColor whiteColor];
                [button setTitleColor:colorRGB(32, 32, 32) forState:UIControlStateNormal];
            } else {
                button.backgroundColor = color;
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            [button setTitle:array3[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClick3:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 300 + i;
            [self.viewThree addSubview:button];
            [_array3 addObject:button];
        }
        
        
        self.viewTotal.frame = CGRectMake(frame.origin.x, CGRectGetMaxY(self.viewTop.frame), frame.size.width, 347/667.0*kMainH);
        self.scrollView.frame = CGRectMake(frame.origin.x, 0, frame.size.width, 347/667.0*kMainH-70);
        self.scrollView.contentSize = CGSizeMake(frame.size.width, CGRectGetMaxY(self.viewTwo.frame));
        
        self.viewThree.frame = CGRectMake(frame.origin.x, CGRectGetMaxY(self.scrollView.frame), frame.size.width, 70);
        
        [self.scrollView addSubview:self.viewZero];
        [self.scrollView addSubview:self.viewOne];
        [self.scrollView addSubview:self.viewOn1];
        [self.scrollView addSubview:self.viewTwo];
        [self.viewTotal addSubview:self.scrollView];
        [self.viewTotal addSubview:self.viewThree];
    
        [self addSubview:self.viewTotal];
        
        self.viewBottom = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, CGRectGetMaxY(self.viewTotal.frame), frame.size.width, frame.size.height-CGRectGetMaxY(self.viewTotal.frame))];
        self.viewBottom.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [self addSubview:self.viewBottom];
//        self.viewBottom.backgroundColor = [UIColor redColor];
        
        UITapGestureRecognizer *singleFingerOne  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
        singleFingerOne.numberOfTouchesRequired = 1;
        singleFingerOne.numberOfTapsRequired = 1;
        [self.viewBottom addGestureRecognizer:singleFingerOne];
        
        
        
        
        self.viewDatePickerBg = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
//        self.viewDatePickerBg.backgroundColor = [UIColor cyanColor];
        [self addSubview:self.viewDatePickerBg];
        self.viewDatePickerBg.hidden = YES;
        
        for (int i = 0; i < 2; i++) {
            UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.viewDatePickerBg.frame)-200, CGRectGetWidth(self.viewDatePickerBg.frame), 200)];
            datePicker.backgroundColor = [UIColor whiteColor];
            [datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];
            datePicker.datePickerMode = UIDatePickerModeDate;
            [datePicker addTarget:self action:@selector(dateChange:)forControlEvents:UIControlEventValueChanged];
            datePicker.tag = i+10;
            [self.viewDatePickerBg addSubview:datePicker];
        }
        
        
        UITapGestureRecognizer *singleFingerDatePicker  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleFingerDatePickerHidden:)];
        singleFingerDatePicker.numberOfTouchesRequired = 1;
        singleFingerDatePicker.numberOfTapsRequired = 1;
        [self.viewDatePickerBg addGestureRecognizer:singleFingerDatePicker];//让self.viewDatePickerBg隐藏
    }
    
    
    return self;
}

- (void)buttonClickErCiDianJi{
    if ([self.delegate respondsToSelector:@selector(eChooseViewDelegateTapRemove:)]) {
        [self.delegate eChooseViewDelegateTapRemove:self];
    }
}

- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(eChooseViewDelegateTapRemove:)]) {
        [self.delegate eChooseViewDelegateTapRemove:self];
    }
}

- (void)singleFingerDatePickerHidden:(UITapGestureRecognizer *)tap {
    self.viewDatePickerBg.hidden = true;
}


- (void)buttonClick0:(UIButton *)sender {
    NSString *string = _arrayTypeNoOrYes[sender.tag - 100];
    if ([string isEqualToString:@"NO"]) {
        string = @"YES";
    } else {
        string = @"NO";
    }
    [_arrayTypeNoOrYes replaceObjectAtIndex:(sender.tag - 100) withObject:string];
    for (int i = 0; i < _arrayTypeNoOrYes.count; i++) {
        if (i != (sender.tag-100)) {
            [_arrayTypeNoOrYes replaceObjectAtIndex:i withObject:@"NO"];
        }
    }//去掉上面的for 由单选变成多选
    for (int i = 0; i < _arrayTypeNoOrYes.count; i++) {
        UIButton *button = _arrayType[i];
        if ([_arrayTypeNoOrYes[i] isEqualToString:@"NO"]) {
            [button setTitleColor:colorRGB(32, 32, 32) forState:UIControlStateNormal];
            button.backgroundColor = colorRGB(232, 232, 232);
        }
        if ([_arrayTypeNoOrYes[i] isEqualToString:@"YES"]) {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor = self.color;
        }
    }
    if ([self.delegate respondsToSelector:@selector(eChooseViewDelegate:ButtonClick0:withArrayTypeNoOrYes:)]) {
        [self.delegate eChooseViewDelegate:self ButtonClick0:sender withArrayTypeNoOrYes:_arrayTypeNoOrYes];
    }
    
}

- (void)buttonClick1:(UIButton *)sender {
    NSString *string = _arrayStateNoOrYes[sender.tag - 100];
    if ([string isEqualToString:@"NO"]) {
        string = @"YES";
    } else {
        string = @"NO";
    }
    [_arrayStateNoOrYes replaceObjectAtIndex:(sender.tag - 100) withObject:string];
    for (int i = 0; i < _arrayStateNoOrYes.count; i++) {
        if (i != (sender.tag-100)) {
            [_arrayStateNoOrYes replaceObjectAtIndex:i withObject:@"NO"];
        }
    }//去掉上面的for 由单选变成多选
    for (int i = 0; i < _arrayStateNoOrYes.count; i++) {
        UIButton *button = _arrayState[i];
        if ([_arrayStateNoOrYes[i] isEqualToString:@"NO"]) {
            [button setTitleColor:colorRGB(32, 32, 32) forState:UIControlStateNormal];
            button.backgroundColor = colorRGB(232, 232, 232);
        }
        if ([_arrayStateNoOrYes[i] isEqualToString:@"YES"]) {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor = self.color;
        }
    }
    if ([self.delegate respondsToSelector:@selector(eChooseViewDelegateButtonClick1:withArrayStateNoOrYes:)]) {
        [self.delegate eChooseViewDelegateButtonClick1:sender withArrayStateNoOrYes:_arrayStateNoOrYes];
    }
}

#pragma mark 所属项目
- (void)textFieldSuoShuXiangMu:(UITextField *)sender {
    _strSuoShuXiangMu = sender.text;
}

#pragma mark 供应商
- (void)textFieldGongYinShang:(UITextField *)sender {
    _strGongYingShang = sender.text;
}

- (void)textFieldClick2:(UITextField *)sender {
    NSLog(@"%s",__FUNCTION__);
    self.viewDatePickerBg.hidden = NO;
    UIDatePicker *datePicker0 = [self.viewDatePickerBg viewWithTag:10];
    UIDatePicker *datePicker1 = [self.viewDatePickerBg viewWithTag:11];
    if (sender.tag == 10) {
        datePicker0.hidden = false;
        datePicker1.hidden = true;
    } else if (sender.tag == 11) {
        datePicker0.hidden = true;
        datePicker1.hidden = false;
    }
}

- (void)dateChange:(UIDatePicker *)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:sender.date];
    
    UITextField *textField = [self.viewTwo viewWithTag:sender.tag];
    textField.text = [[dateString componentsSeparatedByString:@" "] firstObject];
    
    if (sender.tag == 10) {
        _time0 = dateString;
    } else if (sender.tag == 11) {
        _time1 = dateString;
    }
}

- (void)buttonClick3:(UIButton *)sender {
    if (sender.tag == 300) {
        for (int i = 0; i < _arrayType.count; i++) {
            UIButton *but = _arrayType[i];
            [but setTitleColor:colorRGB(32, 32, 32) forState:UIControlStateNormal];
            but.backgroundColor = colorRGB(232, 232, 232);
        }
        for (int i = 0; i < _arrayState.count; i++) {
            UIButton *but = _arrayState[i];
            [but setTitleColor:colorRGB(32, 32, 32) forState:UIControlStateNormal];
            but.backgroundColor = colorRGB(232, 232, 232);
        }
        for (int i = 0; i < _arrayTypeNoOrYes.count; i ++) {
            NSString *string = _arrayTypeNoOrYes[i];
            if ([string isEqualToString:@"YES"]) {
                string = @"NO";
            }
            [_arrayTypeNoOrYes replaceObjectAtIndex:i withObject:string];
        }

        for (int i = 0; i < _arrayStateNoOrYes.count; i ++) {
            NSString *string = _arrayStateNoOrYes[i];
            if ([string isEqualToString:@"YES"]) {
                string = @"NO";
            }
            [_arrayStateNoOrYes replaceObjectAtIndex:i withObject:string];
        }
        
        UITextField *textField0 = [self.viewTwo viewWithTag:10];
        textField0.text = nil;
        UITextField *textField1 = [self.viewTwo viewWithTag:11];
        textField1.text = nil;
        UIDatePicker *datePicker0 = [self.viewDatePickerBg viewWithTag:10];
        datePicker0.date = [NSDate date];
        UIDatePicker *datePicker1 = [self.viewDatePickerBg viewWithTag:11];
        datePicker1.date = [NSDate date];
        _time0 = nil;
        _time1 = nil;
        
        UITextField *textFieldOn1 = [self.viewOn1 viewWithTag:10];
        textFieldOn1.text = nil;
        UITextField *textFieldOn2 = [self.viewOn1 viewWithTag:11];
        textFieldOn2.text = nil;
        _strSuoShuXiangMu = nil;
        _strGongYingShang = nil;
    }
    if ([self.delegate respondsToSelector:@selector(eChooseViewDelegate:ButtonClick3:withArrayTypeNoOrYes:withArrayStateNoOrYes:withwithTime0:withTime1:wihtstrSuoShuXiangMu:withstrGongYingShang:)]) {
        [self.delegate eChooseViewDelegate:self ButtonClick3:sender withArrayTypeNoOrYes:_arrayTypeNoOrYes withArrayStateNoOrYes:_arrayStateNoOrYes withwithTime0:_time0 withTime1:_time1 wihtstrSuoShuXiangMu:_strSuoShuXiangMu withstrGongYingShang:_strGongYingShang];
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
