//
//  BlankingWorkTimeLogDetailVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/26.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ImeCommonVo.h"
#import <MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlankingWorkTimeLogDetailVo : ImeCommonVo

/**
 * ID
 */
@property (strong, nonatomic) NSNumber * idd;//Long

/**
 * 下料清单报工记录ID
 */
@property (strong, nonatomic) NSNumber * blankingWorktimeLogId;//Long

/**
 * 下料单号
 */
@property (copy, nonatomic) NSString * blankingCode;

/**
 * 生产管理号
 */
@property (copy, nonatomic) NSString * productionControlNum;

/**
 * 工艺工序ID
 */
@property (copy, nonatomic) NSString * processOperationId;

/**
 * 当前工序号
 */
@property (copy, nonatomic) NSString * operationCode;

/**
 * 工序描述 NVARCHAR(60)
 */
@property (copy, nonatomic) NSString * operationText;

/**
 * 物料编号
 */
@property (copy, nonatomic) NSString * materialCode;

/**
 * 物料描述
 */
@property (copy, nonatomic) NSString * materialText;

/**
 * 计划下料数
 */
@property (strong, nonatomic) NSNumber * plannedQuantity;//Double

/**
 * 本次下料数量
 */
@property (strong, nonatomic) NSNumber * blankingQuantity;//Double

/**
 * 工作时间
 */
@property (strong, nonatomic) NSNumber * workTime;//Long

/**
 * 已完成数量
 */
@property (strong, nonatomic) NSNumber * finishedQuantity;//Double

/**
 * 完工数量
 */
@property (strong, nonatomic) NSNumber * completedQuantity;//Double

/**
 * 报废数量
 */
@property (strong, nonatomic) NSNumber * scrappedQuantity;//Double

/**
 * 返修数量
 */
@property (strong, nonatomic) NSNumber * repairQuantity;//Double

@end

NS_ASSUME_NONNULL_END
