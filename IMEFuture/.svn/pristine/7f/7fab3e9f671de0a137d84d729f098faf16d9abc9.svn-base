//
//  ShouHuoCell0903.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/15.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "ShouHuoCell0903.h"

@interface ShouHuoCell0903 ()



@property (weak, nonatomic) IBOutlet UILabel *labelPartNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelDeliverNum;



@end

@implementation ShouHuoCell0903

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Down"]];
    imageView.frame = CGRectMake(0, 0, 40, 0);
    imageView.contentMode = UIViewContentModeCenter;
    self.textField1.rightView = imageView;
    self.textField1.rightViewMode = UITextFieldViewModeAlways;
}

- (void)setModel:(DeliverOrderItemBean *)model {
    _model = model;
    
    self.labelPartNumber.text = [NSString stringWithFormat:@"零件号/规格：%@",model.partNumber!=nil?model.partNumber:@"--"];//model.specifications
    self.labelDeliverNum.text = [NSString stringWithFormat:@"发货数量：%@",model.deliverNum];
    self.textFieldReceiveQuantity.text = model.receiveQuantity.stringValue;
    self.textField1.text = model.receivingArea;
    self.textFieldReceiveRemark.text = model.receiveRemark;
    
}

- (IBAction)buttonOrderOtem:(id)sender {
    if (self.buttonOrderOtemCallBack) {
        self.buttonOrderOtemCallBack();
    }
}

- (IBAction)textFieldChangeReceiveQuantity:(UITextField *)sender {
    if (sender.text.integerValue > self.model.deliverNum.integerValue) {
        sender.text = self.model.deliverNum.stringValue;
    }
    if (sender.text.integerValue == 0) {
        sender.text = nil;
    }
    
    self.model.receiveQuantity = [NSNumber numberWithInteger:sender.text.integerValue];
    if (self.textFieldCallBack) {
        self.textFieldCallBack();
    }
}

- (IBAction)buttonReceiArea:(id)sender {
    if (self.buttonReceiveArea) {
        self.buttonReceiveArea();
    }
}

- (IBAction)textFieldChangeReceiveRemark:(UITextField *)sender {
    
    self.model.receiveRemark = sender.text;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
