//
//  YunShuShouHuoCell.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/8.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "YunShuShouHuoCell.h"

@implementation YunShuShouHuoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.ViewWhiteBG.layer.cornerRadius = 5;
    self.ViewWhiteBG.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
