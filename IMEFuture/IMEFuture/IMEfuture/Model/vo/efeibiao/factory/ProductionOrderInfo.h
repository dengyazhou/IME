//
//  ProductionOrderInfo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/8/31.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProductionConfirmInfo;

@interface ProductionOrderInfo : NSObject

/**
 * SO工单号
 */
@property (nonatomic,copy) NSString * customerOrder;

/**
 * 子零件号
 */
@property (nonatomic,copy) NSString * productionlotNum;

/**
 * 生产订单编号
 */
@property (nonatomic,copy) NSString * productionOrderNum;

/**
 * 实际开始时间
 */
@property (nonatomic,copy) NSString * actualstartDateTime;

/**
 * 实际结束时间
 */
@property (nonatomic,copy) NSString * actualendDateTime;

/**
 * 产品名称
 */
@property (nonatomic,copy) NSString * materialText;

/**
 * 工艺编号
 */
@property (nonatomic,copy) NSString * processCode;

/**
 * 工艺版本
 */
@property (nonatomic,copy) NSString * processRev;

/**
 * 工艺描述
 */
@property (nonatomic,copy) NSString * processText;

/**
 * 计划数量
 */
@property (nonatomic,copy) NSString * plannedQuantity;

/**
 * 完工数量
 */
@property (nonatomic,copy) NSString * completedQuantity;

/**
 * 排产量
 */
@property (nonatomic,strong) NSNumber *releasedQuantity;//Integer

/**
 * 订单状态 (1：创建；2：在制；5：完工；6关闭)
 */
@property (nonatomic,copy) NSString * statuseCode;

/**
 * 需求日期
 */
@property (nonatomic,copy) NSString * requirementDate;

/**
 * 各MO订单的生产管理号订单详情（数组）
 */
@property (nonatomic,strong) NSMutableArray <__kindof ProductionConfirmInfo *>* productionConfirmInfo;//数组中放ProductionConfirmInfo

@end
