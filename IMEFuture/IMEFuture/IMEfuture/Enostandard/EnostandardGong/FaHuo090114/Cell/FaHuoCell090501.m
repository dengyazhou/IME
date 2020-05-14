//
//  FaHuoCell090501.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/14.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "FaHuoCell090501.h"

#import "NSString+Enumeration.h"

@implementation FaHuoCell090501

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(DeliverOrderDetailBean *)model {
    _model = model;
    self.labelWuLiuGongSi.text = [NSString LogisticsEnum:model.logisticsCompanyKey];
    self.textFieldWuLiuDanHao.text = model.logisticsNo;
}

- (IBAction)textFieldWuLiuDanHao:(UITextField *)sender {
    _model.logisticsNo = sender.text;
}

- (IBAction)buttonClickWuLiuGongSi:(UIButton *)sender {
    if (self.buttonClickCallBack) {
        self.buttonClickCallBack();
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
