//
//  OperationOutsourcingSourceVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/12/12.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface OperationOutsourcingSourceVo : ImeCommonVo

/**
 * id
 */
@property (nonatomic, strong) NSNumber * idDYZ;//Long

/**
 * 項目编号
 */
@property (nonatomic,copy) NSString * projectNum;//String

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
 * 物料单位编号
 */
@property (nonatomic,copy) NSString * materialUnitCode;

/**
 * 工艺工序id
 */
@property (nonatomic, strong) NSNumber * processOperationId;//Long

/**
 * 工序编号
 */
@property (nonatomic,copy) NSString * operationCode;

/**
 * 订单数量
 */
@property (nonatomic, strong) NSNumber * orderQuantity;//Double

/**
 * 已委外数量
 */
@property (nonatomic, strong) NSNumber * sendOutQuantity;

/**
 * 开始时间
 */
@property (nonatomic,copy) NSString * startDate;//Date

/**
 * 是否最后一道工序标记
 */
@property (nonatomic, strong) NSNumber * lastFlag;//Integer

/**
 * 单位
 */
@property (nonatomic,copy) NSString * materialUnitText;

/**
 * 备注
 */
@property (nonatomic,copy) NSString * remark;

/**
 * 状态
 */
@property (nonatomic, strong) NSNumber * status;//Integer

/**
 * 物料名称
 */
@property (nonatomic,copy) NSString * materialText;

/**
 * 工序名称
 */
@property (nonatomic,copy) NSString * operationText;

/**
 * 生产作业号状态
 */
@property (nonatomic,copy) NSString * productionControlStatus;

/**
 * 剩余数量
 */
@property (nonatomic, strong) NSNumber * surplusQuantity;


@property (nonatomic, strong) NSNumber * sendQuantity; //自己创建

@end

NS_ASSUME_NONNULL_END
