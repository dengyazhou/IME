//
//  EquipmentMaintenanceLogVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/25.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"
#import <MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface EquipmentMaintenanceLogVo : ImeCommonVo

/**
 * ID
 */
@property (nonatomic, strong) NSNumber * idDYZ;//Long

/**
 * 设备保养计划明细月份ID
 */
@property (nonatomic, strong) NSNumber * equipmentMaintenancePlanMonthId;//Long

/**
 * 报工人
 */
@property (nonatomic, copy) NSString * confirmUser;


@end

NS_ASSUME_NONNULL_END
