//
//  ParameterEntityVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/4/14.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"
#import "ParameterValueVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParameterEntityVo : ImeCommonVo

/**
 * 参数编号
 */
@property (nonatomic,copy) NSString * parameterCode;

/**
 * 目录编号关联ParameterFolder
 */
@property (nonatomic,copy) NSString * folderCode;

/**
 * 参数描述
 */
@property (nonatomic,copy) NSString * parameterText;

/**
 * 默认值
 */
@property (nonatomic,copy) NSString * defaultValue;

/**
 * 参数值类型Ecode表
 */
@property (nonatomic,copy) NSString * valueTypeECode;

/**
 * 用户参数标志number(1) 0-否，1-是
 */
@property (nonatomic,strong) NSNumber *userParameterFlag; //private Integer userParameterFlag = 0;

/**
 * 系统参数标志number(1)0-否，1-是
 */
@property (nonatomic,strong) NSNumber *systemParameterFlag;//private Integer systemParameterFlag = 0;

/**
 * 数据集查询语句
 */
@property (nonatomic,copy) NSString * querySql;

/**
 * 用来接收参数
 */
@property (nonatomic, strong) NSMutableArray <ParameterValueVo *> *parameterValue;

@end

NS_ASSUME_NONNULL_END
