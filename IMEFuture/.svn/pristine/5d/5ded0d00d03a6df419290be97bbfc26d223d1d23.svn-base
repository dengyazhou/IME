//
//  ShaiXuanBaoJiaCell0.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/5.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ShaiXuanBaoJiaCell0.h"
#import "NSArray+Transition.h"


@implementation ShaiXuanBaoJiaCell0

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
    
    self.partType.text = [NSString stringWithFormat:@"零件类型：%@",[NSString PartType:inquiryOrder.partType]];
    
    self.processType.text = [NSString stringWithFormat:@"加工类型：%@",[NSString ProcessType:inquiryOrder.processType]];
    
    self.isQuotationTemplate.text = [NSString stringWithFormat:@"报价方式：%@",[inquiryOrder.isQuotationTemplate integerValue] == 1?@"零件明细":@"零件总价"];
                                    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
