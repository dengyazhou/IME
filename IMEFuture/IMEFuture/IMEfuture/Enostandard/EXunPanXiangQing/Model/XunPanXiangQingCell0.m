//
//  XunPanXiangQingCell0.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/5.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "XunPanXiangQingCell0.h"
#import "NSArray+Transition.h"


@implementation XunPanXiangQingCell0

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setInquiryOrder:(InquiryOrder *)inquiryOrder {
    self.enterpriseOrderCode.text = [NSString stringWithFormat:@"询盘号：%@",inquiryOrder.enterpriseOrderCode];
    
    self.imageWidth.constant = 32.5;
    self.imageViewType.hidden = YES;
    if ([inquiryOrder.inquiryType isEqualToString:@"COM"]) {
        
    } else if ([inquiryOrder.inquiryType isEqualToString:@"DIR"]) {
        self.imageViewType.hidden = NO;
        self.imageViewType.image = [UIImage imageNamed:@"label_directional"];
    } else if ([inquiryOrder.inquiryType isEqualToString:@"ATG"]) {
        self.imageViewType.hidden = NO;
        self.imageViewType.image = [UIImage imageNamed:@"label_housekeeper"];
    } else if ([inquiryOrder.inquiryType isEqualToString:@"FTG"]) {
        self.imageViewType.hidden = NO;
        self.imageViewType.image = [UIImage imageNamed:@"label_price"];
        self.imageWidth.constant = 44.5;
    } else if ([inquiryOrder.inquiryType isEqualToString:@"TTG"]) {
        self.imageViewType.hidden = NO;
        self.imageViewType.image = [UIImage imageNamed:@"label_bargaining"];
        self.imageWidth.constant = 44.5;
    }
    
    self.status.text = [NSString InquiryOrderStatus:inquiryOrder.inquiryOrderStatus];
    
    NSArray *arrayExpectRcvTm = [[[inquiryOrder.expectRcvTm componentsSeparatedByString:@" "] firstObject] componentsSeparatedByString:@"-"];

    if ([inquiryOrder.isPre integerValue] == 1) {
        self.expectRcvTm.text = @"交货日期：分批交货";
    } else {
        self.expectRcvTm.text = [NSString stringWithFormat:@"交货日期：%@年%@月%@日",arrayExpectRcvTm[0],arrayExpectRcvTm[1],arrayExpectRcvTm[2]];
    }
    
    self.partType.text = [NSString stringWithFormat:@"零件类型：%@",[NSString PartType:inquiryOrder.partType]];
    
    self.processType.text = [NSString stringWithFormat:@"加工类型：%@",[NSString ProcessType:inquiryOrder.processType]];
    
    self.isVisiblePrice.text = [NSString stringWithFormat:@"目标价可见：%@",[inquiryOrder.isVisiblePrice integerValue]==1?@"是":@"否"];
    
    self.isQuotationTemplate.text = [NSString stringWithFormat:@"报价方式：%@",[inquiryOrder.isQuotationTemplate integerValue] == 1?@"零件明细":@"零件总价"];
    
    self.deliveryMethod.text = [NSString stringWithFormat:@"货运方式：%@",[NSString DeliveryMethod:inquiryOrder.deliveryMethod]];
    
    self.zoneStr.text = [NSString stringWithFormat:@"交货地址：%@",inquiryOrder.zoneStr];
    
    if ([inquiryOrder.inquiryType isEqualToString:@"COM"] || [inquiryOrder.inquiryType isEqualToString:@"DIR"]) {
        self.tradeOrderRemark.text = [NSString stringWithFormat:@"优选供应商：%@",inquiryOrder.supplierRemark.length != 0?inquiryOrder.supplierRemark:@"暂无"];
    }
    if ([inquiryOrder.inquiryType isEqualToString:@"ATG"] || [inquiryOrder.inquiryType isEqualToString:@"FTG"] || [inquiryOrder.inquiryType isEqualToString:@"TTG"]) {
        self.tradeOrderRemark.text = [NSString stringWithFormat:@"订单要求：%@",inquiryOrder.tradeOrderRemark.length != 0?inquiryOrder.tradeOrderRemark:@"暂无"];
    }
    
    if (inquiryOrder.isUrgent.integerValue == 1) {
        self.imageIsAllow.hidden = false;
    } else {
        self.imageIsAllow.hidden = true;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
