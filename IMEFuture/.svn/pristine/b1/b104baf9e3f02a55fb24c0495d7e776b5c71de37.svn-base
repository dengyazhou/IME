//
//  TradeOrder.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/8/3.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseAddress.h"

@class Member;
@class TradeOrderItem;

#import "PurchaseProject.h"

@interface TradeOrder : BaseAddress

/**
 * 订单主键
 */
@property (nonatomic,copy) NSString * orderId;
/**
 * 模糊查询询盘号
 */
@property (nonatomic,copy) NSString * se_enterpriseOrderCode;
/**
 * 模糊查询内部订单号
 */
@property (nonatomic,copy) NSString * se_insideOrderCode;
/**
 * 状态
 */
@property (nonatomic,copy) NSString * tradeOrderPurchaseStatus;//TradeOrderPurchaseStatus
/**
 * 模糊查询供应商企业名
 */
@property (nonatomic,copy) NSString * se_supplierEnterpriseName;
/**
 * 模糊查询采购商企业名
 */
@property (nonatomic,copy) NSString * se_purchaseEnterpriseName;
/**
 * 授单员
 */
@property (nonatomic,copy) NSString * se_sendName;
/**
 * 查询期望交货日期
 */
@property (nonatomic,copy) NSString * seb_deliveryDeadline;//Date
/**
 * 查询期望交货日期
 */
@property (nonatomic,copy) NSString * see_deliveryDeadline;//Date
/**
 * 查询订单生成时间
 */
@property (nonatomic,copy) NSString * seb_createTime;//Date
/**
 * 查询订单生成时间
 */
@property (nonatomic,copy) NSString * see_createTime;//Date
/**
 * 零件类型
 */
@property (nonatomic,copy) NSString * partType;//PartType
/**
 * 加工类型
 */
@property (nonatomic,copy) NSString * processType;//ProcessType
/**
 * 采购组
 */
@property (nonatomic,copy) NSString * se_firstPurchasingGroup;
/**
 * 对接状态
 * 1-失败；0-成功
 */
@property (nonatomic,strong) NSNumber *  isNeedReNotify;//Integer
/**
 * 所属项目
 */
@property (nonatomic,copy) NSString * se_ownProjectName;
/**
 * 订单状态批量查询
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> *sei_tradeOrderPurchaseStatus; //TradeOrderPurchaseStatus 枚举
/**
 * 审核意见
 */
@property (nonatomic,copy) NSString * confirmMsg;
/**
 * 拒绝意见
 */
@property (nonatomic,copy) NSString * refuseMsg;
/**
 * 验收状态 1-通过;0-不通过
 */
@property (nonatomic,strong) NSNumber *  purchaseAcceptStatus;
/**
 * 服务订单验收不通过原因
 */
@property (nonatomic,copy) NSString * purchaseAccpetMsg;
/**
 * 服务件验收报告文件名
 */
@property (nonatomic,copy) NSString * acceptFileName;
/**
 * 服务件验收报告文件的真名
 */
@property (nonatomic,copy) NSString * acceptFileRealName;
/**
 * 服务件验收报告文件路径
 * 全路径 ModuleFilePath表文件路径+FileExplanation表文件子路径
 */
@property (nonatomic,copy) NSString * acceptFilePath;
/**
 * 服务件验收报告OSS存储空间名称
 */
@property (nonatomic,copy) NSString * acceptBucketName;
/**
 * 超期提醒类型
 */
@property (nonatomic,strong) NSNumber * remindId;//Integer
/**
 * 关闭订单原因
 */
@property (nonatomic,copy) NSString * closeMsg;
/**
 * 跟进人ID
 */
@property (nonatomic,copy) NSString * purchaseFollowerId;
/**
 * 修改的订单明细
 */
@property (nonatomic,strong) NSMutableArray <__kindof TradeOrderItem *> *orderItems;//TradeOrderItem

















/**
 * 订单编号
 */
@property (nonatomic,copy) NSString *orderCode;

/**
 * 询盘订单Id
 */
@property (nonatomic,copy) NSString * inquiryOrderId;

/**
 * 询盘订单编号
 */
@property (nonatomic,copy) NSString * inquiryOrderCode;

/**
 * 内部询盘号-2018.9.12新增
 * 各企业自己内部递增的询盘号
 * eg:081205001 年月日加3位顺序数字
 */
