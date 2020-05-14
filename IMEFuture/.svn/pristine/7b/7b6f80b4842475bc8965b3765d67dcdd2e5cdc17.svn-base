//
//  ChaKanYuanYinCell2.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/5.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "ChaKanYuanYinCell2.h"

@interface ChaKanYuanYinCell2 ()
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;

@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;
@property (weak, nonatomic) IBOutlet UILabel *label9;
@property (weak, nonatomic) IBOutlet UILabel *label10;
@property (weak, nonatomic) IBOutlet UILabel *label11;

@end

@implementation ChaKanYuanYinCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)initDataTradeOrderItem:(TradeOrderItem *)tradeOrderItem withNSIndexPath:(NSIndexPath *)indexPath {
    
    self.label0.text = [NSString stringWithFormat:@"%ld、%@",indexPath.row+1,tradeOrderItem.partNumber];
    self.label1.text = [NSString stringWithFormat:@"交货日期：%@",tradeOrderItem.deliveryTime];
    self.label2.text = [NSString stringWithFormat:@"采购数量：%@",tradeOrderItem.num.stringValue];
    self.label3.text = [NSString stringWithFormat:@"单位：%@",tradeOrderItem.quantityUnit];
    self.label4.text = [NSString stringWithFormat:@"未税核算价：%@",@""];
    self.label5.text = [NSString stringWithFormat:@"零件名：%@",tradeOrderItem.partName!=nil?tradeOrderItem.partName:@""];
    
    
    self.label6.text = tradeOrderItem.price.stringValue;
    self.label7.text = tradeOrderItem.supplierPrice.stringValue;
    
    self.label8.text = tradeOrderItem.subTotalPrice.stringValue;
    self.label9.text = tradeOrderItem.subTotalSupplierPrice.stringValue;
    
    self.label10.text = tradeOrderItem.partRemark;
    self.label11.text = tradeOrderItem.supplierPartRemark;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
