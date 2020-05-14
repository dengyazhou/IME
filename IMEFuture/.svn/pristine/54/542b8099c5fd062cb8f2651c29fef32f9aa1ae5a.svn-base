//
//  ProductionConfirmInfo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/8/31.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OperationConfirm;

@interface ProductionConfirmInfo : NSObject

/**
 * SO工单号
 */
@property (nonatomic,copy) NSString * customerOrder;

/**
 * 子零件号
 */
@property (nonatomic,copy) NSString * productionlotNum;

/**
 * 生产管理号
 */
@property (nonatomic,copy) NSString * productionControlNum;

/**
 * 工作中心编号
 */
@property (nonatomic,copy) NSString * workCenterCode;

/**
 * 工作中心名称
 */
@property (nonatomic,copy) NSString * workCenterText;

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
 * 订单状态(1：未投产；2：投产；3：报工；4：完工；5强制关闭)
 */
@property (nonatomic,copy) NSString * statuseCode;

/**
 * 需求日期
 */
@property (nonatomic,copy) NSString * requirementDate;

/**
 * 各生产管理号订单的各工序报工明细
 */
@property (nonatomic,strong) NSMutableArray <__kindof OperationConfirm *> * operationConfirms;//数组中放OperationConfirm

@end
