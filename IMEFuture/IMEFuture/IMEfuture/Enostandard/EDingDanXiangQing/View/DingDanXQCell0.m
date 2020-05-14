//
//  DingDanXQCell0.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/6/5.
//  Copyright © 2019 Netease. All rights reserved.
//

#import "DingDanXQCell0.h"

@interface DingDanXQCell0 ()

@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;

@end

@implementation DingDanXQCell0

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTradeOrder:(TradeOrder *)tradeOrder {
    _tradeOrder = tradeOrder;
    self.label0.text = tradeOrder.purchaseEnterpriseName;//采购商
    self.label1.text = tradeOrder.enterpriseOrderCode;//询盘号
    self.label2.text = tradeOrder.insideOrderCode;//订单号
    self.label3.text = tradeOrder.orderCode;//订单流水号
    self.label4.text = tradeOrder.supplierEnterpriseName;//供应商
    self.label5.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",tradeOrder.zoneId1,tradeOrder.zoneId2,tradeOrder.zoneId3,tradeOrder.name,tradeOrder.phone];//收货信息
    self.label6.text = (tradeOrder.tradeOrderRemark!=nil && ![tradeOrder.tradeOrderRemark isEqualToString:@""])?tradeOrder.tradeOrderRemark:@" ";//订单要求
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
