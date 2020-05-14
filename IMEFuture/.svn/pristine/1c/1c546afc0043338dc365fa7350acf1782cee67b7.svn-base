//
//  InquiryOrder.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/21.
//  Copyright © 2016年 Netease. All rights reserved.
//

//#import "BaseAddress.h"
#import <Foundation/Foundation.h>

//@class Member;
//@class QuotationOrder;
//@class InquiryOrderItem;
#import "Member.h"
#import "QuotationOrder.h"
#import "InquiryOrderItem.h"
#import "PurchaseProject.h"

@class InquiryOrderEnterprise;

@interface InquiryOrder : NSObject

/**
 * 主键
 */
@property (nonatomic,copy) NSString *inquiryOrderId;


/**
 * 创建询盘单的用户
 */
@property (nonatomic,strong) Member *member;

/**
 * 创建时间
 */
@property (nonatomic,copy) NSString * createTime;//Date

/**
 * 目标价供应商是否可见
 */
@property (nonatomic,strong) NSNumber *isVisiblePrice;//Integer

/**
 * 询盘有效天数
 */
@property (nonatomic,strong) NSNumber * inquiryDay;//Integer

/**
 * 零件总数
 */
@property (nonatomic,strong) NSNumber * partNums;//BigDecimal

/**
 * 已授单零件行数
 */
@property (nonatomic,strong) NSNumber * sendItemNums;//Integer

/**
 * 创建询盘单的用户Id
 */
@property (nonatomic,copy) NSString *memberId;

/**
 * 创建询盘单的企业Id
 */
@property (nonatomic,copy) NSString *manufacturerId;

/**
 * 采购商目标价小计
 */
@property (nonatomic,strong) NSNumber * targetSubtotalPrice;//BigDecimal

/**
 * 采购商目标价总计
 */
@property (nonatomic,strong) NSNumber * targetTotalPrice;//BigDecimal

/**
 * 报价的供应商数量
 */
@property (nonatomic,strong) NSNumber *quotationNum;//Integer

/**
 * 询盘订单项
 */
@property (nonatomic,strong) NSMutableArray <__kindof InquiryOrderItem *> *inquiryOrderItems;//InquiryOrderItem

/**
 * 报价单集合
 */
@property (nonatomic,strong) NSMutableArray <__kindof QuotationOrder *> *quotationOrderList;//QuotationOrder

/**
 * 定向的企业列表
 */
@property (nonatomic,strong) NSMutableArray <__kindof InquiryOrderEnterprise *> * inquiryOrderEnterprises;

/**
 * 是否预发货单
 */
@property (nonatomic,strong) NSNumber * isPre;//Integer

/**
 * 询盘详细数(零件数)
 */
@property (nonatomic,strong) NSNumber * itemNums;//Integer

/**
 * 定向展示的企业数
 */
@property (nonatomic,strong) NSNumber * enterpriseNums;//Integer

/**
 * 询盘订单编号
 */
@property (nonatomic,copy) NSString *inquiryOrderCode;

/**
 * 企业内部询盘号
 */
@property (nonatomic,copy) NSString * enterpriseOrderCode;

/**
 * 询盘类型
 */
@property (nonatomic,copy) NSString * inquiryType;//InquiryType

/**
 * 询盘类型描述
 */
@property (nonatomic,copy) NSString * inquiryTypeDesc;

/**
 * 零件类型
 */
@property (nonatomic,copy) NSString *partType;//PartType

/**
 * 零件类型描述
 */
@property (nonatomic,copy) NSString * PartTypeDesc;

/**
 * 加工类型
 */
@property (nonatomic,copy) NSString * processType;//ProcessType

/**
 * 加工类型描述
 */
@property (nonatomic,copy) NSString * processTypeDesc;

/**
 * 询盘单状态
 */
@property (nonatomic,copy) NSString * inquiryOrderStatus;//InquiryOrderStatus 枚举

/**
 * 询盘单状态描述
 */
@property (nonatomic,copy) NSString *inquiryOrderStatusDesc;

/**
 * 运送方式
 */
@property (nonatomic,copy) NSString *deliveryMethod;//DeliveryMethod 枚举

/**
 * 截止时间
 */
