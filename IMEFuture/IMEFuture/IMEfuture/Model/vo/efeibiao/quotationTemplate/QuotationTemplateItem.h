//
//  QuotationTemplateItem.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/10/16.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@class QuotationTemplate;

@interface QuotationTemplateItem : BaseEntity

/**
 * 主键
 */
@property (nonatomic,copy) NSString * templateItemId;

/**
 * 报价模板
 */
@property (nonatomic,strong) QuotationTemplate * quotationTemplate;

/**
 * 报价模板Id
 */
@property (nonatomic,copy) NSString * quotationTemplateId;

/**
 * 报价模板明细名称
 */
@property (nonatomic,copy) NSString * templateItemName;

/**
 * 报价模板明细备注
 */
@property (nonatomic,copy) NSString * templateItemRemark;

/**
 * 报价模板明细类型
 * 0-智造家标准；1-自定义
 */
@property (nonatomic,strong) NSNumber * templateItemType;//Integer

/**
 * 报价模板明细模块
 * 0-价格明细；1-杂费明细；2-运费
 */
@property (nonatomic,strong) NSNumber * templateItemModel;//Integer

/**
 * 顺序（前端排序）
 */
@property (nonatomic,strong) NSNumber * templateIndex;//Integer

/**
 * 是否使用
 */
@property (nonatomic,strong) NSNumber * isUse;//Integer

@end
