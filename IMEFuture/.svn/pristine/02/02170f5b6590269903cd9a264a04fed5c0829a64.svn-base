//
//  AddView.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/6/28.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "AddView.h"

#import "Header.h"

#import "AddMenuView.h"

@interface AddView () {
    CGFloat _height_NavBar;
}

@end

@implementation AddView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

- (instancetype)initWithFrame:(CGRect)frame buttonClick:(void (^)(NSInteger))block {
    self = [super initWithFrame:frame];
    if (self) {
        _height_NavBar = Height_NavBar;
        self.backgroundColor = [UIColor clearColor];
        AddMenuView *addMenuV = [[AddMenuView alloc] initWithFrame:CGRectMake(kMainW-113-8, _height_NavBar, 113, 129) buttonClick:^(NSInteger tag) {
//            NSLog(@"%ld",tag);
            block(tag);
        }];
        addMenuV.backgroundColor = [UIColor clearColor];
        [self addSubview:addMenuV];
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
