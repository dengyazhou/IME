//
//  PurchaseProjectInfo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/1/6.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BaseCustomField.h"
#import "PurchaseProject.h"
#import "InquiryOrder.h"
#import "TradeOrder.h"
#import "AccVersionInter.h"
#import "BatchDeliverItem.h"
#import "PurchaseProjectFile.h"

@interface PurchaseProjectInfo : BaseCustomField

//private static final long serialVersionUID = 1533472537920867978L;

/**
 * 主键
 */
@property (nonatomic,copy) NSString * purchaseProjectInfoId;

/**
 * 所属的采购管理项目
 */
@property (nonatomic,strong) PurchaseProject * project;

@property (nonatomic,copy) NSString *DYZid;

/**
 * 所属的采购管理项目Id
 */
@property (nonatomic,copy) NSString * projectId;

/**
 * 创建采购项目的企业Id
 */
@property (nonatomic,copy) NSString * manufacturerId;

//询盘单回填 beg -----------------------------

/**
 * 关联的询盘单
 */
@property (nonatomic,strong) InquiryOrder * inquiryOrder;

/**
 * 关联的询盘类型
 */
@property (nonatomic,copy) NSString * inquiryType; //InquiryType

/**
 * 关联的询盘单Id
 */
@property (nonatomic,copy) NSString * inquiryOrderId;

/**
 * 关联的询盘单编号
 */
@property (nonatomic,copy) NSString * inquiryOrderCode;

/**
 * 关联的询盘单标题
 */
@property (nonatomic,copy) NSString * inquiryTitle;


/**
 * 询盘订单项ID
 */
@property (nonatomic,copy) NSString * inquiryOrderItemId;

/**
 * 实际数量
 * 现为采购数量
 */
@property (nonatomic,strong) NSNumber *  num;//Integer

/**
 * 用户多次发货详情
 */
@property (nonatomic,copy) NSString * batchDeliverItem;

/**
 * 预发货批次数
 * 复制询盘项的值
 */
@property (nonatomic,strong) NSNumber * batchDeliverNum;//Integer

/**
 * 规格
 */
@property (nonatomic,copy) NSString * specifications;

/**
 * 品牌
 */
@property (nonatomic,copy) NSString * brand;

/**
 * 是否预发货单
 */
@property (nonatomic,strong) NSNumber * isPre;//Integer

//询盘单回填 end -----------------------------

//交易订单回填 beg -----------------------------

/**
 * 关联的询盘单中供应商企业名
 */
@property (nonatomic,copy) NSString * enterpriseName;

/**
 * 关联的交易订单
 */
@property (nonatomic,strong) TradeOrder * tradeOrder;

/**
 * 关联的交易订单Id
 */
@property (nonatomic,copy) NSString *tradeOrderId;

/**
 * 关联的交易订单编号
 */
@property (nonatomic,copy) NSString * tradeOrderCode;

/**
 * 成交单价
 */
@property (nonatomic,strong) NSNumber *  price;//BigDecimal

//接盘时回填 end -----------------------------

//170320新增期望收货日期  beg -----------------------------
/**
 * 期望发货时间
 */
@property (nonatomic,copy) NSString * expectTakeDeliveryTm;
//170320新增期望收货日期 end -----------------------------

//订单收货时回填 beg -----------------------------
/**
 * 收货时间
 */


@property (nonatomic,copy) NSString * takeDeliveryTm;//Date

/**
 * 是否已经收货
 */
@property (nonatomic,strong) NSNumber * hasDelivery;//Integer

/**
 * 是否忽略当前零件不进行报价
 */
@property (nonatomic,strong) NSNumber * isSkip;//Integer

//订单收货时回填 end -----------------------------

/**
 * 行业
 */
@property (nonatomic,copy) NSString * industry;//Industry

/**
 * 用户定制的行业
 */
@property (nonatomic,copy) NSString * customIndustry;

/**
 * 最小单位
 */
@property (nonatomic,copy) NSString * quantityUnit;//QuantityUnit

/**
 * 用户自定义的最小单位
 */
@property (nonatomic,copy) NSString * customQuantityUnit;

/**
 * 一级材质名称
 */
