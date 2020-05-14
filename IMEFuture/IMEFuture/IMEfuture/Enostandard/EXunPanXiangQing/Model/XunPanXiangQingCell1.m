//
//  XunPanXiangQingCell1.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/5.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "XunPanXiangQingCell1.h"
#import "NSString+Enumeration.h"
#import "GlobalSettingManager.h"

@interface XunPanXiangQingCell1 ()

@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;


@end

@implementation XunPanXiangQingCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)initDate:(InquiryOrderItem *)model with:(NSIndexPath *)indexPath isPurchaser:(BOOL)yes{
    
    
    self.label0.text = [NSString stringWithFormat:@"%ld、%@",indexPath.row+1,model.partNumber!=nil?model.partNumber:@""];//零件号
    self.label1.text = [[model.deliveryTime componentsSeparatedByString:@" "] firstObject];//交货日期
    self.label2.text = model.num1.stringValue;//采购数量
    self.label3.text = [NSString QuantityUnit:model.quantityUnit]!=nil?[NSString QuantityUnit:model.quantityUnit]:@"";//单位
    
    if (yes) {
        //采购商
        if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:117]]) {
            self.label4.text = @"****";//未税核算价
        } else {
            self.label4.text = model.price1.stringValue;//未税核算价
        }
    } else {
        //供应商
        if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:119]]) {
            self.label4.text = @"****";//未税核算价
        } else {
            self.label4.text = model.price1.stringValue;//未税核算价
        }
    }
    
    
    self.label5.text = model.partName!=nil?model.partName:@"";//零件名
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
