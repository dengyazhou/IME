//
//  ShouHuooDetailCell0903.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/15.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "ShouHuooDetailCell0903.h"

@interface ShouHuooDetailCell0903 ()

@property (weak, nonatomic) IBOutlet UILabel *labelPartNumber;
@property (weak, nonatomic) IBOutlet UILabel *labeldeliverNum;
@property (weak, nonatomic) IBOutlet UILabel *labelreceiveNum;
@property (weak, nonatomic) IBOutlet UILabel *labelinitReceiveNum;
@property (weak, nonatomic) IBOutlet UILabel *labelreceivingArea;
@property (weak, nonatomic) IBOutlet UILabel *labelreceiveRemark;
@end

@implementation ShouHuooDetailCell0903

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ReceiveItemBean *)model {
    
    
    self.labelreceiveNum.text = model.receiveNum.stringValue;
    self.labelinitReceiveNum.text = model.DYZinitReceiveNum.stringValue;
    self.labelreceivingArea.text = [NSString stringWithFormat:@"收货地址：%@",model.receivingArea!=nil?model.receivingArea:@"--"];
    self.labelreceiveRemark.text = [NSString stringWithFormat:@"收货备注：%@",model.receiveRemark!=nil?model.receiveRemark:@"--"];
    
}

- (void)setModel1:(DeliverOrderItemBean *)model1 {
    self.labelPartNumber.text = [NSString stringWithFormat:@"零件号/规格：%@",model1.partNumber!=nil?model1.partNumber:@"--"];
    self.labeldeliverNum.text = model1.deliverNum.stringValue;
}

- (IBAction)buttonClickPartDetail:(id)sender {
    if (self.buttonPartDetailCallBack) {
        self.buttonPartDetailCallBack();
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
