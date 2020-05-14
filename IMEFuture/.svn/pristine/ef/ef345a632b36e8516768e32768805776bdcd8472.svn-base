//
//  FaHuoCell0904.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/14.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "FaHuoCell0904.h"

#import "NSString+Enumeration.h"

@implementation FaHuoCell0904

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(DeliverOrderDetailBean *)model {
    _model = model;
    self.textFieldDeliverNumber.text = model.deliverNumber;
    self.labeldeliveryTime.text = model.deliveryTime;
    self.labelexpectedArrivalTime.text = model.expectedArrivalTime;
    self.labeldeliveryMethods.text = [NSString DeliveryMethod:model.deliveryMethods];
}

- (IBAction)buttonSelectFaHuoDanHao:(UIButton *)sender {
    if (self.buttonSelectFaHuoDanHao) {
        self.buttonSelectFaHuoDanHao(sender);
    }
}
- (IBAction)textFieldSongHuoDanHuan:(UITextField *)sender {
    _model.deliverNumber = sender.text;
}

- (IBAction)buttonFaHuoRiQi:(UIButton *)sender {
    if (self.buttonSelectFaHuoRiQi) {
        self.buttonSelectFaHuoRiQi();
    }
}

- (IBAction)buttonDaoHuoRiQi:(UIButton *)sender {
    if (self.buttonSelectDaoHuoRiQi) {
        self.buttonSelectDaoHuoRiQi();
    }
}


- (IBAction)buttonFaHuoFaShi:(UIButton *)sender {
    if (self.buttonSelectSongHuoFangShi) {
        self.buttonSelectSongHuoFangShi();
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
