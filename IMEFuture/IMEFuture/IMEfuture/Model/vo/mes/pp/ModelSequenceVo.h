//
//  ModelSequenceVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/6/28.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ModelSequenceVo : ImeCommonVo

/**
 * 模具编号(物料编号)
 */
@property (nonatomic, copy) NSString * modelCode;

/**
 * 模具名称
 */
@property (nonatomic, copy) NSString * modelCodeText;

/**
 * 序列号
 */
@property (nonatomic, copy) NSString * sequenceNum;

/**
 * 入库批次编号
 */
@property (nonatomic, copy) NSString * inStockLotNum;

/**
 * 数量
 */
@property (nonatomic, strong) NSNumber * quantity;//Double

@property (nonatomic, strong) NSNumber * status;

@property (nonatomic, copy) NSString * productionControlNum;

@property (nonatomic, strong) NSNumber * isSelect;//0:没选；1:选了。。。获取数据是赋值为0，所以默认为没选

@end

NS_ASSUME_NONNULL_END