@property (nonatomic,copy) NSString * enterpriseOrderCode;

/**
 * 内部订单号
 * 询盘带入
 */
@property (nonatomic,copy) NSString * insideOrderCode;

//============20170106采购项目相关 begin=================
/**
 * 采购项目管理
 */
@property (nonatomic,strong) PurchaseProject * project;

/**
 * 采购项目管理Id
 */
@property (nonatomic,copy) NSString * projectId;

/**
 * 是否被采购项目所引用
 */
@property (nonatomic,strong) NSNumber * hasProject;//Integer
//============20170106采购项目相关 end=================

/**
 * 采购商
 */
@property (nonatomic,strong) Member *purchaseMember;

/**
 * 采购商用户Id
 */
@property (nonatomic,copy) NSString *purchaseMemberId;

/**
 * 采购商企业id（ucenter企业ID）
 */
@property (nonatomic,copy) NSString *purchaseEnterpriseId;

/**
 * 采购商企业名
 */
@property (nonatomic,copy) NSString *purchaseEnterpriseName;

/**
 * 采购商账期
 */
@property (nonatomic,strong) NSNumber *purchaseAccountPeriod;//Integer

/**
 * 供应商用户Id
 */
@property (nonatomic,copy) NSString *supplierMemberId;

/**
 * 供应商企业id（ucenter企业ID）
 */
@property (nonatomic,copy) NSString *supplierEnterpriseId;

/**
 * 供应商企业编号
 */
@property (nonatomic,copy) NSString *supplierSerialNo;

/**
 * 供应商企业名
 */
@property (nonatomic,copy) NSString *supplierEnterpriseName;

/**
 * 供应商账期
 */
@property (nonatomic,strong) NSNumber *supplierAccountPeriod;//Integer

/**
 * 供应商状态
 */
@property (nonatomic,copy) NSString *tradeOrderSupplierStatus;

/**
 * 是否加急
 */
@property (nonatomic,strong) NSNumber *isUrgent;//Integer

/**
 * 期望收货日期
 */
@property (nonatomic,copy) NSString *deliveryDeadline;//Date

/**
 * 询盘标题
 */
@property (nonatomic,copy) NSString *title;

/**
 * 交易单项
 */
@property (nonatomic,strong) NSMutableArray <__kindof TradeOrderItem *> *tradeOrderItems;//TradeOrderItem

/**
 * 零件数量
 */
@property (nonatomic,strong) NSNumber *count;//Integer

/**
 * 零件报价数量
 */
@property (nonatomic,strong) NSNumber * quotedPriceCount;//Integer

/**
 * 运送方式
 */
@property (nonatomic,copy) NSString *deliveryMethod;//A("快递"),B("汽运"),C("水运"),D("铁道运输"),E("空运"),F("不限");

/**
 * 杂费
 */
@property (nonatomic,strong) NSNumber *cost;//doubel

/**
 * 运费
 */
@property (nonatomic,strong) NSNumber *shipPrice;//doubel

/**
 * 小计
 */
@property (nonatomic,strong) NSNumber *subtotalPrice;//doubel

/**
 * 总计
 */
@property (nonatomic,strong) NSNumber *totalPrice;//doubel

/**
 * 供应商税率差额
 */
@property (nonatomic,strong) NSNumber *supplierTaxRateDifference;//doubel

/**
 * 供应商开票额
 */
@property (nonatomic,strong) NSNumber *supplierInvoiceAmount;//doubel

/**
 * 采购商支付金额
 */
@property (nonatomic,strong) NSNumber *purchasePaymentAmount;//doubel

/**
 * 支付方式
 */
@property (nonatomic,copy) NSString *payType;//A("支付宝"),W("微信"),L("余额"),C("信用"),P("平安见证宝"),B("银行");

/**
 * 备注
 */
@property (nonatomic,copy) NSString *remark;

/**
 * 采购商授盘备注
 */
@property (nonatomic,copy) NSString *purchaseSendRemark;

/**
 * 供应商备注
 */
@property (nonatomic,copy) NSString *supplierRemark;

/**
 * 付款结束时间
 */
@property (nonatomic,copy) NSString *paymentEndTime;//Date

/**
 * 创建担保交易标志
 */
@property (nonatomic,strong) NSNumber * createGuaranteeTrade;//Boolean

/**
 * 平安验证支付密码流水号
 */
