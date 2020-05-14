//
//  TemporaryTaskDetailedListCell.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/18.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "TemporaryTaskDetailedListCell.h"

@implementation TemporaryTaskDetailedListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.viewBg.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