@property (nonatomic,copy) NSString *endTm;//Date

/**
 * 取消原因
 */
@property (nonatomic,copy) NSString *cancelMsg;

/**
 * 取消时间
 */
@property (nonatomic,copy) NSString *cancelTm;//Date

/**
 * 取消人
 */
@property (nonatomic,copy) NSString *cancelName;

/**
 * 是否是私有的（匿名询盘）
 */
@property (nonatomic,strong) NSNumber * isPrivate;//Integer

/**
 * 是否允许线下追踪
 * 1-允许；0-不允许。
 * 允许的话，后台管理员可以随意下载和传播询盘图纸
 */
@property (nonatomic,strong) NSNumber * allowTracking;//Integer

/**
 * 期望收货日期
 */
@property (nonatomic,copy) NSString *expectRcvTm;//Date

/**
 * 订单要求
 */
@property (nonatomic,copy) NSString * tradeOrderRemark;

/**
 * 工艺
 * 以.工艺名.分割
 */
@property (nonatomic,copy) NSString * tags;

/**
 * 跟进人ID
 */
@property (nonatomic,copy) NSString * purchaseFollowerId;

/**
 * 地址
 */
@property (nonatomic,copy) NSString * address;

/**
 * 邮编
 */
@property (nonatomic,copy) NSString * zipcode;

/**
 * 一级地区名称
 */
@property (nonatomic,copy) NSString * zoneId1;

/**
 * 二级地区名称
 */
@property (nonatomic,copy) NSString * zoneId2;

/**
 * 三级地区名称
 */
@property (nonatomic,copy) NSString * zoneId3;

/**
 * 地区信息
 */
@property (nonatomic,copy) NSString * zoneStr;

/**
 * 手机
 */
@property (nonatomic,copy) NSString * phone;

/**
 * 电话区号
 */
@property (nonatomic,copy) NSString * telZip;

/**
 * 电话
 */
@property (nonatomic,copy) NSString * tel;

/**
 * 分机号
 */
@property (nonatomic,copy) NSString * extension;

/**
 * 收货人姓名
 */
@property (nonatomic,copy) NSString * name;

/**
 * 是否使用了报价模板
 */
@property (nonatomic,strong) NSNumber * isQuotationTemplate;//Integer

/**
 * 报价模板Id
 */
@property (nonatomic,copy) NSString * quotationTemplateId;

/**
 * 报价模板的名称
 */
@property (nonatomic,copy) NSString * quotationTemplateName;

/**
 * 采购期望供应商税率
 */
@property (nonatomic,strong) NSNumber * supplierTaxRate;//Double

/**
 * 模板类型
 * 具体值跟着QuotationTemplate.templateType
 */
@property (nonatomic,strong) NSNumber * templateType;//Integer

/**
 * 报价模板价格明细的总计数量
 */
@property (nonatomic,strong) NSNumber * tempPriceDetailCount;//Integer

/**
 * 报价模板价格名称1
 */
@property (nonatomic,copy) NSString * tempPriceDetailName1;

/**
 * 报价模板价格名称2
 */
@property (nonatomic,copy) NSString * tempPriceDetailName2;

/**
 * 报价模板价格名称3
 */
@property (nonatomic,copy) NSString * tempPriceDetailName3;

/**
 * 报价模板价格名称4
 */
@property (nonatomic,copy) NSString * tempPriceDetailName4;

/**
 * 报价模板价格名称5
 */
@property (nonatomic,copy) NSString * tempPriceDetailName5;

/**
 * 报价模板价格名称6
 */
@property (nonatomic,copy) NSString * tempPriceDetailName6;

/**
 * 报价模板价格名称7
 */
@property (nonatomic,copy) NSString * tempPriceDetailName7;

/**
 * 报价模板价格名称8
 */
@property (nonatomic,copy) NSString * tempPriceDetailName8;

/**
 * 报价模板价格名称9
 */
@property (nonatomic,copy) NSString * tempPriceDetailName9;

/**
 * 报价模板价格名称10
 */
@property (nonatomic,copy) NSString * tempPriceDetailName10;

/**
 * 报价模板价格名称11
 */
@property (nonatomic,copy) NSString * tempPriceDetailName11;

