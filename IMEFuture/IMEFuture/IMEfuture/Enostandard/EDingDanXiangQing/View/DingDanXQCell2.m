//
//  DingDanXQCell2.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/6/5.
//  Copyright © 2019 Netease. All rights reserved.
//

#import "DingDanXQCell2.h"
#import "GlobalSettingManager.h"

@interface DingDanXQCell2 ()

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end

@implementation DingDanXQCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)initDate:(TradeOrder *)tradeOrder withColor:(UIColor *)color {
    self.label1.textColor = color;
    self.label2.textColor = color;
    
    if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:117]]) {
        self.label2.text = @"****";
    } else {
        self.label2.text = tradeOrder.totalPrice.stringValue;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
