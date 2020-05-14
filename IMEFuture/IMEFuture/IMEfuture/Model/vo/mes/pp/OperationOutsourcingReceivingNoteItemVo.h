//
//  OperationOutsourcingReceivingNoteItemVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/28.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "ImeCommonVo.h"

#import <MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface OperationOutsourcingReceivingNoteItemVo : ImeCommonVo

/**
 * id
 */
@property (nonatomic,strong) NSNumber * idDYZ;//Long

/**
 * 工序委外收货单ID
 */
@property (nonatomic,strong) NSNumber * operationOutsourcingReceivingNoteId;//Long

/**
 * 工序委外申请单明细ID
 */
@property (nonatomic,strong) NSNumber * operationOutsourcingOrderItemId;//Long

/**
 * 委外申请单编号
 */
@property (nonatomic,copy) NSString * outsourcingCode;

/**
 * 項目编号
 */
@property (nonatomic,copy) NSString * projectNum;

/**
 * 项目描述
 */
@property (nonatomic,copy) NSString * projectName;

/**
 * 生产订单号
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
 * 物料描述
 */
@property (nonatomic,copy) NSString * materialText;

/**
 * 物料单位编号
 */
@property (nonatomic,copy) NSString * materialUnitCode;

/**
 * 物料单位描述
 */
@property (nonatomic,copy) NSString * materialUnitText;

/**
 * 工艺工序id
 */
@property (nonatomic,strong) NSNumber * processOperationId;//Long

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
 * 是否最后一道工序标记
 */
@property (nonatomic,strong) NSNumber * lastFlag;//Integer

/**
 * 发货数量
 */
@property (nonatomic,strong) NSNumber * sendQuantity;//Double

/**
 * 收货数量
 */
@property (nonatomic,strong) NSNumber * deliveryQuantity;//Double

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

NS_ASSUME_NONNULL_END
