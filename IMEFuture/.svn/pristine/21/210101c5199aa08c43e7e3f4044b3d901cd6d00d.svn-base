//
//  YanHuoDetailCell090002.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/15.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "YanHuoDetailCell090002.h"

#import "NSString+Enumeration.h"

@interface YanHuoDetailCell090002 ()

@property (weak, nonatomic) IBOutlet UILabel *labelSupplierEpName;
@property (weak, nonatomic) IBOutlet UILabel *labelReceiveCode;
@property (weak, nonatomic) IBOutlet UILabel *labelReceiveTime;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliverCode;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliveryTime;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliverNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliveryMethods;
@property (weak, nonatomic) IBOutlet UILabel *labelSelfAddress;
@property (weak, nonatomic) IBOutlet UILabel *labelremark;
@property (weak, nonatomic) IBOutlet UILabel *labelinspectCode;
@property (weak, nonatomic) IBOutlet UILabel *labelinspectTime;
@property (weak, nonatomic) IBOutlet UILabel *labelcreateTime;
@property (weak, nonatomic) IBOutlet UILabel *labelmemberName;
@property (weak, nonatomic) IBOutlet UILabel *labelerpInspectCode;

@end

@implementation YanHuoDetailCell090002

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
    self.labelSelfAddress.text = model.selfAddress!=nil?model.selfAddress:@" ";
    self.labelremark.text = model.remark!=nil?model.remark:@" ";
    self.labelinspectCode.text = model.inspectCode;
    self.labelinspectTime.text = model.inspectTime;
    self.labelcreateTime.text = model.createTime;
    self.labelmemberName.text = model.memberName;
    self.labelerpInspectCode.text = model.erpInspectCode!=nil?model.erpInspectCode:@" ";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
