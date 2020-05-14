//
//  ECOrderCell122.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/1/22.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "EGOrderCell.h"

@implementation EGOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)initDataWith:(TradeOrder *)tradeOrder andQuanXian:(NSMutableArray *)arrayTypeQuanXian {
    self.button1.hidden = YES;
    self.button2.hidden = YES;
    self.button3.hidden = YES;
    self.button4.hidden = YES;
    [self.button1 setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
    self.button1.layer.borderColor = colorLine.CGColor;
    [self.button2 setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
    self.button2.layer.borderColor = colorLine.CGColor;
    [self.button3 setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
    self.button3.layer.borderColor = colorLine.CGColor;
    [self.button4 setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
    self.button4.layer.borderColor = colorLine.CGColor;
    
    self.view3.hidden = NO;
    
    self.orderCode.text = [NSString stringWithFormat:@"流水号：%@",tradeOrder.orderCode];
    
    NSArray *createTimeArr = [[[tradeOrder.createTime componentsSeparatedByString:@" "] firstObject] componentsSeparatedByString:@"-"];
    NSString *createTime = [NSString stringWithFormat:@"%@-%@-%@",createTimeArr[0],createTimeArr[1],createTimeArr[2]];
    
    self.createTime.text = [NSString stringWithFormat:@"%@",createTime];
    
    self.supplierEnterpriseName.text = tradeOrder.title;
    
    self.title.text = tradeOrder.purchaseEnterpriseName;
    
    self.deliveryDeadline.text = [NSString stringWithFormat:@"交货时间：%@",[tradeOrder.isPre integerValue] == 1?@"分批交货":[[tradeOrder.deliveryDeadline componentsSeparatedByString:@" "] firstObject]];
    
    self.count.text = [NSString stringWithFormat:@"共%ld个零件",[tradeOrder.count integerValue]];
    
    self.totalPrice.text = [NSString stringWithFormat:@"合计：%.2f",[tradeOrder.totalPrice doubleValue]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.totalPrice.text];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 3)];
    self.totalPrice.attributedText= attributedString;
    
    self.tradeOrderStatus.text = [NSString TradeOrderPurchaseStatus:tradeOrder.tradeOrderPurchaseStatus];
    
    self.label06.text = [NSString stringWithFormat:@"订单编号：%@",tradeOrder.insideOrderCode];
    
    self.imageWidth.constant = 32.5;
    if ([tradeOrder.inquiryType isEqualToString:@"COM"]) {
        self.inquiryType.hidden = YES;
    }
    if ([tradeOrder.inquiryType isEqualToString:@"DIR"]) {
        self.inquiryType.hidden = NO;
        self.inquiryType.image = [UIImage imageNamed:@"label_directional"];
    }
    if ([tradeOrder.inquiryType isEqualToString:@"ATG"]) {
        self.inquiryType.hidden = NO;
        self.inquiryType.image = [UIImage imageNamed:@"label_housekeeper"];
    }
    if ([tradeOrder.inquiryType isEqualToString:@"FTG"]) {
        self.inquiryType.hidden = NO;
        self.inquiryType.image = [UIImage imageNamed:@"label_price"];
        self.imageWidth.constant = 44.5;
    }
    if ([tradeOrder.inquiryType isEqualToString:@"TTG"]) {
        self.inquiryType.hidden = NO;
        self.inquiryType.image = [UIImage imageNamed:@"label_bargaining"];
        self.imageWidth.constant = 44.5;
    }
    
    
    if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"purchasePaid"]) {
        self.button4.hidden = NO;
        [self.button4 setTitle:@"发货" forState:UIControlStateNormal];
    } else if ([tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"WAITORDER"]) {
        self.button4.hidden = NO;
        [self.button4 setTitle:@"立即接单" forState:UIControlStateNormal];
    } else if ((![tradeOrder.partType isEqualToString:@"FWJ"]) && [tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"REFUSEDORDER"]) {
        self.button4.hidden = NO;
        [self.button4 setTitle:@"查看原因" forState:UIControlStateNormal];
    } else if ([tradeOrder.partType isEqualToString:@"FWJ"] && [tradeOrder.tradeOrderPurchaseStatus isEqualToString:@"ACCEPTFAILED"]) {
        self.button4.hidden = NO;
        [self.button4 setTitle:@"查看原因" forState:UIControlStateNormal];
    } else {
        self.button4.hidden = NO;
        [self.button4 setTitle:@"查看订单" forState:UIControlStateNormal];
    }
    
    if (self.button1.hidden == YES && self.button2.hidden == YES && self.button3.hidden == YES && self.button4.hidden == YES) {
        self.view3.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
