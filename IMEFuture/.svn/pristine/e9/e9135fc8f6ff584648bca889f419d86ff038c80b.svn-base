//
//  XunPanCell.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "XunPanCell.h"

@interface XunPanCell ()
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UILabel *quotationNum;
@property (weak, nonatomic) IBOutlet UILabel *labelYiYou;//已有
@property (weak, nonatomic) IBOutlet UILabel *labelJiaBaoJia;//家报价

@end

@implementation XunPanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setInquiryOrder:(InquiryOrder *)inquiryOrder {
    _inquiryOrder = inquiryOrder;
    
    self.label0.text =  [NSString stringWithFormat:@"询盘号：%@",inquiryOrder.enterpriseOrderCode?inquiryOrder.enterpriseOrderCode:@"--"];
    
    NSArray *arrayTags = [inquiryOrder.tags componentsSeparatedByString:@"."];
    NSMutableArray *arrayTags1 = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString *string in arrayTags) {
        if (![string isEqualToString:@""]) {
            [arrayTags1 addObject:string];
        }
    }
    NSString *stringTag;
    for (int i = 0; i < arrayTags1.count; i++) {
        if (i == 0) {
            stringTag = arrayTags1[i];
        } else {
            stringTag = [NSString stringWithFormat:@"%@、%@",stringTag,arrayTags1[i]];
        }
    }
    self.label1.text = [NSString stringWithFormat:@"工艺：%@",stringTag?stringTag:@"--"];
    
    double num = 0;
    for (InquiryOrderItem *item in inquiryOrder.inquiryOrderItems) {
        num += item.num1.doubleValue;
    }
    self.label2.text = [NSString stringWithFormat:@"数量：%@",[NSString removeSuffixIsZone:num]];
    
    NSArray *arrayEndTm = [[[inquiryOrder.endTm componentsSeparatedByString:@" "] firstObject] componentsSeparatedByString:@"-"];
    self.label3.text = [NSString stringWithFormat:@"%@年%@月%@日",arrayEndTm[0],arrayEndTm[1],arrayEndTm[2]];
    
    self.quotationNum.text = inquiryOrder.quotationNum.stringValue;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