@property (nonatomic,copy) NSString * thirdLogNo;

//--------------- 20170524无注册流程 beg ------------------
/**
 * 是否需要推送ERP
 */
@property (nonatomic,strong) NSNumber * needPushErp;//Integer

/**
 * 是否是临时用户生成的订单
 */
@property (nonatomic,strong) NSNumber * isTemporary;//Integer

/**
 * 订单合并状态
 * 0-无需合并；2-待合并；1-已合并
 */
@property (nonatomic,strong) NSNumber * mergeStatus;//Integer
//--------------- 20170524无注册流程 end ------------------

/**
 * 催发货时间
 */
@property (nonatomic,copy) NSString * callSendTm;//Date

/**
 * IP地址
 */
@property (nonatomic,copy) NSString * ipAddress;
/**
 * 银行回调地址
 */
@property (nonatomic,copy) NSString * callBackUrl;

/**
 * 银行返回签名串
 */
@property (nonatomic,copy) NSString * sign;

/**
 * 付款时间
 */
@property (nonatomic,copy) NSString *paymentTime;//Date

/**
 * 发货时间
 */
@property (nonatomic,copy) NSString *deliveryTime;//Date

/**
 * 确认收货时间
 */
@property (nonatomic,copy) NSString *confirmDeliveryTime;//Date

/**
 * 采购商验货时间
 */
@property (nonatomic,copy) NSString * examineCargoTime;//Date

/**
 * 采购商是否评论
 */
@property (nonatomic,strong) NSNumber *purchaseIsComment;//Boolean

/**
 * 采购商评价时间
 */
@property (nonatomic,copy) NSString *purchaseCommentTime;//Date

/**
 * 供应商是否评论
 */
@property (nonatomic,strong) NSNumber *supplierIsComment;//Boolean

/**
 * 供应商评价时间
 */
@property (nonatomic,copy) NSString *supplierCommentTime;//Date

/**
 * 最后通知日期
 */
@property (nonatomic,copy) NSString *notifyDate;//Date

/**
 * 平台是否已打款
 */
@property (nonatomic,strong) NSNumber *platformIsPayment;//Boolean

/**
 * 文件别名（上传时的文件名称）
 */
@property (nonatomic,copy) NSString *fileName;

/**
 * 文件的真名
 */
@property (nonatomic,copy) NSString *fileRealName;

/**
 * 文件路径（全路径 ModuleFilePath表文件路径+FileExplanation表文件子路径）
 */
@property (nonatomic,copy) NSString *filePath;

/**
 * OSS存储空间名称
 */
@property (nonatomic,copy) NSString *fileBucketName;

/**
 * 文件ID
 */
@property (nonatomic,copy) NSString *fileId;

//------161230 BOM表相关 begin-------------
/**
 * 是否匹配图纸云
 */
@property (nonatomic,strong) NSNumber * isMatchDrawingCloud;//Integer

/**
 * 图纸版本
 */
@property (nonatomic,copy) NSString *picVersion;

/**
 * 零件号
 */
@property (nonatomic,copy) NSString *partNumber;

/**
 * 图纸云零件ID
 */
@property (nonatomic,copy) NSString * partId;

/**
 * 用户定制的工艺
 * 以.工艺名.分割
 */
@property (nonatomic,copy) NSString *customTags;
//------161230 BOM表相关 end---------------

/**
 * 取消原因
 */
@property (nonatomic,copy) NSString *cancelMsg;

/**
 * 供应商税率
 */
@property (nonatomic,strong) NSNumber * supplierTaxRate;//Double

/**
 * 供应商佣金
 */
@property (nonatomic,strong) NSNumber * supplierCommision;//Double

/**
 * 询盘类型
 */
@property (nonatomic,copy) NSString * inquiryType;//InquiryType 枚举

/**
 * 取消时间
 */
@property (nonatomic,copy) NSString *cancelTm;//Date

/**
 * 取消人
 */
@property (nonatomic,copy) NSString *cancelName;

/**
 * 取消人Id
 */
@property (nonatomic,copy) NSString *cancelId;

/**
 * 透明工厂状态是否开通
 */
@property (nonatomic,strong) NSNumber *isEnbleFactory;//Boolean

/**
 * 物流公司KEY
 */
@property (nonatomic,copy) NSString * logisticsCompanyKey;

/**
 * 物流公司
 */
