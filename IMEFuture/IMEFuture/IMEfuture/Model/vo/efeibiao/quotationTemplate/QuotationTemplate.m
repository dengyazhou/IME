//
//  QuotationTemplate.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/10/16.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "QuotationTemplate.h"
#import "MJExtension.h"
#import "QuotationTemplateItem.h"

@implementation QuotationTemplate

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"quotationTemplateItems":@"QuotationTemplateItem"};
}

@end
