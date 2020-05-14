//
//  ECSScreenView.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/7/2.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "ECSScreenView.h"

#import "Header.h"

#import "TGSupplierTag.h"



@interface ECSScreenView () {
    BOOL _isOpen;
    CGFloat _heightView1;
    NSInteger _labelTag;
    
    UITextField *_textField2;//公司名
    UITextField *_textField3;//地区
    
    
    CGFloat _height_NavBar;
}

@property (nonatomic,strong) UIView *view0;//选择标签
@property (nonatomic,strong) UIScrollView *view1;//标签
@property (nonatomic,strong) UIView *view2;//请输入公司名称
@property (nonatomic,strong) UIView *view3;//地区
@property (nonatomic,strong) UIView *view4;//重置 完成



@property (nonatomic,strong) NSMutableArray *arrayLabel;

@property (nonatomic,strong) NSMutableArray *arrayTGSupplierTag;

@end

@implementation ECSScreenView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pickerViewBGNotificationTextField3" object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (instancetype)initWithFrame:(CGRect)frame withArrayTGSupplierTag:(NSMutableArray *)arrayTGSupplierTag
{
    self = [super initWithFrame:frame];
    if (self) {
        _height_NavBar = Height_NavBar;
        
        self.backgroundColor = [UIColor clearColor];
        self.arrayTGSupplierTag = arrayTGSupplierTag;
        _isOpen = NO;
        _labelTag = 20;//等于20 代表没有选择标签
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pickerViewBGNotificationTextField3:) name:@"pickerViewBGNotificationTextField3" object:nil];//PickerViewBG 通知 ECSScreenView上的_textField3改变
        
        [self addSubview:self.view0];
        [self addSubview:self.view1];
        [self addSubview:self.view2];
        [self addSubview:self.view3];
        [self addSubview:self.view4];

    
    }
    return self;
}

- (void)pickerViewBGNotificationTextField3:(NSNotification *)info {
//    NSLog(@">>>>>----%@",info);
    _textField3.text = [info valueForKey:@"object"];
}

- (UIView *)view0 {
    if (!_view0) {
        _view0 = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 0, 0)];
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"选择标签";
        label.textColor = colorRGB(153, 153, 153);
        [label sizeToFit];
        [_view0 addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kMainW-33-5, 10, 33, 33);
        [button setImage:[UIImage imageNamed:@"ime_icon_unfolded"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPullDown:) forControlEvents:UIControlEventTouchUpInside];
        [_view0 addSubview:button];
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(15, 43.5, kMainW-15*2, 0.5)];
        viewLine.backgroundColor = colorRGB(204, 204, 204);
        [_view0 addSubview:viewLine];
    }
    return _view0;
}

- (void)buttonPullDown:(UIButton *)button {
    _isOpen = !_isOpen;
    [self setNeedsLayout];
}

- (NSMutableArray *)arrayLabel {
    if (!_arrayLabel) {
        _arrayLabel = [NSMutableArray arrayWithCapacity:0];
        for (TGSupplierTag *tGSupplierTag in self.arrayTGSupplierTag) {
            [_arrayLabel addObject:tGSupplierTag.tagName];
        }
    }
    return _arrayLabel;
}

