//
//  PadProductionWorkCollectionViewCell.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/8/7.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "PadProductionWorkCollectionViewCell.h"

@implementation PadProductionWorkCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.layer.cornerRadius = 5;
    self.clipsToBounds = true;
    
    self.button0.layer.cornerRadius = 1.5;
}

@end
