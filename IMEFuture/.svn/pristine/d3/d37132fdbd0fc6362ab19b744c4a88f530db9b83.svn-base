//
//  TgBalancePayOrderItem.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/4/17.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "BaseEntity.h"
@class TgBalancePayOrder;
#import "Member.h"

@interface TgBalancePayOrderItem : BaseEntity

@property (nonatomic,copy) NSString * tgBalancePayOrderItemId;

/**
 * (管家对账)付款单
 */
@property (nonatomic,strong) TgBalancePayOrder * tgBalancePayOrder;

/**
 * (管家对账)付款单Id
 */
@property (nonatomic,copy) NSString * tgBalancePayOrderId;

/**
 * (管家对账)付款单号
 */
@property (nonatomic,copy) NSString * tgBalancePayOrderCode;

/**
 * 本次付款的期次
 */
@property (nonatomic,strong) NSNumber * periodIndex;//Integer

/**
 * 付款状态
 */
@property (nonatomic,copy) NSString * payType;//TgBalancePayStatus

/**
 * 期数名称（例如：定金）
 */
@property (nonatomic,copy) NSString * periodName;

/**
 * 付款天数(例：10天)
 */
@property (nonatomic,strong) NSNumber * payDays;//Integer

/**
 * 支付占比
 * 30.33% 就是 30.33
 */
@property (nonatomic,strong) NSNumber * payRate;//Double

/**
 * 付款金额
 */
@property (nonatomic,strong) NSNumber * payPrice;//BigDecimal

/**
 * 是否已付款
 */
@property (nonatomic,strong) NSNumber * hasPay;//Integer

/**
 * 付款时间
 */
@property (nonatomic,strong) NSNumber * payTm;//Date

/**
 * 付款人Id
 */
@property (nonatomic,copy) NSString * payMemberId;

/**
 * 付款的用户
 */
@property (nonatomic,strong) Member * payMember;

/**
 * 预计完成付款时间
 * （receiveInvoiceTm + payDays）
 */
@property (nonatomic,strong) NSNumber * completePaymentTm;//Date

/**
 * 收到发票的时间
 */
@property (nonatomic,strong) NSNumber * receiveInvoiceTm;//Date

/**
 * 是否已确认发票
 */
@property (nonatomic,strong) NSNumber * hasConfirm;//Integer

/**
 * 确认发票时间
 */
@property (nonatomic,strong) NSNumber * confirmTm;//Date

/**
 * 确认发票人Id
 */
@property (nonatomic,copy) NSString * confirmMemberId;

/**
 * 确认发票的用户
 */
@property (nonatomic,strong) Member * confirmMember;

/**
 * 是否已上传发票
 */
@property (nonatomic,strong) NSNumber * hasUpload;//Integer

/**
 * 上传发票时间
 */
@property (nonatomic,strong) NSNumber * uploadTm;//Date

/**
 * 上传发票人Id
 */
@property (nonatomic,copy) NSString * uploadMemberId;

/**
 * 上传发票的用户
 */
@property (nonatomic,strong) Member * uploadMember;

/**
 * 文件别名（上传时的文件名称）
 */
@property (nonatomic,copy) NSString * fileName;

/**
 * 文件的真名
 */
@property (nonatomic,copy) NSString * fileRealName;

/**
 * 文件路径（全路径 ModuleFilePath表文件路径+FileExplanation表文件子路径）
 */
@property (nonatomic,copy) NSString * filePath;

/**
 * OSS存储空间名称
 */
@property (nonatomic,copy) NSString * fileBucketName;

/**
 * 文件ID
 */
@property (nonatomic,copy) NSString * fileId;

/**
 * 可以开始催付款的时间
 */
@property (nonatomic,strong) NSNumber * callPayTm;//Date

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
 * 查询某供应商付款单
 */
@property (nonatomic,copy) NSString * po__supplierManufacturerId;

/**
 * 查询某采购商付款单
 */
@property (nonatomic,copy) NSString * po__purchaseManufacturerId;

/**
 * 查询供应商名
 */
@property (nonatomic,copy) NSString * se_suEp__enterpriseName;

/**
 * 查询采购商名
 */
@property (nonatomic,copy) NSString * se_puEp__enterpriseName;

/**
 * 查询付款单号
 */
@property (nonatomic,copy) NSString * se_tgBalancePayOrderCode;

/**
 * 查询对账单号
 */
@property (nonatomic,copy) NSString * se_tbo__tgBalanceOrderCode;

/**
 * 查询对账金额大于等于
 */
@property (nonatomic,strong) NSNumber * seb_po__payAmount;//BigDecimal

/**
 * 查询对账金额小于等于
 */
@property (nonatomic,strong) NSNumber * see_po__payAmount;//BigDecimal

@end
