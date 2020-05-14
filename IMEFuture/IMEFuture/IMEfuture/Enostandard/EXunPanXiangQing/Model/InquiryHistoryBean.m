//
//  InquiryHistoryBean.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/6/6.
//  Copyright © 2019 Netease. All rights reserved.
//

#import "InquiryHistoryBean.h"

@implementation InquiryHistoryBean

- (NSString *)status {
    if ([_status isEqualToString:@"FBXP"]) {
        return @"发布询盘";
    }
    if ([_status isEqualToString:@"GYSBJ"]) {
        return @"供应商报价";
    }
    if ([_status isEqualToString:@"SD"]) {
        return @"授单";
    }
    if ([_status isEqualToString:@"SDSPCG"]) {
        return @"授单审批成功";
    }
    if ([_status isEqualToString:@"SDSPSB"]) {
        return @"授单审批失败";
    }
    if ([_status isEqualToString:@"GYSJD"]) {
        return @"供应商接单";
    }
    if ([_status isEqualToString:@"GYSJJJD"]) {
        return @"供应商拒绝接单";
    }
    if ([_status isEqualToString:@"QXXP"]) {
        return @"取消询盘";
    }
    if ([_status isEqualToString:@"GYSJJBJ"]) {
        return @"供应商拒绝报价";
    }
    if ([_status isEqualToString:@"GYSXGBJ"]) {
        return @"供应商修改报价";
    }
    if ([_status isEqualToString:@"CGSXGBJ"]) {
        return @"采购商修改报价";
    }
    
//    SPCG
    return _status;
}

@end