@property (nonatomic,copy) NSString * logisticsCompany;

/**
 * 运单号
 */
@property (nonatomic,copy) NSString *logisticsNo;

/**
 * 物流备注
 */
@property (nonatomic,copy) NSString *logisticsRemark;

/**
 * 采购商付款状态
 */
//PAID("已付款"),
//NONPAYMENT("未付款"),
//NONEEDTOPAY("无需付款");
@property (nonatomic,copy) NSString * purchasePayStatus;//PurchasePayStatus

/**
 * 文件别名（上传时的文件名称）
 */
@property (nonatomic,copy) NSString *qualityReportFileName;

/**
 * 文件的真名
 */
@property (nonatomic,copy) NSString *qualityReportFileRealName;

/**
 * 文件路径（全路径 ModuleFilePath表文件路径+FileExplanation表文件子路径）
 */
@property (nonatomic,copy) NSString *qualityReportFilePath;

/**
 * OSS存储空间名称
 */
@property (nonatomic,copy) NSString *qualityReportFileBucketName;

/**
 * 文件ID
 */
@property (nonatomic,copy) NSString *qualityReportFileId;

/**
 * 质量报告是否上传
 */
@property (nonatomic,strong) NSNumber *isUploadQualityReport;//Boolean

/**
 * 缩略图地址
 */
@property (nonatomic,copy) NSString *thumbnailUrl;

/**
 * 今天是否要通知
 */
@property (nonatomic,strong) NSNumber *sec_isNotifyTodDay;//Boolean

/**
 * 搜索内容
 */
@property (nonatomic,copy) NSString *sec_searchInfo;

/**
 * 供应商状态查询
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> *sei_tradeOrderSupplierStatus; //TradeOrderSupplierStatus 枚举

//------170224 两种议价托管 begin -------------
/**
 * 是否可以修改价格
 */
@property (nonatomic,strong) NSNumber * canEditPrice;//Integer
//------170224 两种议价托管 end -------------

//------170425 对账标识 begin -------------
/**
 * 是否已对账
 */
@property (nonatomic,strong) NSNumber * supplierHasBalance;//Integer

/**
 * 是否已对账
 */
@property (nonatomic,strong) NSNumber *purchaseHasBalance;//Integer
//------170425 对账标识 end -------------

/**
 * 询盘单类型
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> *sei_inquiryType; //InquiryType 枚举

/**
 * 不符合的询盘单类型
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> *seo_inquiryType;//InquiryType 枚举

/**
 * 是否是特殊查询 采购商企业ID和供应商企业ID数组是或查询
 */
@property (nonatomic,strong) NSNumber * isSpecialQuery;//Boolean
/**
 * 采购商企业ID查询
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sei_purchaseEnterpriseId;

/**
 * 供应商企业ID查询
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sei_supplierEnterpriseId;
/**
 * Like查询供应商企业名
 */
@property (nonatomic,copy) NSString * sec_supplierEnterpriseNameLike;
/**
 * Like查询采购商企业名
 */
@property (nonatomic,copy) NSString * sec_purchaseEnterpriseNameLike;

/**
 * 是否延期
 */
@property (nonatomic,strong) NSNumber * hasDelay;//boolean

/**
 * 托管订单评价内容
 */
@property (nonatomic,copy) NSString * content;
/**
 * 托管订单评价值
 */
@property (nonatomic,strong) NSNumber * averageScore;//Double

//--------------------------2017.3.28发货信息BEGIN----------------------
/**
 * 发货状态
 * 0-未发货；1-部分发货；2-已发货
 */
@property (nonatomic,strong) NSNumber * deliverStatus;//Integer

/**
 * 发货次数(累计)
 */
@property (nonatomic,strong) NSNumber * deliverNum;//Integer

/**
 * 发货订单项数量是否完全匹配
 */
@property (nonatomic,strong) NSNumber *isMatch;//Integer
//--------------------------2017.3.28发货信息END----------------------

/**
 * 订单要求
 */
@property (nonatomic,copy) NSString * tradeOrderRemark;

/**
 * 询盘标题模糊查询
 */
@property (nonatomic,copy) NSString * se_title;

/**
 * 查询总价
 */
@property (nonatomic,strong) NSNumber * seb_totalPrice;//BigDecimal

/**
 * 查询总价
 */
@property (nonatomic,strong) NSNumber * see_totalPrice;//BigDecimal

