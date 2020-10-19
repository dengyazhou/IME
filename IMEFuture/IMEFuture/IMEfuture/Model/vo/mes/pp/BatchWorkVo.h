//
//  BatchWorkVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/5.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ImeCommonVo.h"
#import "WorkTimeLogVo.h"


@interface BatchWorkVo : ImeCommonVo

/**
 * 批量报工单号
 */
@property (nonatomic,copy) NSString * batchWorkNum;

/**
 * 当前工序号
 */
@property (nonatomic,copy) NSString * operationCode;

/**
 * 当前工序名称
 */
@property (nonatomic,copy) NSString * operationText;

/**
 * 作业单元编号
 */
@property (nonatomic,copy) NSString * workUnitCode;

/**
 * 作业单元名称
 */
@property (nonatomic,copy) NSString * workUnitText;

/**
 * 生产作业单号
 */
@property (nonatomic,copy) NSString * productionControlNum;

/**
 * 计划工时
 */
@property (nonatomic,strong) NSNumber * plannedHours;//Double

/**
 * 报工人
 */
@property (nonatomic,copy) NSString * confirmUser;

/**
 * 报工人
 */
@property (nonatomic,copy) NSString * confirmUserText;

/**
 * 停机原因描述
 */
@property (nonatomic,copy) NSString * shutDownCauseText;

@property (nonatomic, copy) NSString * shutDownCauseCode;

/**
 * 工作时间
 */
@property (nonatomic,strong) NSNumber * workTime;//Long

/**
 * 实际开始时间
 */
@property (nonatomic,copy) NSString * startDateTime;//Date

/**
 * 实际完成时间
 */
@property (nonatomic,copy) NSString * actualendDateTime;//Date

/**
 * 报工记录状态-0：创建，1：开始，2：暂停，3：继续，4：完成，5：报工
 */
@property (nonatomic,strong) NSNumber * status;//Integer

/**
 * 剩余工时
 */
@property (nonatomic,strong) NSNumber * surplusHours;//Double

/**
 * 批量报工单子项
 */
@property (nonatomic,strong) NSMutableArray <__kindof WorkTimeLogVo *> * batchWorkItemList;

@property (nonatomic,copy) NSString * isNO;//NO 或者 YES YES时加入数组 默认为NO


/**
 * 报工记录类型 0 正常生产 1 返工返修
 */
@property (nonatomic,strong) NSNumber * workRecordTypeDyz;//Integer


//审核员（用户编号）
@property (nonatomic,copy) NSString * auditor;
//密码
@property (nonatomic,copy) NSString * password;
//提交方式（0正常提交1审核提交）
@property (nonatomic,strong) NSNumber * submitType;
//登录类型 (PDA/WEB)
@property (nonatomic,copy) NSString * loginType;

/**
 批量报工类型    1生产2质检
 */
@property (nonatomic,strong) NSNumber * batchWorkType;//Integer

/**
 继续报工标志 、0否1是
 */
@property (nonatomic,strong) NSNumber * continueFlag;//Integer


@end
