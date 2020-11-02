//
//  ProductionConfirmVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/10/30.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductionConfirmVo : ImeCommonVo


/**
 * 项目编号
 */
@property (nonatomic, copy) NSString * projectNum;

/**
 * 项目名称
 */
@property (nonatomic, copy) NSString * projectName;

/**
 * 生产订单编号
 */
@property (nonatomic, copy) NSString * productionOrderNum;

/**
 * 生产作业号
 */
@property (nonatomic, copy) NSString * productionControlNum;

/**
 * 生产作业号状态
 */
@property (nonatomic, copy) NSString * productionControlStatuseCode;

/**
 * 物料编号
 */
@property (nonatomic, copy) NSString * materialCode;

/**
 * 物料名称
 */
@property (nonatomic, copy) NSString * materialText;

/**
 * 工序编号
 */
@property (nonatomic, copy) NSString * operationCode;

/**
 * 工序名称
 */
@property (nonatomic, copy) NSString * operationText;

/**
 * 作业单元编号
 */
@property (nonatomic, copy) NSString * workUnitCode;

/**
 * 作业单元名称
 */
@property (nonatomic, copy) NSString * workUnitText;

/**
 * 报工人员编号
 */
@property (nonatomic, copy) NSString * confirmUserCode;

/**
 * 报工人员名称
 */
@property (nonatomic, copy) NSString * confirmUserText;

/**
 * 职员类型编号
 */
@property (nonatomic, copy) NSString * personnelTypeCode;

/**
 * 职员类型描述
 */
@property (nonatomic, copy) NSString * personnelTypeText;

/**
 * 计划工时
 */
@property (nonatomic, copy) NSString * planWorkTime;

/**
 * 报工时长
 */
@property (nonatomic, copy) NSString * workTime;

/**
 * 计划数量
 */
@property (nonatomic, strong) NSNumber * plannedQuantity;//Double

/**
 * 完工数量
 */
@property (nonatomic, strong) NSNumber * completedQuantity;//Double

/**
 * 报废数量
 */
@property (nonatomic, strong) NSNumber * scrappedQuantity;//Double

/**
 * erp用戶编号
 */
@property (nonatomic, copy) NSString * erpUserCode;

/**
 * 实际工时
 */
@property (nonatomic, strong) NSNumber * actualHours;//Long

/**
 * 计划产值
 */
@property (nonatomic, strong) NSNumber * plannedOutValue;//Double

/**
 * 实际产值
 */
@property (nonatomic, strong) NSNumber * actualOutValue;//Double

/**
 * 人员单价
 */
@property (nonatomic, strong) NSNumber * pricePerHour;//Double

/**
 * 报工时间:date(0)
 */
@property (nonatomic, copy) NSString * confirmDateTime;//Date

/**
 * 模具编号
 */
@property (nonatomic, copy) NSString * moldmaterial;


@property (nonatomic, copy) NSString * modelCode;

@property (nonatomic, copy) NSString * sequenceNum;



@end

NS_ASSUME_NONNULL_END