@property (nonatomic,copy) NSString * materialName1;

/**
 * 一级材质ID
 */
@property (nonatomic,copy) NSString * materialId1;

/**
 * 二级材质名称
 */
@property (nonatomic,copy) NSString * materialName2;

/**
 * 二级材质ID
 */
@property (nonatomic,copy) NSString * materialId2;

/**
 * 是否是用户自定义的材质
 * 已经废弃
 */
@property (nonatomic,strong) NSNumber *  isCustomMaterial;//Integer

/**
 * 工艺
 * 以.工艺名.分割
 */
@property (nonatomic,copy) NSString * tags;

/**
 * 用户定制的工艺
 * 以.工艺名.分割
 */
@property (nonatomic,copy) NSString * customTags;

/**
 * 是否有新报价
 */
@property (nonatomic,strong) NSNumber * hasNewInquiry;//Integer

/**
 * 是否生成过询盘
 */
@property (nonatomic,strong) NSNumber * hasInquiryOrder;//Integer

/**
 * 是否生成过订单
 */
@property (nonatomic,strong) NSNumber *  hasTraderOrder;//Integer

/**
 * 是否有图纸
 * 匹配上图纸云，肯定有图纸。
 * 未匹配（没找到零件，或者匹配的零件无图纸）和用户手输，都视为没有图纸
 */
@property (nonatomic,strong) NSNumber *  hasPic;//Integer

/**
 * 是否线上订单
 */
@property (nonatomic,strong) NSNumber *  isOnline;//Integer

/**
 * 是否匹配零件
 */
@property (nonatomic,strong) NSNumber * isMatchPart;//Integer

/**
 * 是否匹配图纸云版本
 */
@property (nonatomic,strong) NSNumber * isMatchVersion;//Integer

/**
 * 是否匹配图纸库图纸
 */
@property (nonatomic,strong) NSNumber * isMatchDrawingCloud;//Integer

/**
 * 图纸版本
 */
@property (nonatomic,copy) NSString * picVersion;

/**
 * 零件号
 */
@property (nonatomic,copy) NSString * partNumber;

/**
 * 零件名
 */
@property (nonatomic,copy) NSString * partName;

/**
 * 图号
 */
@property (nonatomic,copy) NSString * figureNo;

/**
 * 物料号
 */
@property (nonatomic,copy) NSString * materialNumber;

/**
 * 参考数量
 * 已经废弃
 */
@property (nonatomic,copy) NSString * referenceNum;

/**
 * 参考单价
 */
@property (nonatomic,copy) NSString * referencePrice;

/**
 * 行号
 */
@property (nonatomic,strong) NSNumber *  lineNum;//Integer

/**
 * 自定义颜色
 */
@property (nonatomic,copy) NSString * colorStyle;//ColorStyle

/**
 * 催报价时间
 * 已废弃，移至询盘
 */
@property (nonatomic,copy) NSString *  callQuoTm;//Date

/**
 * 催发货时间
 * 已废弃，移至订单
 */
@property (nonatomic,copy) NSString * callSendTm;//Date

/**
 * 类型
 */
@property (nonatomic,copy) NSString * type;

/**
 * 地址
 */
@property (nonatomic,copy) NSString * address;

/**
 * 备注
 */
@property (nonatomic,copy) NSString * remark;

/**
 * 图纸信息
 */
@property (nonatomic,copy) NSString * purchaseProjectFileJson;

/**
 * 图纸数量
 */
@property(nonatomic,strong) NSNumber * purchaseProjectFileNum;//Integer

/*--------对接新增-------*/
/**
 * 指派人id
 */
@property (nonatomic,copy) NSString * memberId;

/**
 * 指派人名
 */
@property (nonatomic,copy) NSString * memberName;

/**
 * 指派人
 */
//(nullable = false)
@property(nonatomic,strong) Member * member;

/**
 * 来源
 */
@property(nonatomic,copy) NSString * source;//PartSourceType

/**
 * 税率
 */
@property(nonatomic,strong) NSNumber * tax;//Double

/**
 * 重量
 */
@property (nonatomic,copy) NSString * weight;

/**
 * 图纸格式
 */
