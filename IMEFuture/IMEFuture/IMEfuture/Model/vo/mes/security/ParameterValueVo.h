//
//  ParameterValueVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/4/14.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParameterValueVo : ImeCommonVo


//private static final long serialVersionUID = 1L;

@property (nonatomic,strong) NSNumber * DYZid;//Integer

/**
 * 参数编号，parameter对象
 */
@property (nonatomic,copy) NSString * parameterCode;

/**
 * 枚举值
 */
@property (nonatomic,copy) NSString * value;

/**
 * 枚举编号
 */
@property (nonatomic,copy) NSString * valueText;
/**
 * 默认值
 */
@property (nonatomic,strong) NSNumber * defaultFlag;//Integer

@end

NS_ASSUME_NONNULL_END
