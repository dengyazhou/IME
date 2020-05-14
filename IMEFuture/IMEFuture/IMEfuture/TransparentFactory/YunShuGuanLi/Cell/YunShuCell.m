//
//  YunShuCell.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/8.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "YunShuCell.h"


@interface YunShuCell ()

@property (weak, nonatomic) IBOutlet UIView *viewBg;

@end

@implementation YunShuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //没效果
//    self.contentView.layer.cornerRadius = 5;
//    self.contentView.clipsToBounds = YES;
    
    //可以
//    self.layer.cornerRadius = 5;
//    self.clipsToBounds = YES;
    
    self.viewBg.layer.cornerRadius = 5;
    self.clipsToBounds = YES;

    self.button13.layer.cornerRadius = 5;
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
//    self.layer.cornerRadius = 5;
//    self.clipsToBounds = YES;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
