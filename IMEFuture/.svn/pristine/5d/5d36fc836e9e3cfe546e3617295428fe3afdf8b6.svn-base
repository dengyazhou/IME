//
//  PartDetailsView.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/14.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "PartDetailsView.h"
#import "NSString+Enumeration.h"

@interface PartDetailsView ()

@property (weak, nonatomic) IBOutlet UILabel *labelpartName;
@property (weak, nonatomic) IBOutlet UILabel *labelbrand;
@property (weak, nonatomic) IBOutlet UILabel *labelmaterialDescription;
@property (weak, nonatomic) IBOutlet UILabel *labelownProjectName;
@property (weak, nonatomic) IBOutlet UILabel *labelinquiryCode;
@property (weak, nonatomic) IBOutlet UILabel *labelorderCode;
@property (weak, nonatomic) IBOutlet UILabel *labelquantityUnitDesc;
@property (weak, nonatomic) IBOutlet UILabel *labeldeliveryTime;
@property (weak, nonatomic) IBOutlet UILabel *labelpurchaseGroup;


@end

@implementation PartDetailsView

- (void)initData:(PurchaseOrderResBean *)model {
    self.labelpartName.text = model.partName;
    self.labelbrand.text = model.brand;
    self.labelmaterialDescription.text = model.materialDescription;
    self.labelownProjectName.text = model.ownProjectName;
    self.labelinquiryCode.text = model.inquiryCode;
    self.labelorderCode.text = model.orderCode;
    self.labelquantityUnitDesc.text = model.quantityUnitDesc;
    self.labeldeliveryTime.text = model.deliveryTime;
    self.labelpurchaseGroup.text = model.purchaseGroup;
}

- (void)initDataIsDeliverOrderItemBean:(DeliverOrderItemBean *)model {
    self.labelpartName.text = model.partName;
    self.labelbrand.text = model.brand;
    self.labelmaterialDescription.text = model.materialDescription;
    self.labelownProjectName.text = model.ownProjectName;
    self.labelinquiryCode.text = model.inquiryCode;
    self.labelorderCode.text = model.orderCode;
//    self.labelquantityUnitDesc.text = model.quantityUnitDesc;
    self.labelquantityUnitDesc.text = [NSString QuantityUnit:model.quantityUnit];
    self.labeldeliveryTime.text = model.deliveryTime;
    self.labelpurchaseGroup.text = model.purchaseGroup;
}

- (IBAction)back:(id)sender {
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
