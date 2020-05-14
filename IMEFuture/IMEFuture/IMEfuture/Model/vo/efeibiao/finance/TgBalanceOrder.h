//
//  TgBalanceOrder.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/4/17.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "BaseEntity.h"

#import "EnterpriseInfo.h"
#import "Member.h"
#import "TgBalancePayOrder.h"
#import "TgBalanceOrderItem.h"

@interface TgBalanceOrder : BaseEntity

@property (nonatomic,copy) NSString * tgBalanceOrderId;

/**
 * 对账单明细
 */
@property (nonatomic,strong) NSMutableArray <__kindof TgBalanceOrderItem *> * tgBalanceOrderItems;//TgBalanceOrderItem

/**
 * 对账单号
 */
@property (nonatomic,copy) NSString * tgBalanceOrderCode;

/**
 * 发起对账的供应商企业
 */
@property (nonatomic,strong) EnterpriseInfo * supplierEp;

/**
 * 发起对账的供应商企业ID
 */
@property (nonatomic,copy) NSString * supplierManufacturerId;

/**
 * 被对账的采购商企业
 */
@property (nonatomic,strong) EnterpriseInfo * purchaseEp;

/**
 * 被对账的采购商企业ID
 */
@property (nonatomic,copy) NSString * purchaseManufacturerId;

/**
 * 是否已经生成付款单
 */
@property (nonatomic,strong) NSNumber * hasPayOrder;//Integer

/**
 * 付款单
 */
@property (nonatomic,strong) TgBalancePayOrder * tgBalancePayOrder;

/**
 * 付款单ID
 */
@property (nonatomic,copy) NSString * tgBalancePayOrderId;

/**
 * 付款单号
 */
@property (nonatomic,copy) NSString * tgBalancePayOrderCode;

/**
 * 开票税率(订单上的供应商税率)
 */
@property (nonatomic,strong) NSNumber * supplierTaxRate;//Double

/**
 * 订单金额小计
 */
@property (nonatomic,strong) NSNumber * subtotalOrderAmount;//BigDecimal

/**
 * 增扣金额小计
 * 前端不可展示用，需要自行计算
 */
@property (nonatomic,strong) NSNumber * subtotalChangeAmount;//BigDecimal

/**
 * 对账金额总计
 * 前端不可展示用，需要自行计算
 */
@property (nonatomic,strong) NSNumber * totalBalanceAmount;//BigDecimal

/**
 * 对账单状态
 */
@property (nonatomic,copy) NSString * tgBalanceOrderStatus;//TgBalanceOrderStatus

/**
 * 新建时间
 */
@property (nonatomic,copy) NSString * addTm;//Date

/**
 * 新建人Id
 */
@property (nonatomic,copy) NSString * addMemberId;

/**
 * 新建的用户
 */
@property (nonatomic,strong) Member * addMember;

/**
 * 再次提交时间
 */
@property (nonatomic,copy) NSString * editTm;//Date

/**
 * 再次提交人Id
 */
@property (nonatomic,copy) NSString * editMemberId;

/**
 * 再次提交的用户
 */
@property (nonatomic,strong) Member * editMember;

/**
 * 同意原因
 */
@property (nonatomic,copy) NSString * consentRemark;

/**
 * 同意时间
 */
@property (nonatomic,copy) NSString * consentTm;//Date

/**
 * 同意人Id
 */
@property (nonatomic,copy) NSString * consentMemberId;

/**
 * 同意的用户
 */
@property (nonatomic,strong) Member * consentMember;

/**
 * 拒绝原因
 */
@property (nonatomic,copy) NSString * refuseRemark;

/**
 * 拒绝时间
 */
@property (nonatomic,copy) NSString * refuseTm;//Date

/**
 * 拒绝人Id
 */
@property (nonatomic,copy) NSString * refuseMemberId;

/**
 * 拒绝的用户
 */
@property (nonatomic,strong) Member * refuseMember;

/**
 * 取消原因
 */
@property (nonatomic,copy) NSString * cancelRemark;

/**
 * 取消时间
 */
@property (nonatomic,copy) NSString * cancelTm;//Date

/**
 * 取消人Id
 */
@property (nonatomic,copy) NSString * cancelMemberId;

/**
 * 取消的用户
 */
@property (nonatomic,strong) Member * cancelMember;

/**
 * 供应商备注
 */
@property (nonatomic,copy) NSString * supplierRemark;

/**
 * 采购商备注
 */
@property (nonatomic,copy) NSString * purchaseRemark;

/**
 * 跟进人
 */
@property (nonatomic,strong) Member * purchaseFollower;

/**
 * 跟进人ID
 */
@property (nonatomic,copy) NSString * purchaseFollowerId;

/**
 * 查询跟进人姓名
 */
@property (nonatomic,copy) NSString * se_puFollower__childAccount;

/**
 * 查询没有跟进人的对账单
 */
@property (nonatomic,strong) NSNumber * sec_noFollower;//Integer

/**
 * 对账单中的订单ID
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sec_tradeOrderIds;//String[]

/**
 * 查询对账单号
 */
@property (nonatomic,copy) NSString * se_tgBalanceOrderCode;

/**
 * 查询供应商名
 */
@property (nonatomic,copy) NSString * se_suEp__enterpriseName;

/**
 * 查询采购商名
 */
@property (nonatomic,copy) NSString * se_puEp__enterpriseName;

/**
 * 查询对账金额大于等于
 */
@property (nonatomic,strong) NSNumber * seb_totalBalanceAmount;//BigDecimal

/**
 * 查询对账金额小于等于
 */
@property (nonatomic,strong) NSNumber * see_totalBalanceAmount;//BigDecimal

/**
 * 查询提交时间大于
 */
@property (nonatomic,copy) NSString * seb_addTm;//Date

/**
 * 查询提交时间小于
 */
@property (nonatomic,copy) NSString * see_addTm;//Date

@end
