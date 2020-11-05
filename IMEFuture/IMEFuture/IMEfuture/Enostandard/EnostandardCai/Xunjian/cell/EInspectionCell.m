//
//  EInspectionCell.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/11/3.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "EInspectionCell.h"

@implementation EInspectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.viewBg.clipsToBounds = YES;
    self.viewBg.layer.cornerRadius = 5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
