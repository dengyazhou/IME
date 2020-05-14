//
//  TradeOrderItem.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/8/3.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"
#import "BatchDeliverItem.h"
#import "TradeOrder.h"

@class TradeOrderItemFile;


@interface TradeOrderItem : BaseEntity

/**
 * 主键
 */
@property (nonatomic,copy) NSString * tradeOrderItemId;

/**
 * 图纸文件
 */
@property (nonatomic,strong) NSMutableArray <__kindof TradeOrderItemFile *> * tradeOrderItemFiles;//TradeOrderItemFile

/**
 * 零件名称
 */
@property (nonatomic,copy) NSString * partName;

/**
 * 内部编码
 */
@property (nonatomic,copy) NSString * insideCode;

/**
 * 形状
 */
@property (nonatomic,copy) NSString * shape;

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
 * 长
 */
@property (nonatomic,strong) NSNumber * length;//Double

/**
 * 宽
 */
@property (nonatomic,strong) NSNumber * width;//Double

/**
 * 高
 */
@property (nonatomic,strong) NSNumber * height;//Double


/**
 * 尺寸单位
 */
@property (nonatomic,copy) NSString * sizeUnit;//A("英寸"),B("毫米");

/**
 * 工艺 以.工艺名.分割
 */
@property (nonatomic,copy) NSString * tags;

/**
 * 最小单位
 */
@property (nonatomic,copy) NSString * quantityUnit;//A("件"),B("英尺"),C("磅"),D("吨"),E("加仑"),F("米"),G("千克"),H("公吨"),I("升"),J("套"),K("套（组装件）"),L("打"),M("码"),N("每个");

/**
 * 年采购量
 */
@property (nonatomic,strong) NSNumber *purchaseNum;//Double

//------------------170731 add beg--------------
/**
 * 净重
 */
@property (nonatomic,strong) NSNumber * suttle;//Double

/**
 * 物料号
 */
@property (nonatomic,copy) NSString * materialNumber;
//------------------170731 add end--------------

/**
 * 描述
 */
@property (nonatomic,copy) NSString * detail;

/**
 * 单价
 */
@property (nonatomic,strong) NSNumber * price;//Double

/**
 * 数量
 */
@property (nonatomic,strong) NSNumber * num;//Integer

/**
 * 小计
 */
@property (nonatomic,strong) NSNumber * subtotalPrice;//Double

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

//------161230 BOM表相关 begin-------------
/**
 * 是否匹配图纸云
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
 * 用户定制的工艺
 * 以.工艺名.分割
 */
@property (nonatomic,copy) NSString * customTags;
//------161230 BOM表相关 end---------------

/**
 * 缩略图地址
 */
@property (nonatomic,copy) NSString * thumbnailUrl;

/**
 * 2017.3.30
 * 已发货数量(累计)
 */
@property (nonatomic,strong) NSNumber * deliverNums;//Integer

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
@property (nonatomic,strong) NSNumber * isMatch;//Integer

/**
 * 图纸云零件ID
 */
@property (nonatomic,copy) NSString *  partId;

/**
 * 用户多次发货详情
 */
@property (nonatomic,copy) NSString *  batchDeliverItem;

/**
 * 预发货批次数
 */
@property (nonatomic,strong) NSNumber *  batchDeliverNum;//Integer

/**
 * 发货时间
 */
@property (nonatomic,copy) NSString *  deliveryTime;//Date

/**
 * 订单采购商企业ID
 */
@property (nonatomic,copy) NSString * t__purchaseEnterpriseId;

/**
 * 采购商状态
 */
@property (nonatomic,copy) NSString * t__tradeOrderPurchaseStatus;//TradeOrderPurchaseStatus

/**
 * 存储相关的多次发货信息
 */
@property (nonatomic,strong) NSMutableArray <__kindof BatchDeliverItem *> * sec_batchDeliverItems;//BatchDeliverItem

/**
 * 交易订单
 */
@property (nonatomic,strong) TradeOrder *tradeOrder;

/**
 * 规格
 */
@property (nonatomic,copy) NSString * specifications;

/**
 * 品牌
 */
@property (nonatomic,copy) NSString * brand;

/**
 * 2018.6.21--新增
 * 采购商目标价--对应询盘price1
 */
@property (nonatomic,strong) NSNumber * targetPrice1;//BigDecimal

/*---------ERP对接新增字段begin---------*/
/**
 * 订单项行号
 * 注：10进制
 */
@property (nonatomic,strong) NSNumber * itemNo;

/**
 * 图号
 */
@property (nonatomic,copy) NSString * figureNo;

/**
 * 所属项目名(erp或图纸云)
 */
@property (nonatomic,copy) NSString * ownProjectName;

/**
 * 采购需求单明细的ID(非标)
 */
@property (nonatomic,copy) NSString * projectInfoId;

/**
 * 图纸云bom零件主键(图纸云)
 */
@property (nonatomic,copy) NSString * bomAccId;

/**
 * 采购申请类型(erp或图纸云)
 */
@property (nonatomic,copy) NSString * applyType;

/**
 * 采购申请号(erp或者图纸云，但是图纸云允许为空)
 */
@property (nonatomic,copy) NSString * applyNumber;

/**
 * 采购需求单明细的行号(erp)
 */
@property (nonatomic,strong) NSNumber * lineNum;//Integer

/**
 * 来源
 */
@property (nonatomic,copy) NSString * source;//PartSourceType

/**
 * 物料组
 */
@property (nonatomic,copy) NSString * materialGroup;

/**
 * 物料描述
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
 * 清单采购说明
 */
@property (nonatomic,copy) NSString * purchaseDes;
/*---------ERP对接新增字段end---------*/

/**
 * 材料牌号
 */
@property (nonatomic,copy) NSString * materialNo;

@property (nonatomic,strong) NSNumber * isSelect;//Integer

@property (nonatomic,strong) NSNumber * receiveNum;//BigDecimal

@property (nonatomic,strong) NSNumber * warehouseNum;//BigDecimal

@property (nonatomic,strong) NSNumber * supplierPrice;

@property (nonatomic,strong) NSNumber *subTotalTargetPrice;
@property (nonatomic,strong) NSNumber *subTotalPrice;
@property (nonatomic,strong) NSNumber * subTotalSupplierPrice;

@property (nonatomic,copy) NSString *partRemark;
@property (nonatomic,copy) NSString *supplierPartRemark;


@end
