//
//  FaHuoLieBiaoCell09.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/14.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "FaHuoLieBiaoCell09.h"



@interface FaHuoLieBiaoCell09 ()

@property (weak, nonatomic) IBOutlet UIView *viewBg;


@end

@implementation FaHuoLieBiaoCell09

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.viewBg.layer.cornerRadius = 4;
    self.viewBg.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.viewBg.layer.shadowColor = [UIColor redColor].CGColor;
    self.viewBg.layer.shadowOffset = CGSizeMake(0, 2);
    self.viewBg.layer.shadowRadius = 4;
    self.viewBg.layer.shadowOpacity = 0.05;
//    self.viewBg.layer.shadowOpacity = 1;
    
}

- (void)setModel:(PurchaseOrderResBean *)model {
    self.labelPartNumber.text = [NSString stringWithFormat:@"零件号 %@",model.partNumber!=nil?model.partNumber:@"--"];
    
    self.labelMaterialNumber.text = [NSString stringWithFormat:@"物料号 %@",model.materialNumber!=nil?model.materialNumber:@"--"];
    self.labelNum.text = model.waitDeliverNum.stringValue;
    self.labelWaitReissueNum.text = model.waitReissueNum.stringValue;
    self.labelDeliverNum.text = model.deliverNum.stringValue;
    self.labelReceiveNum.text = model.receiveNum.stringValue;
    self.labelDefectiveNum.text = model.defectiveNum.stringValue;
    self.labelWarehouseNum.text = model.warehouseNum.stringValue;
    if (model.waitDeliverNum.integerValue == 0) {
        self.imageViewSelect.image = [UIImage imageNamed:@"Unchecked1"];
    } else {
        if (model.selectDYZ.integerValue == 0) {
            self.imageViewSelect.image = [UIImage imageNamed:@"Unchecked"];
        } else if (model.selectDYZ.integerValue == 1) {
            self.imageViewSelect.image = [UIImage imageNamed:@"selection"];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
