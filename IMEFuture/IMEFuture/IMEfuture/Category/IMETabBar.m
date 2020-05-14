//
//  IMETabBar.m
//  LiveApp
//
//  Created by 邓亚洲 on 2016/11/7.
//  Copyright © 2016年 邓亚洲. All rights reserved.
//

#import "IMETabBar.h"

#import "Header.h"

@interface IMETabBar ()

@property (nonatomic,strong) UIImageView *tabbgView;
@property (nonatomic,strong) NSArray *datalist;
@property (nonatomic,strong) NSArray *datalist1;
@property (nonatomic,strong) UIButton *lastItem;
@property (nonatomic,strong) UIButton *cameraButton;

@end

@implementation IMETabBar

- (UIButton *)cameraButton {
    if (!_cameraButton) {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraButton setImage:[UIImage imageNamed:@"bg_tab"] forState:UIControlStateNormal];
        [_cameraButton sizeToFit];
        _cameraButton.tag = IMEItemTypeLaunch;
        [_cameraButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraButton;
}

- (NSArray *)datalist {
    if (!_datalist) {
        _datalist = @[@"ime_icon_purchaser",@"ime_icon_order",@"ime_icon_supplier",@"ime_icon_project"];
    }
    return _datalist;
}

- (NSArray *)datalist1 {
    if (!_datalist1) {
        _datalist1 = @[@"询盘",@"订单",@"发询盘",@"供应商",@"项目"];
    }
    return _datalist1;
}

- (UIImageView *)tabbgView {
    if (!_tabbgView) {
        _tabbgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    return _tabbgView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //装载背景
        [self addSubview:self.tabbgView];
//        self.backgroundColor = [UIColor whiteColor];
        
        //装载item
        for (NSInteger i = 0; i < self.datalist.count; i++) {
            UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
            //不让图片在高亮下改变
            item.adjustsImageWhenHighlighted = NO;
            [item setImage:[UIImage imageNamed:self.datalist[i]] forState:UIControlStateNormal];
            [item setImage:[UIImage imageNamed:[self.datalist[i] stringByAppendingString:@"_2t"]] forState:UIControlStateSelected];
            [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            item.tag = IMEItemTypeLive + i;
            if (i == 0) {
                item.selected = YES;
                self.lastItem = item;
            }
            [self addSubview:item];
            
            
    
        }
        
        for (NSInteger i = 0; i < self.datalist1.count; i++) {
            CGFloat width = self.bounds.size.width/self.datalist1.count;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*width, self.frame.size.height-13, width, 13)];
            label.font = [UIFont systemFontOfSize:10];
            label.textColor = colorRGB(117, 117, 117);
            label.textAlignment = NSTextAlignmentCenter;
            label.text = self.datalist1[i];
            [self addSubview:label];
        }
        
        //添加直播按钮
        [self addSubview:self.cameraButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tabbgView.frame = self.bounds;
    
    CGFloat width = self.bounds.size.width/(self.datalist.count+1);
    
    for (NSInteger i = 0; i < [self subviews].count; i ++) {
        UIView *btn = [self subviews][i];
        if ([btn isKindOfClass:[UIButton class]]) {
            NSInteger index = btn.tag-IMEItemTypeLive;
            if (index == 0 || index == 1) {
                btn.frame = CGRectMake((btn.tag-IMEItemTypeLive)*width, 0, width, self.frame.size.height-13);
            }
            if (index == 2 || index == 3) {
                btn.frame = CGRectMake((btn.tag-IMEItemTypeLive+1)*width, 0, width, self.frame.size.height-13);
            }
        }
    }
    
//    [self.cameraButton sizeToFit];
    self.cameraButton.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height - 44);
}

- (void)clickItem:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(tabbar:clickButton:)]) {
        [self.delegate tabbar:self clickButton:button.tag];
    }
    
//    !self.block?:self.block(self,button.tag);
    
    if (self.block) {
        self.block(self,button.tag);
    }
    
    if (button.tag == IMEItemTypeLaunch) {
        return;
    }
    
    self.lastItem.selected = NO;
    button.selected = YES;
    self.lastItem = button;
    
    //设置动画
    [UIView animateWithDuration:0.2 animations:^{
        //将button扩大1.2倍
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            //恢复原始状态
            button.transform = CGAffineTransformIdentity;
        }];
    }];
}

@end
