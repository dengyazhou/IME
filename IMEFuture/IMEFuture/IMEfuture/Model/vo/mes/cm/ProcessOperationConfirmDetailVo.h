//
//  ProcessOperationConfirmDetailVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/11/4.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProcessOperationConfirmDetailVo : ImeCommonVo

/**
 * 工序描述 NVARCHAR(60)
 */
@property (nonatomic,copy) NSString * operationText;

/**
 * 作业单元描述
 */
@property (nonatomic,copy) NSString * workUnitText;

/**
 * 用户描述
 */
@property (nonatomic,copy) NSString * userText;

/**
 * 实际工时
 */
@property (nonatomic,strong) NSNumber * actualHours;//Double

/**
 * 完工数量
 */
@property (nonatomic,strong) NSNumber * completedQuantity;//Double

/**
 * 合格数
 */
@property (nonatomic,strong) NSNumber * percentPassQuantity;//Double

/**
 * 报废数量
 */
@property (nonatomic,strong) NSNumber * scrappedQuantity;//Double

/**
 * 生产管理号
 */
@property (nonatomic,copy) NSString * productionControlNum;

/**
 * NUMBER(19) 工艺工序ID
 */
@property (nonatomic,strong) NSNumber * processOperationId;//Long

@end

NS_ASSUME_NONNULL_END
