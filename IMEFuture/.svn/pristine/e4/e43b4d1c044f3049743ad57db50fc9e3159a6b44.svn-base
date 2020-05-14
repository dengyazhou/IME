//
//  ShouHuoDetailCell090000.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/15.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "ShouHuoDetailCell090000.h"

#import "NSString+Enumeration.h"

@interface ShouHuoDetailCell090000 ()

@property (weak, nonatomic) IBOutlet UILabel *labelSupplierEpName;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliverCode;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliverNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliveryTime;
@property (weak, nonatomic) IBOutlet UILabel *labelReceiveCode;
@property (weak, nonatomic) IBOutlet UILabel *labelReceiveTime;
@property (weak, nonatomic) IBOutlet UILabel *labelarrivalTime;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliveryMethods;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliveryContact;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliveryPhone;
@property (weak, nonatomic) IBOutlet UILabel *labellicense;
@property (weak, nonatomic) IBOutlet UILabel *labelremark;
@property (weak, nonatomic) IBOutlet UILabel *labelcreateTime;
@property (weak, nonatomic) IBOutlet UILabel *labelerpReceiveCode;


@end

@implementation ShouHuoDetailCell090000

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
    self.labelarrivalTime.text = model.arrivalTime;
    self.labelDeliveryMethods.text = [NSString DeliveryMethod:model.deliverOrder.deliveryMethods];
    self.labelDeliveryContact.text = model.deliverOrder.deliveryContact;
    self.labelDeliveryPhone.text = model.deliverOrder.deliveryPhone;
    self.labellicense.text = model.deliverOrder.license;
    self.labelremark.text = model.deliverOrder.remark!=nil?model.deliverOrder.remark:@" ";
    self.labelcreateTime.text = model.createTime;
    self.labelerpReceiveCode.text = model.erpReceiveCode!=nil?model.erpReceiveCode:@" ";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
