//
//  FaHuoCell0902.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/14.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "FaHuoCell0902.h"

@implementation FaHuoCell0902

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(PurchaseOrderResBean *)model {
    _model = model;
    self.labelPartNumber.text = [NSString stringWithFormat:@"零件号/规格： %@",model.partNumber!=nil?model.partNumber:@"--"];
   
    self.labelNum.text = model.waitDeliverNum.stringValue;
    self.textField.text = model.num.stringValue;
    
}

- (IBAction)textFieldABC:(UITextField *)sender {
    if (sender.text.integerValue > self.model.waitDeliverNum.integerValue) {
        sender.text = self.model.waitDeliverNum.stringValue;
    }
    if (sender.text.integerValue == 0) {
        sender.text = nil;
    }
    
    self.model.num = [NSNumber numberWithDouble:sender.text.doubleValue];
    NSLog(@"%s>>>%@<",__FUNCTION__,self.model.num);
    if (self.textFieldCallBack) {
        self.textFieldCallBack();
    }
}


- (IBAction)buttonClick:(id)sender {
    if (self.buttonClickCallBack) {
        self.buttonClickCallBack();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
