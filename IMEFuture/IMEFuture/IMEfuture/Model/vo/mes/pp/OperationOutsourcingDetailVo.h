//
//  OperationOutsourcingDetailVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/8/16.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OperationOutsourcingDetailVo : NSObject

/**
 * 工厂代码
 */
@property (nonatomic,copy) NSString * siteCode;

/**
 * detailId
 */
@property (nonatomic,strong) NSNumber * detailId;//Long

/**
 * 工艺工序id
 */
@property (nonatomic,strong) NSNumber * processOperationId;//Long

/**
 * 委外申请单编号
 */
@property (nonatomic,copy) NSString * outsourcingCode;

/**
 * 项目编号
 */
@property (nonatomic,copy) NSString * projectNum;

/**
 * 生产订编号
 */
@property (nonatomic,copy) NSString * productionOrderNum;

/**
 * 生产作业号
 */
@property (nonatomic,copy) NSString * productionControlNum;

/**
 * 物料编号
 */
@property (nonatomic,copy) NSString * materialCode;

/**
 * 物料名称
 */
@property (nonatomic,copy) NSString * materialText;

/**
 * 计量单位
 */
@property (nonatomic,copy) NSString * materialUnitText;

/**
 * 工序编号
 */
@property (nonatomic,copy) NSString * operationCode;

/**
 * 工序描述
 */
@property (nonatomic,copy) NSString * operationText;

/**
 * 订单数量
 */
@property (nonatomic,strong) NSNumber * orderQuantity;//Double

/**
 * 发货数量
 */
@property (nonatomic,strong) NSNumber * sendQuantity;//Double

/**
 * 收货数量
 */
@property (nonatomic,strong) NSNumber * deliveryQuantity;//Double

/**
 * 开始时间
 */
@property (nonatomic,copy) NSString * startDate;//Date

/**
 * 等待时长
 */
@property (nonatomic,strong) NSNumber * waitTime;//BigDecimal

/**
 * 是否最后一道工序标记
 */
@property (nonatomic,strong) NSNumber *lastFlag;//Integer

/**
 * 是否加入委外申请单
 */
@property (nonatomic,strong) NSNumber *addRequisitionFlag;//Integer

/**
 * 发货重量
 */
@property (nonatomic,strong) NSNumber * sendWeight;//Double

/**
 * 收货重量
 */
@property (nonatomic,strong) NSNumber * deliveryWeight;//Double

/**
 * 备注
 */
@property (nonatomic,copy) NSString * remark;

@end