- (UIScrollView *)view1 {
    if (!_view1) {
        _view1 = [[UIScrollView alloc] init];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(0, 15, 0, 0);
        button1.backgroundColor = [UIColor redColor];
        [_view1 addSubview:button1];
        
        for (int i = 0; i < self.arrayLabel.count; i++) {
            CGSize size = [self.arrayLabel[i] boundingRectWithSize:CGSizeMake(1000, 14) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            CGFloat arrW = size.width + 30;
            CGFloat arrB = CGRectGetMaxX(button1.frame);
            if ((arrB+10+arrW+10) > kMainW) {
                //换行
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = 100 + i;
                button.frame = CGRectMake(15, CGRectGetMaxY(button1.frame)+20, arrW, 31);
                [button setTitle:self.arrayLabel[i] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                button.backgroundColor = colorRGB(241, 241, 241);
                [button setTitleColor:colorRGB(52, 52, 52) forState:UIControlStateNormal];
                button.layer.cornerRadius = 2;
                [_view1 addSubview:button];
                button1 = button;
            } else {
                //不换行
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = 100 + i;
                button.frame = CGRectMake(arrB + 15, CGRectGetMinY(button1.frame), arrW, 31);
                [button setTitle:self.arrayLabel[i] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:14];
                button.backgroundColor = colorRGB(241, 241, 241);
                [button setTitleColor:colorRGB(52, 52, 52) forState:UIControlStateNormal];
                button.layer.cornerRadius = 2;
                [_view1 addSubview:button];
                button1 = button;
            }
            [button1 addTarget:self action:@selector(buttonSelectLabel:) forControlEvents:UIControlEventTouchUpInside];
        }
        _heightView1 = CGRectGetMaxY(button1.frame)+20;
        _view1.clipsToBounds = YES;
    }
    return _view1;
}

- (void)buttonSelectLabel:(UIButton *)sender {
    if (_labelTag < 20) {
        UIButton *button = [self.view1 viewWithTag:_labelTag+100];
        button.backgroundColor = colorRGB(241, 241, 241);
        [button setTitleColor:colorRGB(52, 52, 52) forState:UIControlStateNormal];
    }
    sender.backgroundColor = colorRGB(255, 132, 0);
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _labelTag = sender.tag-100;
}

- (UIView *)view2 {
    if (!_view2) {
        _view2 = [[UIView alloc] init];
        
        UIView *viewLineTop = [[UIView alloc] initWithFrame:CGRectMake(15, 0, kMainW-15*2, 0.5)];
        viewLineTop.backgroundColor = colorRGB(204, 204, 204);
        [_view2 addSubview:viewLineTop];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 0, 0)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = colorRGB(153, 153, 153);
        label.text = @"请输入公司名";
        [label sizeToFit];
        [_view2 addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(115, 1, kMainW-115-15, 53)];
        textField.placeholder = @"请填写公司名称";
        textField.font = [UIFont systemFontOfSize:14];
        [_view2 addSubview:textField];
        _textField2 = textField;
        
        UIView *viewLineBottom = [[UIView alloc] initWithFrame:CGRectMake(15, 54.5, kMainW-15*2, 0.5)];
        viewLineBottom.backgroundColor = colorRGB(204, 204, 204);
        [_view2 addSubview:viewLineBottom];
    }
    return _view2;
}

- (UIView *)view3 {
    if (!_view3) {
        _view3 = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 0, 0)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = colorRGB(153, 153, 153);
        label.text = @"地区";
        [label sizeToFit];
        [_view3 addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(115, 1, kMainW-115-15, 53)];
        textField.placeholder = @"请选择地区";
        textField.font = [UIFont systemFontOfSize:14];
        [_view3 addSubview:textField];
        textField.inputView = [[UIView alloc] initWithFrame:CGRectZero];
        [textField addTarget:self action:@selector(textField3ShowPickView:) forControlEvents:UIControlEventEditingDidBegin];
        _textField3 = textField;
        
        UIView *viewLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 54.5, kMainW, 0.5)];
        viewLineBottom.backgroundColor = colorRGB(204, 204, 204);
        [_view3 addSubview:viewLineBottom];
    }
    return _view3;
}

- (void)textField3ShowPickView:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(eCSScreenViewDelegateShowPickerBG)]) {
        [self.delegate eCSScreenViewDelegateShowPickerBG];
    }
    [self performSelector:@selector(handleThread:) withObject:textField afterDelay:0.1];//延迟调用
}
- (void)handleThread:(UITextField *)sender {
    [sender resignFirstResponder];
}

