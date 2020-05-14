//
//  FaHuoCell090500.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/14.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "FaHuoCell090500.h"

@implementation FaHuoCell090500

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(DeliverOrderDetailBean *)model {
    _model = model;
    self.textFieldLianLuoRen.text = model.deliveryContact;
    self.textFieldLianLuoDianHua.text = model.deliveryPhone;
    self.textFieldLianLuoChePaiHao.text = model.license;
}

- (IBAction)textLianLuoRen:(UITextField *)sender {
    _model.deliveryContact = sender.text;
}
- (IBAction)textLianLuoDianHua:(UITextField *)sender {
    _model.deliveryPhone = sender.text;
}
- (IBAction)textLianLuoChePaiHao:(UITextField *)sender {
    _model.license = sender.text;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
