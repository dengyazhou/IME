//
//  QuotationTemplate.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/10/16.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@class Member;
@class QuotationTemplateItem;

@interface QuotationTemplate : BaseEntity

/**
 * 主键
 */
@property (nonatomic,copy) NSString * quotationTemplateId;

/**
 * 创建报价模板的用户
 */
@property (nonatomic,strong) Member * member;

/**
 * 创建报价模板的用户Id
 */
@property (nonatomic,copy) NSString * memberId;

/**
 * 创建报价模板的企业Id
 */
@property (nonatomic,copy) NSString * manufacturerId;

/**
 * 报价模板的名称
 */
@property (nonatomic,copy) NSString * quotationTemplateName;

/**
 * 是否是默认
 */
@property (nonatomic,strong) NSNumber * isDefault;//Integer

/**
 * 模板类型
 * 0-自定义模板；1-智造家模板（可修改版）；
 */
@property (nonatomic,strong) NSNumber * templateType;//Integer

/**
 * 模板状态
 * 0-未修改(自动创建的标准模板)；1-已修改（自定义模板及修改后的标准模板）
 */
@property (nonatomic,strong) NSNumber * templateStatus;//Integer

/**
 * 报价模板价格明细的总计数量（最多11）
 */
@property (nonatomic,strong) NSNumber * tempPriceDetailCount;//Integer

/**
 * 报价模板自定义价格明细的总计数量（最多8个）
 */
@property (nonatomic,strong) NSNumber * tempCustomPriceDetailCount;//Integer

/**
 * 报价模板运费明细的总计数量（最多4个）
 * 注：现使用1个
 */
@property (nonatomic,strong) NSNumber * tempShipPriceDetailCount;//Integer

/**
 * 报价模板杂费明细的总计数量（最多10个）
 * 注：现使用6个
 */
@property (nonatomic,strong) NSNumber * tempCostDetailCount;//Integer

/**
 * 报价模板自定义杂费明细的总计数量（最多5个）
 */
@property (nonatomic,strong) NSNumber * tempCustomCostDetailCount;//Integer

/**
 * 模板备注
 */
@property (nonatomic,copy) NSString * tempRemark;

/**
 * 模板明细
 */
@property (nonatomic,strong) NSMutableArray <__kindof QuotationTemplateItem *> *quotationTemplateItems;//QuotationTemplateItem

/**
 * 是否使用
 */
@property (nonatomic,strong) NSNumber * ti__isUse;//Integer

@end
