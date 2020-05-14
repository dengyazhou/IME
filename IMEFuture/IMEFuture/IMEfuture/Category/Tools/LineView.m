//
//  LineView.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2016/11/1.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "LineView.h"

@implementation LineView

+ (UIView *)lineWithFrame:(CGRect)frame withColor:(UIColor *)color {
    UIView *viewLine = [[UIView alloc] init];
    viewLine.frame = frame;
    viewLine.backgroundColor = color;
    return viewLine;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
