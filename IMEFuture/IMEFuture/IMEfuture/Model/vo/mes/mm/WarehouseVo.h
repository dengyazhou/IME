//
//  WarehouseVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/11/2.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface WarehouseVo : ImeCommonVo

/**
 * 仓库编号:nvarchar2(20) <Primary Key>
 */
@property (nonatomic, copy) NSString * warehouseCode;

/**
 * 描述:nvarchar2(60)
 */
@property (nonatomic, copy) NSString * warehouseText;

/**
 * 仓库类型编号:nvarchar2(20)
 */
@property (nonatomic, copy) NSString * warehouseTypeCode;

/**
 * 仓库类型描述:nvarchar2(60)
 */
@property (nonatomic, copy) NSString * warehouseTypeText;

/**
 * 库位管理标志:number(1)
 */
@property (nonatomic, strong) NSNumber * locationManageFlag;//Integer

/**
 * 允许负库存标志:number(1)
 */
@property (nonatomic, strong) NSNumber * negativeInventoryFlag;//Integer

/**
 * 所在位置:nvarchar2(60)
 */
@property (nonatomic, copy) NSString * place;

/**
 * 锁定标志:number(1)
 */
@property (nonatomic, strong) NSNumber * lockFlag;//Integer

@end

NS_ASSUME_NONNULL_END
