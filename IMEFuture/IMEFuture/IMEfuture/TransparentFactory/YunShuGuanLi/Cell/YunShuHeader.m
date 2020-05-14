//
//  YunShuHeader.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/9/3.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "YunShuHeader.h"

@interface YunShuHeader ()

@property (weak, nonatomic) IBOutlet UIView *viewBg;

@end

@implementation YunShuHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.viewBg.layer.cornerRadius = 5;
    self.viewBg.clipsToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