- (UIView *)view4 {
    if (!_view4) {
        _view4 = [[UIView alloc] init];
        _view4.backgroundColor = colorRGB(241, 241, 241);
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(15, 15, (kMainW-15*2-8)/2, 40);
        button1.backgroundColor = [UIColor whiteColor];
        button1.layer.borderWidth = 0.5;
        button1.layer.borderColor = colorRGB(230, 230, 230).CGColor;
        button1.layer.cornerRadius = 2;
        button1.titleLabel.font = [UIFont systemFontOfSize:17];
        [button1 setTitle:@"重置" forState:UIControlStateNormal];
        [button1 setTitleColor:colorRGB(51, 51, 51) forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(buttonReset:) forControlEvents:UIControlEventTouchUpInside];
        [_view4 addSubview:button1];
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(CGRectGetMaxX(button1.frame)+8, 15, CGRectGetWidth(button1.frame), 40);
        button2.backgroundColor = colorRGB(255, 132, 0);
        button2.layer.cornerRadius = 2;
        button2.titleLabel.font = [UIFont systemFontOfSize:17];
        [button2 setTitle:@"完成" forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(buttonFinish:) forControlEvents:UIControlEventTouchUpInside];
        [_view4 addSubview:button2];
    }
    return _view4;
}

- (void)buttonReset:(UIButton *)sender {
    if (_labelTag < 20) {//说明已经选
        UIButton *button = [self.view1 viewWithTag:_labelTag+100];
        button.backgroundColor = colorRGB(241, 241, 241);
        [button setTitleColor:colorRGB(52, 52, 52) forState:UIControlStateNormal];
        _labelTag = 20;
    }
    [_textField2 resignFirstResponder];
    _textField2.text = nil;
    _textField3.text = nil;
}

- (void)buttonFinish:(UIButton *)sender {
    [_textField2 resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(eCSScreenViewDelegateIndex:CompanyName:Netherlands:)]) {
        [self.delegate eCSScreenViewDelegateIndex:_labelTag CompanyName:_textField2.text Netherlands:_textField3.text];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.view0.frame = CGRectMake(0, 8, kMainW, 44);
    
    if (_isOpen == YES && _heightView1 > 116) {
        if (_heightView1 > 200) {
            self.view1.frame = CGRectMake(0, CGRectGetMaxY(self.view0.frame), kMainW, 200);
            self.view1.contentSize = CGSizeMake(kMainW, _heightView1);
        } else {
            self.view1.frame = CGRectMake(0, CGRectGetMaxY(self.view0.frame), kMainW, _heightView1);
            self.view1.contentSize = CGSizeMake(kMainW, _heightView1);
        }
        
    } else {
        self.view1.frame = CGRectMake(0, CGRectGetMaxY(self.view0.frame), kMainW, 117);//最小为117
        self.view1.contentSize = CGSizeMake(kMainW, 117);
    }
    
    self.view2.frame = CGRectMake(0, CGRectGetMaxY(self.view1.frame), kMainW, 55);
    self.view3.frame = CGRectMake(0, CGRectGetMaxY(self.view2.frame), kMainW, 55);
    self.view4.frame = CGRectMake(0, CGRectGetMaxY(self.view3.frame), kMainW, 70);
    
    self.frame = CGRectMake(0, _height_NavBar, kMainW, CGRectGetMaxY(self.view4.frame));
    
    
    [self setNeedsDisplay];//为了解决重新修改self.frame 后 造成的画框小bug
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 8)];
    [path addLineToPoint:CGPointMake(kMainW-20-12, 8)];
    [path addLineToPoint:CGPointMake(kMainW-20-6, 0)];
    [path addLineToPoint:CGPointMake(kMainW-20, 8)];
    [path addLineToPoint:CGPointMake(kMainW, 8)];
    [path addLineToPoint:CGPointMake(kMainW, self.bounds.size.height)];
    [path addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [path closePath];
    
    [[UIColor whiteColor] setFill];
    [[UIColor clearColor] setStroke];
    
    [path stroke];
    [path fill];
}


@end