/**
 * 报价模板价格名称12
 */
@property (nonatomic,copy) NSString * tempPriceDetailName12;

/**
 * 报价模板价格名称13
 */
@property (nonatomic,copy) NSString * tempPriceDetailName13;

/**
 * 报价模板价格名称14
 */
@property (nonatomic,copy) NSString * tempPriceDetailName14;

/**
 * 报价模板价格名称15
 */
@property (nonatomic,copy) NSString * tempPriceDetailName15;

/**
 * 报价模板价格名称16
 */
@property (nonatomic,copy) NSString * tempPriceDetailName16;

/**
 * 报价模板价格名称17
 */
@property (nonatomic,copy) NSString * tempPriceDetailName17;

/**
 * 报价模板价格名称18
 */
@property (nonatomic,copy) NSString * tempPriceDetailName18;

/**
 * 报价模板价格名称19
 */
@property (nonatomic,copy) NSString * tempPriceDetailName19;

/**
 * 报价模板价格备注1
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark1;

/**
 * 报价模板价格备注2
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark2;

/**
 * 报价模板价格备注3
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark3;

/**
 * 报价模板价格备注4
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark4;

/**
 * 报价模板价格备注5
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark5;

/**
 * 报价模板价格备注6
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark6;

/**
 * 报价模板价格备注7
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark7;

/**
 * 报价模板价格备注8
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark8;

/**
 * 报价模板价格备注9
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark9;

/**
 * 报价模板价格备注10
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark10;

/**
 * 报价模板价格备注11
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark11;

/**
 * 报价模板价格备注12
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark12;

/**
 * 报价模板价格备注13
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark13;

/**
 * 报价模板价格备注14
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark14;

/**
 * 报价模板价格备注15
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark15;

/**
 * 报价模板价格备注16
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark16;

/**
 * 报价模板价格备注17
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark17;

/**
 * 报价模板价格备注18
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark18;

/**
 * 报价模板价格备注19
 */
@property (nonatomic,copy) NSString * tempPriceDetailRemark19;

@property (nonatomic,copy) NSString * refuseMsg;

@property (nonatomic,copy) NSString * se_enterpriseOrderCode;


























@property (nonatomic,copy) NSString *seb_createTime;

/**
 * 已接盘的报价单
 */
@property (nonatomic,strong) QuotationOrder *quotationOrder;

/**
 * 已接盘的报价单Id
 */
@property (nonatomic,copy) NSString *quotationOrderId;

/**
 * 是否是线下签约
 */
@property (nonatomic,strong) NSNumber * isOfflineSign;//Integer

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
 * 所有的零件中，是否有来自于采购清单的零件
 */
@property (nonatomic,strong) NSNumber *  hasProjectInfo;

/**
 * 交易订单Id
 */
@property (nonatomic,copy) NSString *tradeOrderId;

/**
 * 交易订单编号
 */
@property (nonatomic,copy) NSString *tradeOrderCode;

@property (nonatomic,copy) NSString *sec_statusDesc;

/**
 * 行业
 */
@property (nonatomic,copy) NSString *industry;//Industry 枚举
@property (nonatomic,copy) NSString *sec_industryDesc;


@property (nonatomic,copy) NSString *sec_deliveryMethodDesc;

/**
 * 显示用的截止时间
 */
@property (nonatomic,copy) NSString *endTmShow;//Date

/**
 * 内部订单号
 */
@property (nonatomic,copy) NSString * insideOrderCode;

/**
 * 取消人Id
 */
@property (nonatomic,copy) NSString *cancelId;

/**
 * 关闭原因
 */
@property (nonatomic,copy) NSString *disabledMsg;

/**
 * 关闭时间
 */
@property (nonatomic,copy) NSString *disabledTm;//Date

/**
 * 关闭人
 */
@property (nonatomic,copy) NSString *disabledName;

/**
 * 关闭人Id
 */
@property (nonatomic,copy) NSString *disabledId;

/**
 * 是否加急
 */
@property (nonatomic,strong) NSNumber *isUrgent;//Integer

/**
 * 浏览数量
 */
@property (nonatomic,strong) NSNumber *viewNum;//Integer

