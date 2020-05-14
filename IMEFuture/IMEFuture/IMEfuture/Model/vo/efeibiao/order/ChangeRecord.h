//
//  ChangeRecord.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/4/17.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "BaseEntity.h"
#import "TradeOrder.h"
#import "Member.h"

@interface ChangeRecord : BaseEntity

/**
 * 主键
 */
@property (nonatomic,copy) NSString * changeRecordId;

/**
 * 变更单号
 */
@property (nonatomic,copy) NSString * changeCode;

/**
 * 变更状态
 */
@property (nonatomic,copy) NSString * changeStatus;//ChangeStatus

/**
 * 订单ID
 */
@property (nonatomic,copy) NSString * tradeOrderId;

/**
 * 订单流水号
 */
@property (nonatomic,copy) NSString * tradeOrderCode;

/**
 * 订单编号
 */
@property (nonatomic,copy) NSString * insideOrderCode;

/**
 * 相关交易订单
 */
@property (nonatomic,strong) TradeOrder * tradeOrder;

/**
 * 发起人ID
 */
@property (nonatomic,copy) NSString * spMemberId;

/**
 * 发起人
 */
@property (nonatomic,strong) Member * spMember;

/**
 * 发起人类型
 * 0-采购商；1-供应商
 */
@property (nonatomic,strong) NSNumber * spType;//Integer

/**
 * 发起方企业ID
 */
@property (nonatomic,copy) NSString * spManufacturerId;

/**
 * 发起方企业名称
 */
@property (nonatomic,copy) NSString * spEnterpriseName;

/**
 * 被申请方企业ID
 */
@property (nonatomic,copy) NSString * paManufacturerId;

/**
 * 被申请方企业名称
 */
@property (nonatomic,copy) NSString * paEnterpriseName;

/**
 * (同意/拒绝)操作人ID(被申请方)
 */
@property (nonatomic,copy) NSString * paMemberId;

/**
 *  (同意/拒绝)操作人
 */
@property (nonatomic,strong) Member * paMember;

/**
 * 操作时间（同意/拒绝）
 */
@property (nonatomic,copy) NSString * operateTime;//Date

/**
 * 累计增扣金额
 */
@property (nonatomic,strong) NSNumber * changeAmount;//BigDecimal

/**
 * 金额变动类型-增/扣
 */
@property (nonatomic,copy) NSString * operateStatus;//OperateStatus

/**
 * 撤销人
 */
@property (nonatomic,copy) NSString * cancelMemberId;

/**
 * 撤销时间
 */
@property (nonatomic,copy) NSString * cancelTime;//Date

/**
 * 备注
 */
@property (nonatomic,copy) NSString * remark;

/**
 * 拒绝原因
 */
@property (nonatomic,copy) NSString * refuseCause;

/**
 * 变更类型(后期不需要)
 */
@property (nonatomic,copy) NSString * changeType;//ChangeType

/**
 * 备注（后期不需要）
 */
@property (nonatomic,copy) NSString * tempRemark;

/**
 * 变更状态查询
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sei_changeStatus;//ChangeStatus[]

/**
 * 跟进人
 */
@property (nonatomic,strong) Member * purchaseFollower;

/**
 * 跟进人ID
 */
@property (nonatomic,copy) NSString * purchaseFollowerId;

/**
 * 查询跟进人名称
 */
@property (nonatomic,copy) NSString * se_pf__childAccount;

@end
