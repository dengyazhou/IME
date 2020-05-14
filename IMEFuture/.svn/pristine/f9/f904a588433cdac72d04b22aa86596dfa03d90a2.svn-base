//
//  EChooseTaxRateView.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/11/21.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "EChooseTaxRateView.h"

#import "Header.h"

@interface EChooseTaxRateView () <UIGestureRecognizerDelegate>{
    UIView *_viewWhiteBG;
    UIView *_view0;
    UIView *_view1;
    NSMutableArray *_arrayButton;
    
}

@end

@implementation EChooseTaxRateView

- (instancetype)initWithFrame:(CGRect)frame withImageName0:(NSString *)name0 withImageName1:(NSString *)name1
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
        
        _viewWhiteBG = [[UIView alloc] initWithFrame:CGRectMake(10, 74, kMainW - 10*2, kMainH - 74*2)];
        _viewWhiteBG.backgroundColor = [UIColor whiteColor];
        _viewWhiteBG.layer.cornerRadius = 10;
        _viewWhiteBG.clipsToBounds = YES;
        [self addSubview:_viewWhiteBG];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_viewWhiteBG.frame), 50)];
        label.text = @"企业增值税资质";
        label.textColor = colorRGB(0, 168, 255);
        label.textAlignment = NSTextAlignmentCenter;
        [_viewWhiteBG addSubview:label];
        
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, CGRectGetWidth(_viewWhiteBG.frame), 0.5)];
        viewLine.backgroundColor = colorRGB(221, 221, 221);
        [_viewWhiteBG addSubview:viewLine];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((CGRectGetWidth(_viewWhiteBG.frame)-130)/2, CGRectGetHeight(_viewWhiteBG.frame) - 60, 130, 40);
        button.backgroundColor = colorRGB(0, 168, 255);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"确认" forState:UIControlStateNormal];
        button.tag = 0;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_viewWhiteBG addSubview:button];
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), CGRectGetWidth(_viewWhiteBG.frame), CGRectGetHeight(_viewWhiteBG.frame) - CGRectGetHeight(label.frame) - 70)];
        [_viewWhiteBG addSubview:scrollView];
        
        _view0 = [[UIView alloc] init];
        [scrollView addSubview:_view0];
        
        UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
        button0.frame = CGRectMake(5, 5, 35, 35);
        [button0 setImage:[UIImage imageNamed:name0] forState:UIControlStateNormal];
        [button0 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button0.tag = 1;
        [_view0 addSubview:button0];
        
        NSString *string00 = @"我司为增值税一般纳税人，税率为13%";
        CGSize size00 = [string00 boundingRectWithSize:CGSizeMake(CGRectGetWidth(_viewWhiteBG.frame)-CGRectGetMaxX(button0.frame) - 5*2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        UILabel *label00 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button0.frame)+5, 14, CGRectGetWidth(_viewWhiteBG.frame)-CGRectGetMaxX(button0.frame) - 5*2, size00.height)];
        label00.text = string00;
        label00.numberOfLines = 0;
        [_view0 addSubview:label00];
        
        NSString *string01 = @"已阅读并同意以下约定";
        CGSize size01 = [string01 boundingRectWithSize:CGSizeMake(CGRectGetWidth(label00.frame), 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        UILabel *label01 = [[UILabel alloc] initWithFrame:CGRectMake(label00.frame.origin.x, CGRectGetMaxY(label00.frame)+5, CGRectGetWidth(label00.frame), size01.height)];
        label01.text = string01;
        label01.textColor = colorRGB(117, 117, 117);
        label01.numberOfLines = 0;
        label01.font = [UIFont systemFontOfSize:14];
        [_view0 addSubview:label01];
        
        NSString *string02 = @"平台采购商均为增值税一般纳税人，根据平台交易规则，默认供应商报价含13%增值税。我司与平台对账完成后，承诺按《采购协议》约定期限内向平台提供税率为13%的增值税专用发票";
        CGSize size02 = [string02 boundingRectWithSize:CGSizeMake(CGRectGetWidth(label01.frame), 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        UILabel *label02 = [[UILabel alloc] initWithFrame:CGRectMake(label01.frame.origin.x, CGRectGetMaxY(label01.frame)+5, CGRectGetWidth(label01.frame), size02.height)];
        label02.text = string02;
        label02.textColor = colorRGB(117, 117, 117);
        label02.numberOfLines = 0;
        label02.font = [UIFont systemFontOfSize:14];
        [_view0 addSubview:label02];
        _view0.frame = CGRectMake(0, 0, CGRectGetWidth(_viewWhiteBG.frame), CGRectGetMaxY(label02.frame)+15);
        
                                       
        _view1 = [[UIView alloc] init];
        [scrollView addSubview:_view1];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(5, 5, 35, 35);
        [button1 setImage:[UIImage imageNamed:name1] forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button1.tag = 2;
        [_view1 addSubview:button1];
        
        NSString *string10 = @"我司为增值税小规模纳税人，征收率为3%";
        CGSize size10 = [string10 boundingRectWithSize:CGSizeMake(CGRectGetWidth(_viewWhiteBG.frame)-CGRectGetMaxX(button1.frame) - 5*2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        UILabel *label10 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button1.frame)+5, 14, CGRectGetWidth(_viewWhiteBG.frame)-CGRectGetMaxX(button1.frame) - 5*2, size10.height)];
        label10.text = string10;
        label10.numberOfLines = 0;
        [_view1 addSubview:label10];
        
        NSString *string11 = @"已阅读并同意以下约定";
        CGSize size11 = [string11 boundingRectWithSize:CGSizeMake(CGRectGetWidth(label10.frame), 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        UILabel *label11 = [[UILabel alloc] initWithFrame:CGRectMake(label10.frame.origin.x, CGRectGetMaxY(label10.frame)+5, CGRectGetWidth(label10.frame), size11.height)];
        label11.text = string11;
        label11.textColor = colorRGB(117, 117, 117);
        label11.numberOfLines = 0;
        label11.font = [UIFont systemFontOfSize:14];
        [_view1 addSubview:label11];
        
        NSString *string12 = @"平台采购商均为增值税一般纳税人，根据平台交易规则，默认供应商报价含13%增值税。";
        CGSize size12 = [string12 boundingRectWithSize:CGSizeMake(CGRectGetWidth(label11.frame), 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        UILabel *label12 = [[UILabel alloc] initWithFrame:CGRectMake(label11.frame.origin.x, CGRectGetMaxY(label11.frame)+5, CGRectGetWidth(label11.frame), size12.height)];
        label12.text = string12;
        label12.textColor = colorRGB(117, 117, 117);
        label12.numberOfLines = 0;
        label12.font = [UIFont systemFontOfSize:14];
        [_view1 addSubview:label12];
        
        NSString *string13 = @"1. 鉴于我司为增值税小规模纳税人，因报价未符合以上规则，导致不含税货款金额增加，我司同意按原合同含税总价的86.5%优惠价与平台结算货款";
        CGSize size13 = [string13 boundingRectWithSize:CGSizeMake(CGRectGetWidth(label12.frame), 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        UILabel *label13 = [[UILabel alloc] initWithFrame:CGRectMake(label12.frame.origin.x, CGRectGetMaxY(label12.frame)+5, CGRectGetWidth(label12.frame), size13.height)];
        label13.text = string13;
        label13.textColor = colorRGB(117, 117, 117);
        label13.numberOfLines = 0;
        label13.font = [UIFont systemFontOfSize:14];
        [_view1 addSubview:label13];
        
        NSString *string14 = @"2. 我司与平台对账完成后，承诺按《采购协议》约定期限内向平台提供增值税专用发票。（小规模纳税人需向主管税务机关申请代开增值税专用发票）";
        CGSize size14 = [string14 boundingRectWithSize:CGSizeMake(CGRectGetWidth(label13.frame), 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        UILabel *label14 = [[UILabel alloc] initWithFrame:CGRectMake(label13.frame.origin.x, CGRectGetMaxY(label13.frame)+5, CGRectGetWidth(label13.frame), size14.height)];
        label14.text = string14;
        label14.textColor = colorRGB(117, 117, 117);
        label14.numberOfLines = 0;
        label14.font = [UIFont systemFontOfSize:14];
        [_view1 addSubview:label14];
        _view1.frame = CGRectMake(0, CGRectGetMaxY(_view0.frame), CGRectGetWidth(_viewWhiteBG.frame), CGRectGetMaxY(label14.frame)+15);
        
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame), CGRectGetMaxY(_view1.frame));
        
        
        _arrayButton = [[NSMutableArray alloc] initWithObjects:button0,button1, nil];
        
        UITapGestureRecognizer *singleFingerOne  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
        singleFingerOne.numberOfTouchesRequired = 1;
        singleFingerOne.numberOfTapsRequired = 1;
        singleFingerOne.delegate = self;
        [self addGestureRecognizer:singleFingerOne];
        
    }
    return self;
}

- (void)buttonClick:(UIButton *)sender {
    if (sender.tag == 0) {
        
    } else {
        if (sender.tag == 1) {
            [sender setImage:[UIImage imageNamed:@"label_circle_2t"] forState:UIControlStateNormal];
            UIButton *button = _arrayButton[1];
            [button setImage:[UIImage imageNamed:@"label_circle"] forState:UIControlStateNormal];
        }
        if (sender.tag == 2) {
            [sender setImage:[UIImage imageNamed:@"label_circle_2t"] forState:UIControlStateNormal];
            UIButton *button = _arrayButton[0];
            [button setImage:[UIImage imageNamed:@"label_circle"] forState:UIControlStateNormal];
        }
    }
    if ([self.delegate respondsToSelector:@selector(eChooseTaxRateViewButton:)]) {
        [self.delegate eChooseTaxRateViewButton:sender];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:_viewWhiteBG]) {
        return NO;
    }
    return YES;
}

- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(eChooseTaxRateViewTapSelector)]) {
        [self.delegate eChooseTaxRateViewTapSelector];
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
