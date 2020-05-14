//
//  WoDeTongZhiCell.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/19.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "WoDeTongZhiCell.h"

@implementation WoDeTongZhiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews {
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (self.selected) {
                        img.image=[UIImage imageNamed:@"icon_selected"];
                    }else
                    {
                        img.image=[UIImage imageNamed:@"icon_unchecked"];
                    }
                }
            }
        }
        if ([control isMemberOfClass:NSClassFromString(@"_UITableViewCellSeparatorView")]) {
//            NSLog(@">>%@",control);
            [control removeFromSuperview];
        }
    }
    
    [super layoutSubviews];
}


//适配第一次图片为空的情况
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (!self.selected) {
                        img.image=[UIImage imageNamed:@"icon_unchecked"];
                    }
                }
            }
        }
    }
}

@end