//------170224 两种议价托管 begin -------------
/**
 * 第一报价杂费(采购商报价)
 */
@property (nonatomic,strong) NSNumber * cost1;//double

/**
 * 第一报价运费(采购商报价)
 */
@property (nonatomic,strong) NSNumber * shipPrice1;//double
//------170224 两种议价托管 end -------------



/**
 * 询盘标题
 */
@property (nonatomic,copy) NSString *title;

/**
 * 优选供应商备注
 */
@property (nonatomic,copy) NSString *supplierRemark;

/**
 * 授盘时间
 */
@property (nonatomic,copy) NSString *sendTm;//Date

/**
 * 授盘人
 */
@property (nonatomic,copy) NSString *sendName;

/**
 * 授盘人Id
 */
@property (nonatomic,copy) NSString *sendId;

/**
 * 审核状态
 * 1-待审核（刚预授盘）；0-无需审核；
 */
@property (nonatomic,strong) NSNumber * confirmStatus;//Integer

/**
 * 数据安全验证码
 */
@property (nonatomic,copy) NSString * verifyCode;

/**
 * 修改次数
 */
@property (nonatomic,strong) NSNumber * editNum;//Integer

/**
 * 审核时间
 */
@property (nonatomic,copy) NSString * confirmTm;//Date

/**
 * 审核人
 */
@property (nonatomic,copy) NSString * confirmName;

/**
 * 审核人Id
 */
@property (nonatomic,copy) NSString * confirmId;

/**
 * 审核意见
 */
@property (nonatomic,copy) NSString * confirmMsg;

/**
 * 查询标题或单号
 */
@property (nonatomic,copy) NSString *sec_titleOrTradeCode;


/**
 * 搜索超时时间大于
 */
@property (nonatomic,copy) NSString *seb_endTm;//Date

/**
 * 搜索超时时间小于
 */
@property (nonatomic,copy) NSString *see_endTm;//Date

/**
 * 搜索报价审核时间大于
 */
@property (nonatomic,copy) NSString * seb_q__confirmTm;//Date

/**
 * 搜索报价审核时间小于
 */
@property (nonatomic,copy) NSString * see_q__confirmTm;//Date

/**
 * 搜索报价创建时间大于
 */
@property (nonatomic,copy) NSString * seb_q__createTime;//Date

/**
 * 搜索报价创建时间小于
 */
@property (nonatomic,copy) NSString * see_q__createTime;//Date

/**
 * 搜索是否是历史报价记录
 */
@property (nonatomic,strong) NSNumber * q__isLog;//Integer

/**
 * 搜索报价单的状态
 */
@property (nonatomic,copy) NSString * q__status;//QuotationOrderStatus 枚举

/**
 * 搜索符合条件的多个标签（工艺）
 */
@property (nonatomic,strong) NSMutableArray *sec_tags;//String

/**
 * 临时保存有效的报价单
 */
@property (nonatomic,strong) NSMutableArray <__kindof QuotationOrder *> * sec_quotationOrders;//QuotationOrder

/**
 * 临时保存订单统计值
 */
@property (nonatomic,strong) NSNumber * sec_statusCount;//Long

/**
 * 搜索多状态
 * (考虑超时状态,超时的不显示)
 */
@property (nonatomic,strong) NSMutableArray * sei_status;//InquiryOrderStatus 枚举

/**
 * 搜索多Id
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sei_inquiryOrderId;//String

/**
 * 搜索多个询盘类型
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *>  * sei_inquiryType;//InquiryType

/**
 * 搜索不等于询盘ID
 */
@property (nonatomic,copy) NSString *sec_notInquiryOrderId;

/**
 * 搜索询盘企业关系表的企业ID
 */
@property (nonatomic,copy) NSString * ioe__manufacturerId;

/**
 * 搜索询盘企业关系表的类型集合
 */
// 0-邀请；2-定向；4-无需付款的托管；6-需付款的托管；8-关注
@property (nonatomic,strong) NSMutableArray <__kindof NSNumber *> * sei_ioe__recommendType;//private Integer [] sei_ioe__recommendType;

/**
 * 搜索询盘企业关系表的类型
 */
