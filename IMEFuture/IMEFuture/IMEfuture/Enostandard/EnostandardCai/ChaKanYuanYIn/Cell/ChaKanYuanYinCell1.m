//
//  ChaKanYuanYinCell1.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/5.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "ChaKanYuanYinCell1.h"

@interface ChaKanYuanYinCell1 ()
@property (weak, nonatomic) IBOutlet UILabel *label00;
@property (weak, nonatomic) IBOutlet UILabel *label01;
@property (weak, nonatomic) IBOutlet UILabel *label02;
@property (weak, nonatomic) IBOutlet UILabel *label10;
@property (weak, nonatomic) IBOutlet UILabel *label11;
@property (weak, nonatomic) IBOutlet UILabel *label12;

@property (weak, nonatomic) IBOutlet UILabel *labelTax;


@end

@implementation ChaKanYuanYinCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTradeOrder:(TradeOrder *)tradeOrder {
    self.labelTax.text = [NSString stringWithFormat:@"含税总计 （税率%0.f%%）",tradeOrder.supplierTaxRate.doubleValue*100];
    
    double subTotalTargetPrice = 0;
    double subTotalPrice = 0;
    double subTotalSupplierPrice = 0;
    for (TradeOrderItem *item in tradeOrder.tradeOrderItems) {
        subTotalTargetPrice += item.subTotalTargetPrice.doubleValue;
        subTotalPrice += item.subTotalPrice.doubleValue;
        subTotalSupplierPrice += item.subTotalSupplierPrice.doubleValue;
    }
    self.label00.text = [NSString stringWithFormat:@"%.2f",subTotalTargetPrice];
    self.label01.text = [NSString stringWithFormat:@"%.2f",subTotalPrice];
    self.label02.text = [NSString stringWithFormat:@"%.2f",subTotalSupplierPrice];
    
    self.label10.text = [NSString stringWithFormat:@"%.2f",subTotalTargetPrice*(1+tradeOrder.supplierTaxRate.doubleValue)];
    self.label11.text = [NSString stringWithFormat:@"%.2f",subTotalPrice*(1+tradeOrder.supplierTaxRate.doubleValue)];
    self.label12.text = [NSString stringWithFormat:@"%.2f",subTotalSupplierPrice*(1+tradeOrder.supplierTaxRate.doubleValue)];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
