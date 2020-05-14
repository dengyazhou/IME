//
//  ECInquiryCell122.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/1/22.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ECInquiryCell122.h"

@implementation ECInquiryCell122

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)initDataWith:(InquiryOrder *)inquiryOrder andQuanXian:(NSMutableArray *)arrayTypeQuanXian {
    self.buttonL.hidden = YES;
    self.buttonR.hidden = YES;
    [self.buttonL setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
    self.buttonL.layer.borderColor = colorLine.CGColor;
    [self.buttonR setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];;
    self.buttonR.layer.borderColor = colorLine.CGColor;
    
    self.view3.hidden = NO;

    self.inquiryOrderCodeAndTitle.text = [NSString stringWithFormat:@"询盘号：%@",inquiryOrder.enterpriseOrderCode?inquiryOrder.enterpriseOrderCode:@"--"];
 
    self.labelStatus.text = [NSString InquiryOrderStatus:inquiryOrder.inquiryOrderStatus];
    
    self.imageWidth.constant = 32.5;
    if ([inquiryOrder.inquiryType isEqualToString:@"COM"]) {
        self.imageViewType.hidden = YES;
    }
    if ([inquiryOrder.inquiryType isEqualToString:@"DIR"]) {
        self.imageViewType.hidden = NO;
        self.imageViewType.image = [UIImage imageNamed:@"label_directional"];
    }
    if ([inquiryOrder.inquiryType isEqualToString:@"ATG"]) {
        self.imageViewType.hidden = NO;
        self.imageViewType.image = [UIImage imageNamed:@"label_housekeeper"];
    }
    if ([inquiryOrder.inquiryType isEqualToString:@"FTG"]) {
        self.imageViewType.hidden = NO;
        self.imageViewType.image = [UIImage imageNamed:@"label_price"];
        self.imageWidth.constant = 44.5;
    }
    if ([inquiryOrder.inquiryType isEqualToString:@"TTG"]) {
        self.imageViewType.hidden = NO;
        self.imageViewType.image = [UIImage imageNamed:@"label_bargaining"];
        self.imageWidth.constant = 44.5;
    }
    
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
    self.tags.text = [NSString stringWithFormat:@"零件工艺：%@",stringTag?stringTag:@"--"];
    
    self.num123.text = [NSString stringWithFormat:@"采购总计：%@",[NSString removeSuffixIsZone:inquiryOrder.partNums.doubleValue]];
    
    NSArray *arrayEndTm = [[[inquiryOrder.endTm componentsSeparatedByString:@" "] firstObject] componentsSeparatedByString:@"-"];
    self.endTm.text = [NSString stringWithFormat:@"%@-%@-%@ 截止",arrayEndTm[0],arrayEndTm[1],arrayEndTm[2]];
    
    self.quotationNum.text = [NSString stringWithFormat:@"已有%ld家报价",[inquiryOrder.quotationNum integerValue]];
    
    self.count.text = [NSString stringWithFormat:@"共%ld种零件",inquiryOrder.itemNums.integerValue];
    
    self.imageViewIsUrgent.hidden = true;
    if (inquiryOrder.isUrgent.integerValue == 1) {
        self.imageViewIsUrgent.hidden = false;
    } else {
        self.imageViewIsUrgent.hidden = true;
    }
    
    
    InquiryOrderItem *inquiryOrderItem = inquiryOrder.inquiryOrderItems[0];
    
    if ([inquiryOrder.inquiryType isEqualToString:@"COM"] || [inquiryOrder.inquiryType isEqualToString:@"ATG"]) {
        //COM 寻源，ATG 标准
        if ([inquiryOrder.inquiryOrderStatus isEqualToString:@"NEW"]) {
            //未报价
            self.buttonR.hidden = NO;
            [self.buttonR setTitle:@"查询询盘" forState:UIControlStateNormal];
        } else if ([inquiryOrder.inquiryOrderStatus isEqualToString:@"QUOTATION"]) {
            //已报价
            self.buttonR.hidden = NO;
            [self.buttonR setTitle:@"筛选报价" forState:UIControlStateNormal];
        } else if ([inquiryOrder.inquiryOrderStatus isEqualToString:@"SEND"]) {
            //已授单
            self.buttonR.hidden = NO;
            [self.buttonR setTitle:@"查看订单" forState:UIControlStateNormal];
        } else if ([inquiryOrder.inquiryOrderStatus isEqualToString:@"REFUSE"]) {
            //拒绝报价
            self.buttonR.hidden = NO;
            [self.buttonR setTitle:@"查看原因" forState:UIControlStateNormal];
        } else if ([inquiryOrder.inquiryOrderStatus isEqualToString:@"CANCEL"]) {
            //询盘取消
            self.buttonR.hidden = NO;
            [self.buttonR setTitle:@"查询询盘" forState:UIControlStateNormal];
        }
    } else if ([inquiryOrder.inquiryType isEqualToString:@"TTG"]) {
        //TTG 议价
        if ([inquiryOrder.inquiryOrderStatus isEqualToString:@"SEND"]) {
            //已授单
            if (inquiryOrder.inquiryOrderEnterprises[0].canEditPrice.integerValue == 0) {
                self.buttonR.hidden = NO;
                [self.buttonR setTitle:@"查看订单" forState:UIControlStateNormal];
            } else {
                if (inquiryOrder.inquiryOrderEnterprises[0].purchaseHasQuoed.integerValue == 1) {
                    self.buttonR.hidden = NO;
                    [self.buttonR setTitle:@"修改报价" forState:UIControlStateNormal];
                } else {
                    self.buttonR.hidden = NO;
                    [self.buttonR setTitle:@"立即报价" forState:UIControlStateNormal];
                }
            }
        } else if ([inquiryOrder.inquiryOrderStatus isEqualToString:@"CANCEL"]) {
            //询盘取消
            self.buttonR.hidden = NO;
            [self.buttonR setTitle:@"查看询盘" forState:UIControlStateNormal];
        }
    } else if ([inquiryOrder.inquiryType isEqualToString:@"FTG"]) {
        //FTG 指定
        if ([inquiryOrder.inquiryOrderStatus isEqualToString:@"SEND"]) {
            //已授单
            self.buttonR.hidden = NO;
            [self.buttonR setTitle:@"查看订单" forState:UIControlStateNormal];
        } else if ([inquiryOrder.inquiryOrderStatus isEqualToString:@"CANCEL"]) {
            //询盘取消
            self.buttonR.hidden = NO;
            [self.buttonR setTitle:@"查看询盘" forState:UIControlStateNormal];
        }
    }
    
    if (self.buttonL.isHidden == NO || self.buttonR.isHidden == NO) {
        
    } else {
        self.view3.hidden = YES;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)lastDay:(NSString *)time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateTime = [formatter dateFromString:time];
    NSDate *lastDay = [NSDate dateWithTimeInterval:0 sinceDate:dateTime];
    NSString *lastDayTime = [formatter stringFromDate:lastDay];
    return lastDayTime;
}

@end
