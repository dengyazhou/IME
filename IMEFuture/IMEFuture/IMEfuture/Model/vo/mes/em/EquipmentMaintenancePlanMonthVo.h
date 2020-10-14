//
//  EquipmentMaintenancePlanMonthVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/25.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"
#import <MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface EquipmentMaintenancePlanMonthVo : ImeCommonVo

/**
 * ID
 */
@property (nonatomic, strong) NSNumber * idDYZ;//Long

/**
 * 保养计划名
 */
@property (nonatomic, copy) NSString * planName;

/**
 * 保养计划年份
 */
@property (nonatomic, strong) NSNumber * planYear;//Integer

/**
 * 保养计划月份
 */
@property (nonatomic, strong) NSNumber * month;//Integer

/**
 * 设备编号
 */
@property (nonatomic, copy) NSString * equipmentCode;

/**
 * 设备描述
 */
@property (nonatomic, copy) NSString * equipmentText;

/**
 * 保养项目编号
 */
@property (nonatomic, copy) NSString * maintainProjectCode;
/**
 * 保养项目描述
 */
@property (nonatomic, copy) NSString * maintainProjectText;

/**
 * 保养计划月份完成状态
 */
@property (nonatomic, strong) NSNumber * finishStatus;//Integer

@property (nonatomic, strong) NSNumber *isSelect;//Dyz

@end

NS_ASSUME_NONNULL_END