/**
 * 供应商
 */
@property (nonatomic,strong) Member * supplierMember;

/**
 * 收货状态
 * 0-未收货；1-部分收货；2-已收货
 */
@property (nonatomic,strong) NSNumber * receiveStatus;//Integer

/**
 * 可验货次数（收货时累计、验货累减）
 */
@property (nonatomic,strong) NSNumber * inspectNum;//Integer

/**
 * 是否需要补发货
 */
@property (nonatomic,strong) NSNumber * needReissue;//Integer

/**
 * 是否有过补发货
 * 0-无；1-有
 */
@property (nonatomic,strong) NSNumber * hasReissue;//Integer


/**
 * 收货状态
 * 0-待收货；1-成功订单
 */
@property (nonatomic,strong) NSNumber * sec_receviceType;//Integer

/**
 * 订单发货状态
 */
@property (nonatomic,strong) NSMutableArray * sei_deliverStatus;//Integer[]

/**
 * 验货状态
 * 0-待验货；1-已验货；2-成功订单
 */
@property (nonatomic,strong) NSNumber * sec_inspectType;//Integer

/**
 * 订单关闭时间
 */
@property (nonatomic,copy) NSString *  closeTime;//Date

/**
 * 订单激活时间
 */
@property (nonatomic,copy) NSString *  activationTime;//Date

/**
 * 采购商原有状态
 * 在订单关闭时，记录当前订单状态
 */
@property (nonatomic,copy) NSString * originalPurchaseStatus;//TradeOrderPurchaseStatus

/**
 * 是否预发货单
 */
@property (nonatomic,strong) NSNumber * isPre;//Integer

/**
 * 供应商原有状态
 * 在订单关闭时，记录当前订单状态
 */
@property (nonatomic,copy) NSString * originalSupplierStatus;//TradeOrderPurchaseStatus

//----------2017.12.13-补发货收发货时间（最后）-BG-----
/**
 * 补发-发货时间(最近一次)
 */
@property (nonatomic,copy) NSString * reDeliveryTime;//Date

/**
 * 补发-收货时间(最近一次)
 */
@property (nonatomic,copy) NSString * reReceviceTime;//Date
//----------2017.12.13-收发货时间（最后）、补发货收发货时间（最后）-END-----

/**
 * 是否是线下签约
 */
@property (nonatomic,strong) NSNumber * isOfflineSign;//Integer


//---------------------2018.2.8金额变更、对账相关-----------------------------
/**
 * 原总计值
 */
@property (nonatomic,strong) NSNumber * originalTotalPrice;//BigDecimal

/**
 * 订单金额变更状态
 * 当状态在1的或者balanceType等于1、3状态时，不可发起新的申请
 * 0-未申请；1-申请变更中；2-同意；3-拒绝；4-撤销
 */
@property (nonatomic,strong) NSNumber * priceChangeStatus;//Integer

/**
 * 累计变更金额（可为负数）
 * 申请同意后累计
 */
@property (nonatomic,strong) NSNumber * accAmount;//BigDecimal

/**
 * 申请的变更金额（末次，暂时不累计）
 */
@property (nonatomic,strong) NSNumber * applyAmount;//BigDecimal

/**
 * 对账状态
 * priceChangeStatus为1或3的时候，不可发起申请
 * 0-未对账；1-对账中；2-对账拒绝；3-完成
 */
@property (nonatomic,strong) NSNumber * balanceType;//Integer

/**
 * 对账成功时间
 */
@property (nonatomic,copy) NSString * balanceTime;//Date

/**
 * 对账单号
 */
@property (nonatomic,copy) NSString * balanceCode;

/**
 * 对账单ID
 */
@property (nonatomic,copy) NSString * balanceId;

/**
 * 是否无需对账
 * 0-需对账（默认）；1-无需对账
 */
@property (nonatomic,strong) NSNumber * isNoNeedBalance;//Integer
//---------------------2018.2.8金额变更相关END-----------------------------

/**
 * 验货完成时间（开始）
 */
@property (nonatomic,copy) NSString *seb_examineCargoTime;//Date

/**
 * 验货完成时间（结束）
 */
@property (nonatomic,copy) NSString *see_examineCargoTime;//Date

/**
 * 查询订单变更状态
 */
@property (nonatomic,strong) NSMutableArray * sei_priceChangeStatus;//Integer[]

