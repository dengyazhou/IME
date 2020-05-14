//
//  YanHuoCell0900.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/15.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "YanHuoCell0900.h"

@implementation YanHuoCell0900

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)buttonInspectTime:(id)sender {
    if (self.buttonInspectTime) {
        self.buttonInspectTime();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
