//
//  AddMenuView.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/6/28.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "AddMenuView.h"

#import "Header.h"

@interface AddMenuView ()

@property (nonatomic,strong) NSArray *arrayIcon;
@property (nonatomic,strong) NSArray *arrayName;
@end

@implementation AddMenuView

- (NSArray *)arrayIcon {
    if (!_arrayIcon) {
        _arrayIcon = @[@"ime-filter-icon",@"ime-label-icon",@"ime-supplier-icon"];
    }
    return _arrayIcon;
}

- (NSArray *)arrayName {
    if (!_arrayName) {
        _arrayName = @[@"筛选",@"标签管理",@"添加供应商"];
    }
    return _arrayName;
}

- (instancetype)initWithFrame:(CGRect)frame buttonClick:(void (^)(NSInteger))block{
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonBlock = block;
        
        CGFloat height = (frame.size.height-8)/3.0;
        for (NSInteger i = 0; i < 3; i++) {
            UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
            button0.frame = CGRectMake(0, 8+height*i, frame.size.width, height);
            button0.tag = i;
            [button0 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button0];
            
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 14, 0, 0)];
            imageView.image = [UIImage imageNamed:self.arrayIcon[i]];
            [imageView sizeToFit];
            [button0 addSubview:imageView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+8, 11, 0, 0)];
            label.text = self.arrayName[i];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = colorRGB(32, 32, 32);
            [label sizeToFit];
            [button0 addSubview:label];
        }
        
        for (NSInteger i = 0; i < 2; i++) {
            UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(10, 8+height*(i+1), frame.size.width-20, 0.5)];
            viewLine.backgroundColor = colorRGB(204, 204, 204);
            [self addSubview:viewLine];
        }
    }
    return self;
}

- (void)buttonClick:(UIButton *)sender {
    self.buttonBlock(sender.tag);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(1, 8)];
    [path addLineToPoint:CGPointMake(89, 8)];
    [path addLineToPoint:CGPointMake(89+6, 1)];
    [path addLineToPoint:CGPointMake(89+12, 8)];
    [path addLineToPoint:CGPointMake(self.frame.size.width-1, 8)];
    [path addLineToPoint:CGPointMake(self.frame.size.width-1, self.frame.size.height-1)];
    [path addLineToPoint:CGPointMake(1, self.frame.size.height-1)];
    [path closePath];
    
    [[UIColor whiteColor] setFill];
    [colorRGB(204, 204, 204) setStroke];
    path.lineWidth = 1.5;
    [path stroke];
    [path fill];
}


@end
