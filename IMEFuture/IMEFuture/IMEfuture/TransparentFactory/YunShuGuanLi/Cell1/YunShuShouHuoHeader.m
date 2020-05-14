//
//  YunShuShouHuoHeader.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/8.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "YunShuShouHuoHeader.h"

@implementation YunShuShouHuoHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    self.ViewWhiteBG.layer.cornerRadius = 5;
    self.ViewWhiteBG.clipsToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
