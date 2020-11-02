//
//  ReqMaterialVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/11/2.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReqMaterialVo : ImeCommonVo

/**
 * 领料申请单号
 */
@property (nonatomic, copy) NSString * requisitionCode;

/**
 * 项目编号
 */
@property (nonatomic, copy) NSString * projectNum;

/**
 * 生产订单号
 */
@property (nonatomic, copy) NSString * productionOrderNum;

/**
 * 生产管理号
 */
@property (nonatomic, copy) NSString * productionControlNum;

/**
 * 物料编号
 */
@property (nonatomic, copy) NSString * materialCode;

/**
 * 物料名称
 */
@property (nonatomic, copy) NSString * materialText;

/**
 * 零件类型
 */
@property (nonatomic, strong) NSNumber * partsType;//Integer

/**
 * 计划数
 */
@property (nonatomic, strong) NSNumber * planNum;//Double

/**
 * 创建数量
 */
@property (nonatomic, strong) NSNumber * num;//Double

/**
 * 库存
 */
@property (nonatomic, strong) NSNumber * inventory;//Double

/**
 * 仓库编号
 */
@property (nonatomic, copy) NSString * warehouseCode;

/**
 * 自制件标志（0否1是）
 */
@property (nonatomic, strong) NSNumber * makeFlag;//Integer

/**
 * 备注
 */
@property (nonatomic, copy) NSString * memo;

/**
 * 替用物料
 */
@property (nonatomic, copy) NSString * replaceableMaterialOne;

@property (nonatomic, strong) NSNumber * isSelect;//0:没选；1:选了。。。获取数据是赋值为0，所以默认为没选

@end

NS_ASSUME_NONNULL_END
