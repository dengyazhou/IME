//
//  YanHuoDetailCell0900.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/15.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "YanHuoDetailCell0900.h"

@interface YanHuoDetailCell0900 ()

@property (weak, nonatomic) IBOutlet UILabel *labelSupplierEpName;
@property (weak, nonatomic) IBOutlet UILabel *labelReceiveCode;
@property (weak, nonatomic) IBOutlet UILabel *labelReceiveTime;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliverCode;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliveryTime;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliverNumber;

@end

@implementation YanHuoDetailCell0900

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(InspectOrderVo *)model {
    self.labelSupplierEpName.text = model.supplierEnterpriseName;
    self.labelReceiveCode.text = model.receiveCode;
    self.labelReceiveTime.text = model.receiveTime;
    self.labelDeliverCode.text = model.deliverCode;
    self.labelDeliveryTime.text = model.deliveryTime;
    self.labelDeliverNumber.text = model.deliverNumber!=nil?model.deliverNumber:@" ";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
