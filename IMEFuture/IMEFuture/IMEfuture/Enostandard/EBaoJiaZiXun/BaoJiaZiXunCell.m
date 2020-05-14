//
//  BaoJiaZiXunCell.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/5.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaoJiaZiXunCell.h"
#import "Header.h"

@implementation BaoJiaZiXunCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.buttonHuida.layer.borderColor = colorRGB(255, 132, 0).CGColor;
    self.buttonHuida.layer.borderWidth = 1;
    self.buttonHuida.layer.cornerRadius = 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
