//
//  ShouHuoDetailCell0900.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/15.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "ShouHuoDetailCell0900.h"


@interface ShouHuoDetailCell0900 ()

@property (weak, nonatomic) IBOutlet UILabel *labelSupplierEpName;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliverCode;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliverNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliveryTime;
@property (weak, nonatomic) IBOutlet UILabel *labelReceiveCode;
@property (weak, nonatomic) IBOutlet UILabel *labelReceiveTime;


@end

@implementation ShouHuoDetailCell0900

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ReceiveBean *)model {
    self.labelSupplierEpName.text = model.deliverOrder.supplierEpName;
    self.labelDeliverCode.text = model.deliverOrder.deliverCode;
    self.labelDeliverNumber.text = model.deliverOrder.deliverNumber;
    self.labelDeliveryTime.text = model.deliverOrder.deliveryTime;
    self.labelReceiveCode.text = model.receiveCode;
    self.labelReceiveTime.text = model.receiveTime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