@property (nonatomic,copy) NSString * picSuffix;
/**
 * 用于存储页面自定义颜色
 */

@property (nonatomic,copy) NSString * color;
/**
 * 申请人
 */

@property (nonatomic,copy) NSString * applyPerson;
/**
 * 申请日期
 */


@property (nonatomic,copy) NSString * applyTm;//Date
/**
 * 申请数量
 */
@property(nonatomic,strong) NSNumber * applyNum;//Integer
/**
 * 采购清单状态
 */
@property(nonatomic,copy) NSString * status;//ProjectInfoStatus
/**
 * 所属项目名
 */
@property (nonatomic,copy) NSString * ownProjectName;

/**
 * 尺寸 轮廓长
 */
@property (nonatomic,copy) NSString * outlineLong;

/**尺寸 轮廓宽*/
@property (nonatomic,copy) NSString * outlineWidth;

/**尺寸 轮廓高*/

@property (nonatomic,copy) NSString * outlineHeight;
/**
 * 存储相关的多次发货信息
 */
@property(nonatomic,strong) NSMutableArray <__kindof BatchDeliverItem *>* sec_batchDeliverItems;

/*--------对接新增end-------*/
/*---------ERP对接新增字段begin---------*/
/**
 * 图纸云bom零件主键
 */

@property (nonatomic,copy) NSString * bomAccId;

/**
 * 采购申请号
 */

@property (nonatomic,copy) NSString * applyNumber;
/**
 * 采购申请类型(erp或图纸云)
 */
@property (nonatomic,copy) NSString * applyType;
/**
 * 物料组
 */

@property (nonatomic,copy) NSString * materialGroup;
/**
 * 无聊描述
 */
@property (nonatomic,copy) NSString * materialDescription;
/**
 * 处理状态
 */

@property (nonatomic,copy) NSString * processingStatus;
/**
 * 审批标识
 */

@property (nonatomic,copy) NSString * approvalLabel;
/**
 * 审批状态
 */

@property (nonatomic,copy) NSString * approvalStatus;
/**
 * 成本中心
 */

@property (nonatomic,copy) NSString * costCenter;
/**
 * 结算标识
 */

@property (nonatomic,copy) NSString * settlementIdentifier;
/**
 * 联系人/电话
 */

@property (nonatomic,copy) NSString * linkMan;
/**
 * 工厂
 */

@property (nonatomic,copy) NSString * factory;
/**
 * 库存地点
 */

@property (nonatomic,copy) NSString * inventoryLocation;

/**
 * 采购说明
 */
@property (nonatomic,copy) NSString * purchaseDes;
/*---------ERP对接新增字段end---------*/
/**
 * 图纸信息
 */
@property(nonatomic,strong) NSMutableArray <__kindof PurchaseProjectFile *>* sec_purchaseProjectFiles;


@property (nonatomic,copy) NSString * se_materialName2;

/**
 * 查询询盘状态
 */
@property (nonatomic,copy) NSString * sec_inquiryOrderStatus;

/**
 * 查询订单状态
 */
@property (nonatomic,copy) NSString * sec_tradeOrderStatus;

/**
 * 企业ID
 */
@property (nonatomic,copy) NSString * sec_manufacturerId;

/**
 * 项目ID
 */
@property (nonatomic,copy) NSString * sec_projectId;

/**
 * 查询多个项目ID
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sei_projectId;

/**
 * 询盘ID
 */
@property (nonatomic,copy) NSString * sec_inquiryOrderId;

/**
 * 查询多个info 的 ID
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sei_purchaseProjectInfoId;

/**
 * fieldName
 */
@property (nonatomic,copy) NSString * sec_fieldName;

/**
 * 搜索memberId
 */

@property(nonatomic,strong) NSMutableArray <__kindof NSString *>* sei_memberId;

/**
 * 企业中心企业ID
 */
@property (nonatomic,copy) NSString * sec_enterpriseId;

@property (nonatomic,copy) NSString * sec_expectTm;

/**
 * 缩略图
 */
@property (nonatomic,copy) NSString * sec_previewUrl;

/**
 * 图纸ID
 */
@property (nonatomic,copy) NSString * sec_adId;

