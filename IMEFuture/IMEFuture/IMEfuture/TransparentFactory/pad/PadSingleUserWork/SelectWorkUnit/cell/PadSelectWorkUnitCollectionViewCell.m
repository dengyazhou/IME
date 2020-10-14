//
//  PadSelectWorkUnitCollectionViewCell.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/8/7.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "PadSelectWorkUnitCollectionViewCell.h"

@implementation PadSelectWorkUnitCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.layer.cornerRadius = 1.48;
    self.clipsToBounds = true;
}

@end