@property (nonatomic,strong) NSNumber * ioe__recommendType;//Integer

/**
 * 是否是查询报价
 */
@property (nonatomic,strong) NSNumber * sec_searchQuo;//boolean

/**
 * 搜索不属于自己企业的询盘单
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sec_notSelf;//String

/**
 * 搜索不属于某些企业的询盘单
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sec_notManufacturerIds;

/**
 * 查询标题或单号或工艺
 */
@property (nonatomic,copy) NSString * sec_titleOrTradeCodeOrTag;

/**
 * 推荐询盘单优先级
 */
@property (nonatomic,strong) NSNumber * recommendIndex;//Integer

/**
 * 统计最少采购数量
 */
@property (nonatomic,strong) NSNumber * countMinNum;//Integer
/**
 * 统计最多采购数量
 */
@property (nonatomic,strong) NSNumber * countMaxNum;//Integer
/**
 * 采购商账期
 */
@property (nonatomic,strong) NSNumber * purchaserAccountPeriod;//Integer

//------161230 BOM表相关 begin-------------

//------161230 BOM表相关 end---------------

//------170801 保存询盘 begin-------------
/**
 * 是否是保存到一半未提交的询盘
 */
@property (nonatomic,strong) NSNumber * isTempSave;//Integer
//------170801 保存询盘 end---------------

/*---------ERP对接新增字段begin---------*/
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
@property (nonatomic,strong) NSNumber * isOpenErp;//Integer

/**
 * 零件是否全部都来源于Erp
 */
@property (nonatomic,strong) NSNumber * isSourceErp;//Integer

/**
 * 零件是否全部都来源于DrawingCloud
 */
@property (nonatomic,strong) NSNumber * isSourceDrawingCloud;//Integer
/*---------ERP对接新增字段end---------*/

/**
 * 2018.9.26新增ERP审核标志，ERP审核回调后回填
 * 审批标识
 * C-审批通过；I-审核拒绝
 */
@property (nonatomic,copy) NSString * orderApprovalLabel;

/**
 * 核价(指定价)报价时的备注
 */
@property (nonatomic,copy) NSString * designatedRemark;

//------170828报价模板相关 beg---------------

/**
 * 报价模板杂费明细的总计数量
 */
@property (nonatomic,strong) NSNumber * tempCostDetailCount;//Integer

/**
 * 报价模板运费明细的总计数量
 */
@property (nonatomic,strong) NSNumber * tempShipPriceDetailCount;//Integer

/**
 * 报价模板运费明细名称1
 */
@property (nonatomic,copy) NSString * tempShipPriceDetailName1;

/**
 * 报价模板运费明细名称2
 */
@property (nonatomic,copy) NSString * tempShipPriceDetailName2;

/**
 * 报价模板运费明细名称3
 */
@property (nonatomic,copy) NSString * tempShipPriceDetailName3;

/**
 * 报价模板运费明细名称4
 */
@property (nonatomic,copy) NSString * tempShipPriceDetailName4;

/**
 * 报价模板运费明细备注1
 */
@property (nonatomic,copy) NSString * tempShipPriceDetailRemark1;

/**
 * 报价模板运费明细备注2
 */
@property (nonatomic,copy) NSString * tempShipPriceDetailRemark2;

/**
 * 报价模板运费明细备注3
 */
@property (nonatomic,copy) NSString * tempShipPriceDetailRemark3;

/**
 * 报价模板运费明细备注4
 */
@property (nonatomic,copy) NSString * tempShipPriceDetailRemark4;

/**
 * 报价模板杂费明细名称1
 */
@property (nonatomic,copy) NSString * tempCostDetailName1;

/**
 * 报价模板杂费明细名称2
 */
@property (nonatomic,copy) NSString * tempCostDetailName2;

/**
 * 报价模板杂费明细名称3
 */
@property (nonatomic,copy) NSString * tempCostDetailName3;

/**
 * 报价模板杂费明细名称4
 */
@property (nonatomic,copy) NSString * tempCostDetailName4;

/**
 * 报价模板杂费明细名称5
 */
@property (nonatomic,copy) NSString * tempCostDetailName5;

/**
 * 报价模板杂费明细名称6
 */
