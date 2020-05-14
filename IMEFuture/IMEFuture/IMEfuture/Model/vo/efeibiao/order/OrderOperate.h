//
//  OrderOperate.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/4/14.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@class TradeOrder;
@class OrderOperateItem;
@class InquiryOrder;
@class Member;
@class OrderOperate;

@interface OrderOperate : BaseEntity

/**
 * 主键
 */
@property (nonatomic,copy) NSString * orderOperateId;

/**
 * 订单ID
 */
@property (nonatomic,copy) NSString * tradeOrderId;

/**
 * 订单编号
 */
@property (nonatomic,copy) NSString * orderCode;

/**
 * 内部订单号
 * 询盘带入
 */
@property (nonatomic,copy) NSString * insideOrderCode;

/**
 * 内部询盘号-2018.9.12新增
 * 各企业自己内部递增的询盘号
 * eg:081205001 年月日加3位顺序数字
 */
@property (nonatomic,copy) NSString * enterpriseOrderCode;

/**
 * 操作类型
 */
@property (nonatomic,copy) NSString * orderOperateType;//OrderOperateType

/**
 * 操作状态
 */
@property (nonatomic,copy) NSString * operateStatus;//OperateStatus

/**
 * 物流公司
 */
@property (nonatomic,copy) NSString * logisticsCompany;

/**
 * 运单号
 */
@property (nonatomic,copy) NSString *  logisticsNo;

/**
 * 物流公司KEY
 */
@property (nonatomic,copy) NSString *  logisticsCompanyKey;

/**
 * 发货时间
 */
@property (nonatomic,copy) NSString *  deliveryTime;//Date

/**
 * 相关交易订单
 */
@property (nonatomic,strong) TradeOrder *tradeOrder;

/**
 * 操作单项
 */
@property (nonatomic,strong) NSMutableArray <__kindof OrderOperateItem *> * orderOperateItems;//OrderOperateItem

/**
 * 备注
 */
@property (nonatomic,copy) NSString * remark;

/**
 * 询盘ID
 */
@property (nonatomic,copy) NSString * inquiryOrderId;

/**
 * 询盘订单编号
 */
@property (nonatomic,copy) NSString * inquiryOrderCode;

/**
 * 询盘订单
 */
@property (nonatomic,strong) InquiryOrder * inquiryOrder;

/**
 * 关联的操作订单ID
 * 收货关联发货，验货关联收货,退货关联收货、验货
 */
@property (nonatomic,copy) NSString * linkOperateId;

/**
 * 操作单号
 */
@property (nonatomic,copy) NSString * operateCode;

/**
 * 发货号
 */
@property (nonatomic,copy) NSString * deliverCode;

/**
 * 入库单号-收货单号
 */
@property (nonatomic,copy) NSString * receiveCode;

/**
 * 验货单号
 */
@property (nonatomic,copy) NSString * inspectCode;

/**
 * 退货单号
 */
@property (nonatomic,copy) NSString * refundCode;

/**
 * 送货单号
 */
@property (nonatomic,copy) NSString * deliverNumber;

/**
 * 是否系统操作
 */
@property (nonatomic,strong) NSNumber * isSys;//Integer

/**
 * 是否预发货单
 */
@property (nonatomic,strong) NSNumber * isPre;//Integer

/**
 * 操作人ID
 * 注：透明工厂默认为供应商用户信息
 */
@property (nonatomic,copy) NSString * memberId;

/**
 * 操作人
 */
@property (nonatomic,strong) Member * member;

/**
 * 企业主键
 */
@property (nonatomic,copy) NSString * manufacturerId;

/**
 * 是否全部收货（发货单）
 */
@property (nonatomic,strong) NSNumber * isReceived;//Integer

/**
 * 是否验货完成（入库单）
 */
@property (nonatomic,strong) NSNumber * isInspect;//Integer

/**
 * 平台（0-透明工厂；1-非标管家）
 */
@property (nonatomic,strong) NSNumber * platform;//Integer

/**
 * 出入库类型
 */
@property (nonatomic,copy) NSString * storageType;//StorageType

/**
 * 补发货状态（验货单）
 * 0-不需要；1-需要；2-已生成发货单
 */
@property (nonatomic,strong) NSNumber * needSend;//Integer

/**
 * 已收货次数（累计）
 * 收货时，更新发货单项（到货单）
 */
@property (nonatomic,strong) NSNumber * receiveNums;//Integer

/**
 * 已收货数量(累计)
 * 收货时，更新发货单（到货单）
 */
@property (nonatomic,strong) NSNumber * receiveQuantity;//Integer

/**
 * 退货数量（累计）
 * 退货时，更新收货单（入库单）
 */
@property (nonatomic,strong) NSNumber * refundQuantity;//Integer

/**
 * 退货数量（累计）-展示用
 * 退货时，更新发货单（到货单）
 */
@property (nonatomic,strong) NSNumber * deRefundQuantity;//Integer

/**
 * 提交时间（注：验货单为验货完成时间）
 */
@property (nonatomic,copy) NSString *  inspectTime;//Date

/**
 * 根据收货次数累加
 * 验货单及退货单记录当前收货单序号
 */
@property (nonatomic,strong) NSNumber * receiveIndex;//Integer

/**
 * 操作类型
 */
@property (nonatomic,strong) NSMutableArray * sei_orderOperateType;//OrderOperateType[]

/**
 * 补发货状态
 */
@property (nonatomic,strong) NSMutableArray * sei_needSend;//Integer[]

/**
 * 验货完成时间（回填到收货单（入库单））
 */
