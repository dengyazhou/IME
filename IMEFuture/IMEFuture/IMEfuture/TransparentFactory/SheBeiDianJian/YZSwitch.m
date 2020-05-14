//
//  YZSwitch.m
//  UISwitch文字
//
//  Created by 邓亚洲 on 2018/8/6.
//  Copyright © 2018年 邓亚洲. All rights reserved.
//

#import "YZSwitch.h"

#define colorRGB(_R_,_G_,_B_) [UIColor colorWithRed:_R_/255.0 green:_G_/255.0 blue:_B_/255.0 alpha:1]

@interface YZSwitch () {
    UIView *_moveView;
    UILabel *_labelLeft;
    UILabel *_labelRight;
}

@property (nonatomic,assign) int type;
@property (nonatomic,copy) void(^callBack)(int type);

@end

@implementation YZSwitch


- (instancetype)initWithFrame:(CGRect)frame withInt:(int)type returnInt:(void(^)(int type1))callBack{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;//0:异常 1:通过
        self.callBack = callBack;
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = 14;
        self.layer.borderColor = colorRGB(221, 221, 221).CGColor;
        
        UIView *moveView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, (self.bounds.size.width-4)/2.0, self.bounds.size.height-4)];
        moveView.backgroundColor = colorRGB(245, 47, 61);
        moveView.layer.cornerRadius = 12;
        [self addSubview:moveView];
        _moveView = moveView;
        
        UILabel *labelLeft = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, (self.bounds.size.width-4)/2.0, self.bounds.size.height)];
        labelLeft.text = @"异常";
        labelLeft.font = [UIFont systemFontOfSize:12];
        labelLeft.textColor = colorRGB(204, 204, 204);
        labelLeft.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labelLeft];
        _labelLeft = labelLeft;
        
        UILabel *labelRight = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(labelLeft.frame), 0, (self.bounds.size.width-4)/2.0, self.bounds.size.height)];
        labelRight.text = @"通过";
        labelRight.font = [UIFont systemFontOfSize:12];
        labelRight.textColor = colorRGB(204, 204, 204);
        labelRight.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labelRight];
        _labelRight = labelRight;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        if (self.type == 0) {
            _labelLeft.textColor = [UIColor whiteColor];
        } else if (self.type == 1) {
            _labelRight.textColor = [UIColor whiteColor];
            _moveView.frame = CGRectMake(CGRectGetMaxX(_labelLeft.frame), 2, (self.bounds.size.width-4)/2.0, self.bounds.size.height-4);
            _moveView.backgroundColor = colorRGB(0, 121, 253);
        }
        
    }
    return self;
}

- (void)buttonClick:(UIButton *)sender {
    if (self.type == 0) {
        [UIView animateWithDuration:0.2 animations:^{
            self->_labelLeft.textColor = colorRGB(204, 204, 204);
            self->_moveView.frame = CGRectMake(CGRectGetMaxX(self->_labelLeft.frame), 2, (self.bounds.size.width-4)/2.0, self.bounds.size.height-4);
        } completion:^(BOOL finished) {
            self->_labelRight.textColor = [UIColor whiteColor];
            self->_moveView.backgroundColor = colorRGB(0, 121, 253);//绿
            self.type = 1;
            self.callBack(self.type);
        }];
    } else if (self.type == 1) {
        [UIView animateWithDuration:0.2 animations:^{
            self->_labelRight.textColor = colorRGB(204, 204, 204);
            self->_moveView.frame = CGRectMake(2, 2, (self.bounds.size.width-4)/2.0, self.bounds.size.height-4);
        } completion:^(BOOL finished) {
            self->_labelLeft.textColor = [UIColor whiteColor];
            self->_moveView.backgroundColor = colorRGB(245, 47, 61);//红
            self.type = 0;
            self.callBack(self.type);
        }];
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
