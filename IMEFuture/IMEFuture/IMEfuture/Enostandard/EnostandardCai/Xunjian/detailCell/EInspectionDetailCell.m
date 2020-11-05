//
//  EInspectionDetailCell.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/27.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "EInspectionDetailCell.h"

#import "Header.h"


@implementation EInspectionDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)buttonAddImage:(UIButton *)button {
    self.blockAddImage();
}

- (void)buttonClickChaKanDaTuD:(UIButton *)button {
    self.blockDaTu(button.tag);
}

- (void)buttonAddImageBlock:(void (^)(void))block {
    self.blockAddImage = block;
}

- (void)buttonClickChaKanDaTuBlock:(void (^)(NSInteger))block {
    self.blockDaTu = block;
}

- (void)tableViewDidSelectBlock:(void (^)(NSInteger))block {
    self.blockTableSelect = block;
}


@end
