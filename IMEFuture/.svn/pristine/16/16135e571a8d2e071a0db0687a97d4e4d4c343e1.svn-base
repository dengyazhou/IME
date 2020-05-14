//
//  BlankingWorkTimeLogVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/26.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ImeCommonVo.h"

#import <MJExtension.h>
#import "BlankingWorkTimeLogDetailVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface BlankingWorkTimeLogVo : ImeCommonVo

/**
 * ID
 */
@property (strong, nonatomic) NSNumber *idd;//Long

/**
 * 下料单号
 */
@property (nonatomic,copy) NSString * blankingCode;

/**
 * 作业单元编号
 */
@property (copy, nonatomic) NSString * workUnitCode;

/**
 * 作业单元描述
 */
@property (copy, nonatomic) NSString * workUnitText;

/**
 * 当前工序号
 */
@property (copy, nonatomic) NSString * operationCode;

/**
 * 工序描述 NVARCHAR(60)
 */
@property (copy, nonatomic) NSString * operationText;

/**
 * 计划工时
 */
//@property (copy, nonatomic) NSString * planWorkTime;
@property (strong, nonatomic) NSNumber * planWorkTime;

/**
 * 报工人
 */
@property (copy, nonatomic) NSString * confirmUser;

/**
 * 报工人名称
 */
@property (copy, nonatomic) NSString * confirmUserText;

/**
 * 工作时间
 */
@property (strong, nonatomic) NSNumber * workTime;//Long

/**
 *
 */
//@property (copy, nonatomic) NSString * surplusTime;
@property (strong, nonatomic) NSNumber * surplusTime;

/**
 * 实际开始时间
 */
@property (copy, nonatomic) NSString * startDateTime;//Date

/**
 * 实际完成时间
 */
@property (copy, nonatomic) NSString * actualendDateTime;//Date

/**
 * 停机原因代码
 */
@property (copy, nonatomic) NSString * shutDownCauseCode;

/**
 * 报工记录状态-1：开始，2：暂停，3：继续，4：完工，5：报工完成
 */
@property (strong, nonatomic) NSNumber * status;//int

/**
 * 报工记录明细
 */
@property (strong, nonatomic) NSMutableArray <__kindof BlankingWorkTimeLogDetailVo *> * blankingWorkTimeLogDetailList;

@end

NS_ASSUME_NONNULL_END
