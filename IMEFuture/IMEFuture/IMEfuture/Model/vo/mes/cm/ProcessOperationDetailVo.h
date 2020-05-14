//
//  ProcessOperationDetailVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/11/4.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProcessOperationDetailVo : ImeCommonVo

/**
 * 工艺工序ID
 */
@property (nonatomic,strong) NSNumber * processOperationId;//Long

/**
 * 工序编号
 */
@property (nonatomic,copy) NSString * operationCode;

/**
 * 工序描述 NVARCHAR(60)
 */
@property (nonatomic,copy) NSString *  operationText;

/**
 * 计划数量
 */
@property (nonatomic,strong) NSNumber * plannedQuantity;//Double

/**
 * 完工数量
 */
@property (nonatomic,strong) NSNumber * completedQuantity;//Double

/**
 * 合格数
 */
@property (nonatomic,strong) NSNumber * percentPassQuantity;//Double

/**
 * 完工率
 */
@property (nonatomic,strong) NSNumber * completedQuantityRatio;//Integer

/**
 * 完工率字符形式
 */
@property (nonatomic,copy) NSString *  completedQuantityRatioStr;

/**
 * 报废数量
 */
@property (nonatomic,strong) NSNumber * scrappedQuantity;//Double

/**
 * 合格率
 */
@property (nonatomic,strong) NSNumber * percentPass;//Integer

/**
 * 合格率字符形式
 */
@property (nonatomic,copy) NSString *  percentPassStr;

/**
 * 不合格率
 */
@property (nonatomic,strong) NSNumber * rejectRatio;//Integer

/**
 * 不合格率字符形式
 */
@property (nonatomic,copy) NSString *  rejectRatioStr;

/**
 * 计划工时
 */
@property (nonatomic,strong) NSNumber * plannedHours;//Double

/**
 * 实际工时
 */
@property (nonatomic,strong) NSNumber * actualHours;//Double

/**
 * 工时差异
 */
@property (nonatomic,strong) NSNumber * timeVariance;//Double

/**
 * 生产管理号
 */
@property (nonatomic,copy) NSString *  productionControlNum;

@end

NS_ASSUME_NONNULL_END
