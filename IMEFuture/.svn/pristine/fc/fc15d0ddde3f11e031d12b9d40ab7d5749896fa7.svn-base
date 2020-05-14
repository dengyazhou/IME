//
//  UIButtonIM.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/8/10.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "UIButtonIM.h"
#import "UIImageView+GIF.h"



@implementation UIButtonIM

- (instancetype)initWithFrame:(CGRect)frame withGIFFile:(NSString *)file withColor:(UIColor *)color {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [UIImageView imageViewWithGIFFile:file frame:CGRectMake(6, 4, 0, 0)];
        [imageView sizeToFit];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, CGRectGetMinY(imageView.frame)+1, 0, 0)];
        label.text = @"私信";
        label.font = [UIFont systemFontOfSize:12];
        [label sizeToFit];
        label.textColor = color;
        [self addSubview:label];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
