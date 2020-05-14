//
//  ProjectCell.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/1/4.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "ProjectCell.h"

@implementation ProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setPurchaseProject:(PurchaseProject *)purchaseProject {
    _purchaseProject = purchaseProject;
    self.label0.text = [NSString stringWithFormat:@"项目名称：%@",purchaseProject.projectName];
    self.label1.text = [NSString stringWithFormat:@"零件项数：%@项",purchaseProject.itemsNum];
    self.label2.text = [NSString stringWithFormat:@"收货项数：%@项",purchaseProject.receiveItemsNum];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
