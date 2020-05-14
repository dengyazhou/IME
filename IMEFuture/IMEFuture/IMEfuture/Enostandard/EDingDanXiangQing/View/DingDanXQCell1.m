//
//  DingDanXQCell1.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/6/5.
//  Copyright © 2019 Netease. All rights reserved.
//

#import "DingDanXQCell1.h"

@interface DingDanXQCell1 ()

@property (weak, nonatomic) IBOutlet UILabel *label0;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;


@end

@implementation DingDanXQCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)initData:(TradeOrderItem *)tradeOrderItem with:(NSIndexPath *)indexPath {
    self.label0.text = [NSString stringWithFormat:@"%ld、%@",indexPath.row+1,tradeOrderItem.partNumber!=nil?tradeOrderItem.partNumber:@""];//零件号
    self.label1.text = [NSString stringWithFormat:@"交货日期：%@",tradeOrderItem.deliveryTime];//交货日期
    self.label2.text = [NSString stringWithFormat:@"采购数量：%@",tradeOrderItem.num.stringValue];//采购数量
    self.label3.text = [NSString stringWithFormat:@"发货数量：%@",tradeOrderItem.deliverNum.stringValue];//已发货数量
    self.label4.text = [NSString stringWithFormat:@"收货数量：%@",tradeOrderItem.receiveNum.stringValue];//已收货数量
    self.label5.text = [NSString stringWithFormat:@"入库数量：%@",tradeOrderItem.warehouseNum.stringValue];//入库数量
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