/**
 * 缩略图标识 1 显示默认的缩略图  2 显示未处理的默认缩略图 3 显示存在的缩略图
 */
@property (nonatomic,strong) NSNumber *  sec_previewFlag;//Integer

/**
 * 图纸列表
 */
@property (nonatomic,strong) NSMutableArray <__kindof AccVersionInter *> *sec_vesions;

/**
 * 匹配的图纸
 */
@property (nonatomic,strong)  AccVersionInter * sec_foundVersion;

/*采购清单筛选条件*/
/**
 * 有无目标价
 */

@property(nonatomic,strong) NSNumber * sec_hasPrice;//Boolean
/**
 * 搜索订单状态
 */

@property(nonatomic,strong) NSMutableArray<__kindof NSString *> * sec_tradeOrderPurchaseStatus;//TradeOrderPurchaseStatus[]
/**
 * 搜索询盘状态
 */

@property(nonatomic,strong) NSMutableArray<__kindof NSString *> * sec_inquiryStatus;//InquiryOrderStatus[]
/**
 * 查询线上线下
 */

@property(nonatomic,strong) NSNumber * sec_isOnline;//Integer
/**
 * 查询是否是（待发布询盘）
 */

@property(nonatomic,strong) NSNumber * sec_hasInquiryOrder;//Integer
/**
 * 查询订单创建人（实际上是询盘创建人）Id
 */

@property(nonatomic,strong) NSMutableArray <__kindof NSString *> * sei_ppiiom__memberId;

/**
 * 零件号
 */

@property(nonatomic,copy) NSString * se_partNumber;

/**
 *    指派人
 */

@property(nonatomic,copy) NSString * se_memberName;
/**
 * 所属项目
 */

@property(nonatomic,copy) NSString * se_ownProjectName;
/**
 * 供应商企业名
 */

@property(nonatomic,copy) NSString * se_ppito__supplierEnterpriseName;

/**
 * 要求到货时间
 * 开始
 */

@property(nonatomic,copy) NSString * seb_expectTakeDeliveryTm;//Date
/**
 * 模糊查询期望到货日期
 */

@property(nonatomic,copy) NSString * se_expectTakeDeliveryTm;

/**
 * 要求到货时间
 * 结束
 */

@property(nonatomic,copy) NSString * see_expectTakeDeliveryTm;//Date
/**
 * 订单号
 */

@property(nonatomic,copy) NSString * se_tradeOrderCode;
/**
 * 询盘号
 */

@property(nonatomic,copy) NSString * se_inquiryOrderCode;
/**
 * 物料号
 */

@property(nonatomic,copy) NSString * se_materialNumber;
/**
 * 零件名
 */

@property(nonatomic,copy) NSString * se_partName;
/**
 * 申请人
 */

@property(nonatomic,copy) NSString * se_applyPerson;
/**
 * 申请日期
 * 开始
 */

@property(nonatomic,copy) NSString * seb_applyTm;//Date
/**
 * 申请日期
 * 结束
 */

@property(nonatomic,copy) NSString * see_applyTm;//Date
/**
 * 搜索多个零件来源
 */

@property(nonatomic,strong) NSMutableArray <__kindof NSString *>* sei_source;//PartSourceType
/**
 * 地址
 */

@property(nonatomic,copy) NSString * se_address;
/**
 * 工艺
 */

@property(nonatomic,copy) NSString * se_tags;
/**
 * 品牌
 */

@property(nonatomic,copy) NSString * se_brand;
/**
 * 规格
 */

@property(nonatomic,copy) NSString * se_specifications;

/**
 * 自定义1
 */

@property(nonatomic,copy) NSString * se_customField1;
/**
 * 自定义1
 */

@property(nonatomic,copy) NSString * se_customField2;
/**
 * 自定义1
 */

@property(nonatomic,copy) NSString * se_customField3;
/**
 * 状态
 */

@property(nonatomic,copy) NSString * sec_infoStatus;//ProjectInfoStatus

/**
 * 状态
 */

@property(nonatomic,strong) NSMutableArray <__kindof NSString *>* sei_status;//ProjectInfoStatus[]

/*end采购清单筛选条件*/

@end