/**
 * 根据ID查询订单
 */


@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sei_orderId;//String[]

/**
 * 供应商企业ID
 */
@property (nonatomic,copy) NSString * supplierManufacturerId;

/**
 * 采购商企业ID
 */
@property (nonatomic,copy) NSString * purchaseManufacturerId;

/**
 * 对账完成类型
 * 0-正常流程完成对账；1-线下供应商验货完成自动完成对账；2-用户自行设置的无需对账（对账完成）
 * 3-一些老数据，以前手动设置的供应商已对账（supplierHasBalance=1时）
 */
@property (nonatomic,strong) NSNumber * completeBalanceType;//Integer

/**
 * 其他税率
 */
@property (nonatomic,strong) NSMutableArray * seo_supplierTaxRate;//Double[]

/**
 * 跟进人
 */
@property (nonatomic,strong) Member * purchaseFollower;

/**
 * 查询跟进人名称
 */
@property (nonatomic,copy) NSString * se_pf__childAccount;

/**
 * 查询未指定采购员订单
 */
@property (nonatomic,strong) NSNumber * sec_noFollower;//Integer

/**
 * 普通订单采购商状态查询
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sei_comTradeOrderPurchaseStatus;//TradeOrderPurchaseStatus[]

/**
 * 末次修改订单编号时候
 */
@property (nonatomic,strong) NSDate * operateOrderCodeTime;

/**
 * 末次修改订单编号用户ID
 */
@property (nonatomic,copy) NSString * operateOrderCodeMemberId;

/**
 * 末次修改订单编号用户名（childAccount）
 */
@property (nonatomic,copy) NSString * operateOrderCodeMemberName;

/**
 * 2018.6.20新增
 * 订单金额确认时间（价格确认）
 */
@property (nonatomic,copy) NSString * confirmAmountTime;//Date

/**
 * 议价询盘采购已报价
 */
@property (nonatomic,strong) NSNumber * purchaseHasQued;//Integer

/**
 * 议价询盘供应商已报价
 */
@property (nonatomic,strong) NSNumber * supplierHasQued;//Integer

//----------------------------2018.8.22-ERP对接新增---begin----------------------------
/**
 * ERP是否查询过
 */
@property (nonatomic,strong) NSNumber * hasErpSelect;//Integer

/**
 * ERP末次查询时间
 */
@property (nonatomic,copy) NSString * selectDate;//Date

/**
 * ERP是否对接采购订单号
 */
@property (nonatomic,strong) NSNumber *  hasSetErpCode;//Integer

/**
 * ERP采购订单号
 */
@property (nonatomic,copy) NSString * erpOrderCode;

/**
 * ERP对接采购订单号时间
 */
@property (nonatomic,copy) NSString * setErpCodeDate;//Date

/**
 * 审批标识
 * C-审批通过
 */
@property (nonatomic,copy) NSString * orderApprovalLabel;

/**
 * 所属项目名(erp或图纸云)
 * 对接前可以随意修改
 */
@property (nonatomic,copy) NSString * ownProjectName;

/**
 * 采购申请类型(erp或图纸云)
 * 对接前可以随意修改
 */
@property (nonatomic,copy) NSString * applyType;

/**
 * 采购申请单号(erp或者图纸云，但是图纸云允许为空)
 */
@property (nonatomic,copy) NSString * applyNumber;

/**
 * 采购申请的id(图纸云)
 */
@property (nonatomic,copy) NSString * bomId;

/**
 * 该询盘创建时采购商企业是否开启了ERP对接
 */
@property (nonatomic,strong) NSNumber *  isOpenErp;//Integer

/**
 * 零件是否全部都来源于Erp
 */
@property (nonatomic,strong) NSNumber *  isSourceErp;//Integer

/**
 * 零件是否全部都来源于DrawingCloud
 */
@property (nonatomic,strong) NSNumber *  isSourceDrawingCloud;//Integer
//----------------------------2018.8.22-ERP对接新增---end----------------------------


@property (nonatomic,strong) NSNumber * bargainStatus;//Integer

/**
 * 是否是核价(比价)报价
 * 1-是；0-否
 */
@property (nonatomic,strong) NSNumber * isDesignated;//Integer

@property (nonatomic,copy) NSString *sendTm;

@property (nonatomic,copy) NSString *sendName;

@end
