//
//  YanHuoCell090101.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/15.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "YanHuoCell090101.h"

#import "NSString+Enumeration.h"

@interface YanHuoCell090101 ()

@property (weak, nonatomic) IBOutlet UILabel *labelSupplierEpName;
@property (weak, nonatomic) IBOutlet UILabel *labelReceiveCode;
@property (weak, nonatomic) IBOutlet UILabel *labelReceiveTime;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliverCode;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliveryTime;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliverNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliveryMethods;
@property (weak, nonatomic) IBOutlet UILabel *labelLogisticsCompanyKey;
@property (weak, nonatomic) IBOutlet UILabel *labellogisticsNo;
@property (weak, nonatomic) IBOutlet UILabel *labelremark;


@end

@implementation YanHuoCell090101

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
    self.labelDeliverNumber.text = model.deliverNumber;
    self.labelDeliveryMethods.text = [NSString DeliveryMethod:model.deliveryMethods];
    self.labelLogisticsCompanyKey.text = [NSString LogisticsEnum:model.logisticsCompanyKey];
    self.labellogisticsNo.text = model.logisticsNo;
    self.labelremark.text = model.remark!=nil?model.remark:@" ";
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