@property (nonatomic,copy) NSString * receviceInspecTime;//Date

/**
 * 验货状态（回填到入库单）
 * 0-验货通过；1-验货不通过
 * 有一个零件次品数量大于0，就默认整单验货 不通过）
 */
@property (nonatomic,strong) NSNumber * inspecStatus;//Integer

/**
 * 已验货数量（累计回填到入库单）
 */
@property (nonatomic,strong) NSNumber * inspecQuantity;//Integer

/**
 * 供应商是否需拿货（验货单）
 * 0-否；1-是；2-已拿货
 */
@property (nonatomic,strong) NSNumber * isSupplierRecevice;//Integer

/**
 * 供应商拿货时间（验货单）
 */
@property (nonatomic,copy) NSString *  supplierReceviceTime;//Date

/**
 * 关联的单据实体
 */
@property (nonatomic,strong) OrderOperate * sec_linkOrderOperate;

/**
 * 收货时间（退货单、验货单）
 */
@property (nonatomic,copy) NSString * receviceTime;//Date

/**
 * 要求到货日期-预发货单
 */
@property (nonatomic,copy) NSString * deadlineTime;//Date

/**
 * 是否未发货完成
 * 0-否；1-是；
 */
@property (nonatomic,strong) NSNumber * isNotShipped;//Integer

/**
 * 模糊查询订单编号
 */
@property (nonatomic,copy) NSString * se_orderCode;

/**
 * 模糊查询操作编号
 */
@property (nonatomic,copy) NSString * se_operateCode;

/**
 * 模糊查询发货单号
 */
@property (nonatomic,copy) NSString * se_deliverCode;

/**
 * 模糊查询供应商名称
 */
@property (nonatomic,copy) NSString * se_to__supplierEnterpriseName;

/**
 * 杂费
 */
@property (nonatomic,strong) NSNumber * cost;//BigDecimal

/**
 * 运费
 */
@property (nonatomic,strong) NSNumber * shipPrice;//BigDecimal

/**
 * 小计
 */
@property (nonatomic,strong) NSNumber * subtotalPrice;//BigDecimal

/**
 * 总计
 */
@property (nonatomic,strong) NSNumber * totalPrice;//BigDecimal

/**
 * 供应商税率
 */
@property (nonatomic,strong) NSNumber * supplierTaxRate;//Double

/**
 * 查询内部订单号
 */
@property (nonatomic,copy) NSString * se_insideOrderCode;

/**
 * 订单采购商企业ID（UC）
 */
@property (nonatomic,copy) NSString * to__purchaseEnterpriseId;

/**
 * 验货类型
 * 0-无系统验货；1-有部分系统验货；2-完全系统验货
 */
@property (nonatomic,strong) NSNumber * inspectType;//Integer

/**
 * 是否是透明工厂单据
 * 0-否；1-是
 */
@property (nonatomic,strong) NSNumber * isTpf;//Integer

/**
 * 查询收货单号
 */
@property (nonatomic,copy) NSString * se_receiveCode;

/**
 * 质检报告文件别名（上传时的文件名称）
 */
@property (nonatomic,copy) NSString * qualityReportFileName;

/**
 * 质检报告文件的真名
 */
@property (nonatomic,copy) NSString * qualityReportFileRealName;

/**
 * 质检报告文件路径（全路径 ModuleFilePath表文件路径+FileExplanation表文件子路径）
 */
@property (nonatomic,copy) NSString * qualityReportFilePath;

/**
 * OSS存储空间名称
 */
@property (nonatomic,copy) NSString * qualityReportFileBucketName;

/**
 * 质检报告文件ID
 */
@property (nonatomic,copy) NSString * qualityReportFileId;

/**
 * 质检报告是否上传
 */
@property (nonatomic,strong) NSNumber * isUploadQualityReport;//Integer

/**
 * 结束收货（发货单）
 * 1-结束
 */
@property (nonatomic,strong) NSNumber * isEndReceived;//Integer

/**
 * 订单状态
 */
@property (nonatomic,copy) NSString * tradeOrderPurchaseStatus;//TradeOrderPurchaseStatus

/**
 * 2018.6.19-新增需求
 * 是否是补发货(用于区分补发货单对应的收、验、退单)：1-是；0-否
 * 从补发货单（SR）带入收货单（入库单）、验货单
 */
@property (nonatomic,strong) NSNumber * isReissue;//Integer

//---------------2018.6.22更新--订单采购商及供应商-----------
/**
 * 采购商
 */
@property (nonatomic,strong) Member * purchaseMember;

/**
 * 采购商企业ID
 */
@property (nonatomic,copy) NSString * purchaseManufacturerId;

/**
 * 供应商
 */
@property (nonatomic,strong) Member * supplierMember;

/**
 * 供应商企业ID
 */
@property (nonatomic,copy) NSString * supplierManufacturerId;

//---------------2018.6.22更新--订单采购商及供应商END-----------

//-------------------2018.7.11零件项数及数量（应收、实收）BG--------------------------
/**
 * 应收零件项
 */
@property (nonatomic,strong) NSNumber * reItems;//Integer

/**
 * 应收零件总数
 */
@property (nonatomic,strong) NSNumber * reIntemNums;//Integer

/**
 * 实收零件项
 */
@property (nonatomic,strong) NSNumber * acItems;//Integer

/**
 * 实收零件总数
 */
@property (nonatomic,strong) NSNumber * acItemNums;//Integer
//-------------------2018.7.11零件项数及数量（应收、实收）END--------------------------


@end
