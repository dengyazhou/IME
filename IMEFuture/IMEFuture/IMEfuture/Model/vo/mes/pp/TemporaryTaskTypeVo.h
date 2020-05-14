//
//  TemporaryTaskTypeVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/18.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"
#import <MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface TemporaryTaskTypeVo : ImeCommonVo

/**
 * ID
 */
@property (nonatomic,strong) NSNumber * idDYZ;//Long

/**
 * 任务名称
 */
@property (nonatomic,copy) NSString * name;

/**
 * 任务说明是否必填标志 0 否  1 是
 */
@property (nonatomic,strong) NSNumber * taskSpecificationRequiredFlag;//Integer

/**
 * 备注
 */
@property (nonatomic,copy) NSString * remark;

/**
 * 锁定标志 0--正常，1--锁定
 */
@property (nonatomic,strong) NSNumber * lockFlag;//private Integer lockFlag = 0;

/**
 * 计划工时
 */
@property (nonatomic,strong) NSNumber * planWorkTime;//Integer

@end

NS_ASSUME_NONNULL_END
