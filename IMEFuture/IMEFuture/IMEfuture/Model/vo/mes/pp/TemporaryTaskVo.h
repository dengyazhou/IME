//
//  TemporaryTaskVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/18.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"
#import <MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface TemporaryTaskVo : ImeCommonVo

/**
 * ID
 */
@property (nonatomic,strong) NSNumber * idDYZ;//Long

/**
 * 临时任务类型ID
 */
@property (nonatomic,strong) NSNumber * temporaryTaskTypeId;//Long

/**
 * 任务说明
 */
@property (nonatomic,copy) NSString * taskSpecification;

/**
 * 临时任务状态 0 创建 1 进行中 2 暂停 3 完成 4 关闭             8（自己添加的，对应的按钮是【创建】【开始】）
 */
@property (nonatomic,strong) NSNumber * status;//Integer

/**
 * 工作时间
 */
@property (nonatomic,strong) NSNumber * workTime;//Long

/**
 * 实际开始时间
 */
@property (nonatomic,copy) NSString * startDateTime;//Date

/**
 * 完工时间
 */
@property (nonatomic,copy) NSString * actualEndDateTime;//Date

/**
 * 确认人（操作者）
 */
@property (nonatomic,copy) NSString * confirmUser;

/**
 * 临时任务状态 0 现场确认 1 远程确认
 */
@property (nonatomic,strong) NSNumber * confirmType;//Integer

/**
 * 暂停次数
 */
@property (nonatomic,strong) NSNumber * shutdownCount;//Integer

/**
 * 暂停总时长
 */
@property (nonatomic,strong) NSNumber * shutdownTime;//Long


/**
 * 登录方式:PDA/WEB
 */
@property (nonatomic,copy) NSString * loginType;

/**
 * 用户名
 */
@property (nonatomic,copy) NSString * userName;

/**
 * 密码
 */
@property (nonatomic,copy) NSString * password;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *userText;

@property (nonatomic,copy) NSString *createUserText;

/**
 * 计划工时
 */
@property (nonatomic,strong) NSNumber * planWorkTime;//Integer

/**
 * 计划工时展示
 */
@property (nonatomic,copy) NSString *planWorkTimeStr;

@property (nonatomic,copy) NSString *correctionDateTime;//Date

/**
 * 是否是班长 1 是 0 否 (获取临时任务列表使用)
 */
@property (nonatomic, strong) NSNumber * leaderFlag;//Integer


/**
 * 保存或开始 0 保存 1 开始
 */
@property (nonatomic, strong) NSNumber * saveOrStart;//Integer

@end

NS_ASSUME_NONNULL_END
