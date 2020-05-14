//
//  PurchaseOrderReqBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/16.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PurchaseOrderReqBean : NSObject

/**
 * 采购商
 */
@property(nonatomic,copy) NSString * purchaseEpName;

/**
 * 查询交货日期
 */
@property(nonatomic,copy) NSString * seb_deliveryTime;

/**
 * 查询交货日期
 */
@property(nonatomic,copy) NSString * see_deliveryTime;

/**
 * 询盘号
 */
@property(nonatomic,copy) NSString * inquiryCode;

/**
 * 订单号
 */
@property(nonatomic,copy) NSString * orderCode;

/**
 * 零件号
 */
@property(nonatomic,copy) NSString * partNumber;

/**
 * 物料号
 */
@property(nonatomic,copy) NSString * materialNumber;

/**
 * 零件名称
 */
@property(nonatomic,copy) NSString * partName;

/**
 * 物料描述
 */
@property(nonatomic,copy) NSString * materialDes;

/**
 * 品牌
 */
@property(nonatomic,copy) NSString * brand;

/**
 * 规格
 */
@property(nonatomic,copy) NSString * specifications;

/**
 * 采购员
 */
@property(nonatomic,copy) NSString * purchaseName;

/**
 * 采购组
 */
@property(nonatomic,copy) NSString * purchaseGroup;

/**
 * 明细状态
 * WAITDELIVERY("待发货"),WAITRECEIVE("待收货"),WAITINSPECT("待质检"),COMPLETED("已完成")，CLOSE("已关闭");
 */
@property(nonatomic,copy) NSString * itemStatus;

/**
 * 是否开启ERP 1-是；0-否
 */
@property(nonatomic,strong) NSNumber * isOpenErp;

/**
 * 是否需要分页 默认为空，非空时，并且等于0，则默认不查分页信息
 */
@property(nonatomic,strong) NSNumber * hasPager;

/**
 * 是否是采购商 1-是；0或不传默认为供应商
 */
@property(nonatomic,strong) NSNumber * isPurchase;

/**
 * 采购商发货类型（用于过滤可发货数量/不发货数量为0的数据） 0-发正常单；1-发补发货单
 */
@property(nonatomic,strong) NSNumber * purchaseDeliverType;

@end

NS_ASSUME_NONNULL_END