@property (nonatomic,copy) NSString * tempCostDetailName6;

/**
 * 报价模板杂费明细名称7
 */
@property (nonatomic,copy) NSString * tempCostDetailName7;

/**
 * 报价模板杂费明细名称8
 */
@property (nonatomic,copy) NSString * tempCostDetailName8;

/**
 * 报价模板杂费明细名称9
 */
@property (nonatomic,copy) NSString * tempCostDetailName9;

/**
 * 报价模板杂费明细名称10
 */
@property (nonatomic,copy) NSString * tempCostDetailName10;

/**
 * 报价模板杂费明细备注1
 */
@property (nonatomic,copy) NSString *tempCostDetailRemark1;

/**
 * 报价模板杂费明细备注2
 */
@property (nonatomic,copy) NSString * tempCostDetailRemark2;

/**
 * 报价模板杂费明细备注3
 */
@property (nonatomic,copy) NSString * tempCostDetailRemark3;

/**
 * 报价模板杂费明细备注4
 */
@property (nonatomic,copy) NSString * tempCostDetailRemark4;

/**
 * 报价模板杂费明细备注5
 */
@property (nonatomic,copy) NSString * tempCostDetailRemark5;

/**
 * 报价模板杂费明细备注6
 */
@property (nonatomic,copy) NSString * tempCostDetailRemark6;

/**
 * 报价模板杂费明细备注7
 */
@property (nonatomic,copy) NSString * tempCostDetailRemark7;

/**
 * 报价模板杂费明细备注8
 */
@property (nonatomic,copy) NSString * tempCostDetailRemark8;

/**
 * 报价模板杂费明细备注9
 */
@property (nonatomic,copy) NSString * tempCostDetailRemark9;

/**
 * 报价模板杂费明细备注10
 */
@property (nonatomic,copy) NSString * tempCostDetailRemark10;
//------170828报价模板相关 end---------------

/**
 * 跟进人
 */
@property (nonatomic,strong) Member * purchaseFollower;

/**
 * 催报价时间
 */
@property (nonatomic,copy) NSString * callQuoTm;//Date

/**
 * 是否是核价(指定价)报价
 * 报价询盘授盘时，供应商填写价格，要求供应商接盘
 */
@property (nonatomic,strong) NSNumber * isDesignated;//Integer

/**
 * 是否附加查询已授盘信息
 */
@property (nonatomic,strong) NSNumber *sec_hasSendQuo;//boolean

/**
 * 报价数量大于
 */
@property (nonatomic,strong) NSNumber *seb_quotationNum;//Integer

/**
 * 报价数量小于
 */
@property (nonatomic,strong) NSNumber *see_quotationNum;//Integer

/**
 * 模糊查询询盘标题
 */
@property (nonatomic,copy) NSString *se_title;

/**
 * 推荐询盘单优先级大于等于
 */
@property (nonatomic,strong) NSNumber * seb_recommendIndex;//Integer

/**
 * 推荐询盘单优先级小于等于
 */
@property (nonatomic,strong) NSNumber * see_recommendIndex;//Integer

/**
 * 模糊查询多个报价单状态
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> *sec_quoOrStatus;//QuotationOrderStatus


/**
 * 查询卖家（供应商）销售询盘
 * 与买家销售询盘是或者关系
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sec_orSupplierInquiryOrder;

/**
 * 查询买家（采购商）销售询盘
 * 与卖家销售询盘是或者关系
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sec_orPurchaseInquiryOrder;

/**
 * 询盘需要回填的采购项目ID
 */
@property (nonatomic,copy) NSString *sec_projectId;

/**
 * 采购商是否测试账号
 */
@property (nonatomic,strong) NSNumber * ie__isTestAccount;//Integer

/**
 * 供应商是否测试账号
 */
@property(nonatomic,strong) NSNumber * qe__isTestAccount;//Integer

/**
 * 采购商企业名称模糊查询
 */
@property (nonatomic,copy) NSString * se_ie__enterpriseName;

/**
 * 查询询盘和询盘项中的标签
 * 多个是或关系
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sec_orderAndItemOrTags;//String[] sec_orderAndItemOrTags;


@property (nonatomic,strong) NSNumber *isallow;//Integer

@end
