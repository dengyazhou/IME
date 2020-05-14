//
//  DeliverOrderDetailBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/16.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MJExtension.h>

#import "DeliverOrderItemBean.h"
NS_ASSUME_NONNULL_BEGIN

@interface DeliverOrderDetailBean : NSObject

/**
 * 询盘号,20个，以","分割
 */
@property(nonatomic,copy) NSString * inquiryCodes;

/**
 * 订单号,20个，以","分割
 */
@property(nonatomic,copy) NSString * orderCodes;

/**
 * 发货单类型
 */
@property(nonatomic,copy) NSString * orderOperateType;//OrderOperateType

/**
 * 发货单号
 */
@property(nonatomic,copy) NSString * deliverCode;

/**
 * 送货单号
 */
@property(nonatomic,copy) NSString * deliverNumber;

/**
 * 发货日期
 */
@property(nonatomic,copy) NSString * deliveryTime;

/**
 * 送货方式（枚举类型） SUPPLIER("供应商送货"),LOGISTICS("快递物流"),SELF("自提")
 */
@property(nonatomic,copy) NSString * deliveryMethods;//DeliveryMethod

/**
 * 送货方式说明
 */
@property(nonatomic,copy) NSString * deliveryMethodsDesc;

/**
 * 送货联系人
 */
@property(nonatomic,copy) NSString * deliveryContact;

/**
 * 送货电话
 */
@property(nonatomic,copy) NSString * deliveryPhone;

/**
 * 送货车牌
 */
@property(nonatomic,copy) NSString * license;

/**
 * 物流公司
 */
@property(nonatomic,copy) NSString * logisticsCompany;

/**
 * 运单号
 */
@property(nonatomic,copy) NSString * logisticsNo;

/**
 * 物流公司KEY
 */
@property(nonatomic,copy) NSString * logisticsCompanyKey;

/**
 * 自提地址
 */
@property(nonatomic,copy) NSString * selfAddress;

/**
 * 采购商
 */
@property(nonatomic,copy) NSString * purchaseEpName;

/**
 * 零件项数
 */
@property(nonatomic,strong) NSNumber * itemNum;

/**
 * 零件总数
 */
@property(nonatomic,strong) NSNumber * itemQuantity;

/**
 * 收货地区信息
 */
@property(nonatomic,copy) NSString * zoneStr;

/**
 * 收货地址
 */
@property(nonatomic,copy) NSString * address;

/**
 * 收货联系手机
 */
@property(nonatomic,copy) NSString * phone;

/**
 * 收货人姓名
 */
@property(nonatomic,copy) NSString * name;

/**
 * 送货备注
 */
@property(nonatomic,copy) NSString * remark;

/**
 * 操作单项
 */
@property(nonatomic,strong) NSMutableArray <__kindof DeliverOrderItemBean *> * items;

/**
 * 供应商ID
 */
@property(nonatomic,copy) NSString * supplierId;

/**
 * 供应商企业名
 */
@property(nonatomic,copy) NSString * supplierEpName;

/**
 * 操作人
 */
@property(nonatomic,copy) NSString * memberId;

/**
 * 该询盘创建时采购商企业是否开启了ERP对接
 */
@property(nonatomic,strong) NSNumber * isOpenErp;

/**
 * 操作人企业ID
 */
@property(nonatomic,copy) NSString * manufacturerId;

/**
 * 创建人类型 0-供应商；1-采购商
 */
@property(nonatomic,strong) NSNumber * createMemberType;

/**
 * 是否是透明工厂单据 0-否；1-是
 */
@property(nonatomic,strong) NSNumber * isTpf;

/**
 * 操作人
 */
@property(nonatomic,copy) NSString * memberName;

/**
 * 系统操作时间
 */
@property(nonatomic,copy) NSString * sysTime;

/**
 * 发货状态
 */
@property(nonatomic,copy) NSString * warehouseOrderStatus;

/**
 * 发货状态说明
 */
@property(nonatomic,copy) NSString * warehouseOrderStatusDesc;

/**
 * 是否有交付差异
 */
@property(nonatomic,strong) NSNumber * isDifference;

/**
 * 是否已查看交付差异
 */
@property(nonatomic,strong) NSNumber * isCheckDifference;

/**
 * 是否有质检异常
 */
@property(nonatomic,strong) NSNumber * isDefective;

/**
 * 是否已查看质检异常
 */
@property(nonatomic,strong) NSNumber * isCheckDefective;

/**
 * 是否收货完成 1-是；0-否
 */
@property(nonatomic,strong) NSNumber * isReceive;

/**
 * 收货单号
 */
@property(nonatomic,copy) NSString * receiveCode;

/**
 * 是否质检完成 1-是；0-否
 */
@property(nonatomic,strong) NSNumber * isInspect;

/**
 * 质检单号
 */
@property(nonatomic,copy) NSString * inspectCode;

/**
 * 质检单据Id
 */
@property(nonatomic,copy) NSString * inspectOrderId;

/**
 * 收货单id
 */
@property(nonatomic,copy) NSString * deliverOrderId;

@property(nonatomic,copy) NSString * receiveTimeDYZ;//收货时间

@property(nonatomic,copy) NSString *arrivalTimeDYZ;//到仓时间

@property(nonatomic,copy) NSString *expectedArrivalTime;//预计到货日期

@end

NS_ASSUME_NONNULL_END
