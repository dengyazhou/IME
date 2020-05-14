//
//  PurchaseOrderResBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/16.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PurchaseOrderResBean : NSObject

/**
 * 订单id
 */
@property(nonatomic,copy) NSString * orderId;

/**
 * 明细ID
 */
@property(nonatomic,copy) NSString * itemId;
/**
 * 明细状态
 */
@property(nonatomic,copy) NSString * itemStatus;

/**
 * 零件号
 */
@property(nonatomic,copy) NSString * partNumber;

/**
 * 数量
 */
@property(nonatomic,strong) NSNumber * num;

/**
 * 待发货数量
 */
@property(nonatomic,strong) NSNumber * waitDeliverNum;

/**
 * 待补发数量
 */
@property(nonatomic,strong) NSNumber * waitReissueNum;

/**
 * 已发货数量
 */
@property(nonatomic,strong) NSNumber * deliverNum;

/**
 * 已收货数量
 */
@property(nonatomic,strong) NSNumber * receiveNum;

/**
 * 不合格数量
 */
@property(nonatomic,strong) NSNumber * defectiveNum;

/**
 * 入库数量
 */
@property(nonatomic,strong) NSNumber * warehouseNum;

/**
 * 物料号
 */
@property(nonatomic,copy) NSString * materialNumber;

/**
 * 零件名称
 */
@property(nonatomic,copy) NSString * partName;

/**
 * 品牌
 */
@property(nonatomic,copy) NSString * brand;

/**
 * 规格
 */
@property(nonatomic,copy) NSString * specifications;

/**
 * 物料描述
 */
@property(nonatomic,copy) NSString * materialDescription;

/**
 * 发货时间-交货日期
 */
@property(nonatomic,copy) NSString * deliveryTime;

/**
 * 供应商
 */
@property(nonatomic,copy) NSString * purchaseEpName;

/**
 * 采购员
 */
@property(nonatomic,copy) NSString * purchaseName;

/**
 * 采购组
 */
@property(nonatomic,copy) NSString * purchaseGroup;

/**
 * 询盘号
 */
@property(nonatomic,copy) NSString * inquiryCode;

/**
 * 订单号
 */
@property(nonatomic,copy) NSString * orderCode;

/**
 * 供应商报价单价(含税)
 */
@property(nonatomic,copy) NSString * supplierPrice;

/**
 * 成交单价(含税)
 */
@property(nonatomic,copy) NSString * price;

/**
 * 成交小计
 */
@property(nonatomic,copy) NSString * subtotalPrice;

/**
 * 供应商税率
 */
@property(nonatomic,copy) NSString * supplierTaxRate;

/**
 * 订单创建时间
 */
@property(nonatomic,copy) NSString * orderCreateTime;

/**
 * 最小单位说明
 */
@property(nonatomic,copy) NSString * quantityUnitDesc;

/**
 * 是否开启ERP
 */
@property(nonatomic,strong) NSNumber * isOpenErp;

/**
 * 所属项目
 */
@property(nonatomic,copy) NSString * ownProjectName;

@property (nonatomic,strong) NSNumber *selectDYZ;//用于标记时候选中

@end

NS_ASSUME_NONNULL_END
