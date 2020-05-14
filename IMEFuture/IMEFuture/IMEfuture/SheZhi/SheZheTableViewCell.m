//
//  SheZheTableViewCell.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/10/24.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "SheZheTableViewCell.h"

@implementation SheZheTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageHeader.layer.cornerRadius = 18;
    self.imageHeader.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
