//
//  InspectOrderVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/16.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MJExtension.h>
#import "InspectOrderItemVo.h"
#import "DeliverOrderDetailBean.h"
#import "ReceiveBean.h"

NS_ASSUME_NONNULL_BEGIN

@interface InspectOrderVo : NSObject


/**
 * 主键
 */
@property(nonatomic,copy) NSString *inspectOrderId;

@property (nonatomic,strong) DeliverOrderDetailBean *deliverOrder;

@property (nonatomic,strong) ReceiveBean *receiveOrder;

@property(nonatomic,strong) NSMutableArray <__kindof InspectOrderItemVo *>* inspectOrderItems;
/*--各种code begin--*/
@property(nonatomic,copy) NSString *deliverOrderId;

@property(nonatomic,copy) NSString *receiveOrderId;
/**
 * 验货单号
 */
@property(nonatomic,copy) NSString *inspectCode;
/**
 * erp凭证号
 */
@property(nonatomic,copy) NSString *erpInspectCode;
/**
 *
 */
@property(nonatomic,strong) NSNumber * isOpenErp;

/**
 * 收货单号
 */
@property(nonatomic,copy) NSString *receiveCode;
/**
 * 发货单号
 */
@property(nonatomic,copy) NSString *deliverCode;
/*--各种code end--*/

/*--各种时间begin--*/
/**
 * 验货完成时间
 */
@property(nonatomic,copy) NSString *inspectTime;
/**
 * 需要重新对接
 */
@property(nonatomic,strong) NSNumber * isNeedReNotify;
/**
 * 收货时间
 */
@property(nonatomic,copy) NSString *receiveTime;
/**
 * 2018.6.22--需求更新 要求到货日期-预发货单、发货单 预发货单发货时不更新 普通发货单在生成时从订单带入期望收货日期
 */
@property(nonatomic,copy) NSString *deadlineTime;
/*--各种时间end--*/

/**
 * 企业主键--操作人
 */
@property(nonatomic,copy) NSString *manufacturerId;
/**
 * 操作人
 */
@property(nonatomic,copy) NSString *memberName;
/**
 * 对接状态 0成功 1失败
 */
@property(nonatomic,strong) NSNumber * dockingState;

/**
 * 是否验货完成（中文展示用的）
 */
@property(nonatomic,copy) NSString *isInspectShow;
/**
 * 验货状态 0-验货通过；1-验货不通过 有一个零件次品数量大于0，就默认整单验货 不通过）
 */
@property(nonatomic,strong) NSNumber * inspectStatus;

/**
 * 默认20个订单编号，以","分割
 */
@property(nonatomic,copy) NSString *tradeOrderCodes;

/**
 * 默认20个询盘编号，以","分割
 */
@property(nonatomic,copy) NSString *inquiryCodes;
/**
 * 送货方式
 */
@property(nonatomic,copy) NSString *deliveryMethods;
@property(nonatomic,copy) NSString *deliveryMethodsDesc;

@property(nonatomic,copy) NSString *deliverNumber;
/**
 * 送货时间
 */
@property(nonatomic,copy) NSString *deliveryTime;
/**
 * 收货联系手机
 */
@property(nonatomic,copy) NSString *phone;

/**
 * 收货人姓名
 */
@property(nonatomic,copy) NSString *name;
/**
 * 送货备注
 */
@property(nonatomic,copy) NSString *remark;

// ---------------2018.6.22更新--订单采购商及供应商-----------
// 供应商企业名
@property(nonatomic,copy) NSString *supplierEnterpriseName;

// ---------------2018.6.22更新--订单采购商及供应商END-----------

// -------------------2018.7.11零件项数及数量（应收、实收）BG--------------------------
/**
 * 实收零件项
 */
@property(nonatomic,strong) NSNumber * acItems;

/**
 * 实收零件总数
 */
@property(nonatomic,strong) NSNumber * acItemNums;
// -------------------2018.7.11零件项数及数量（应收、实收）END--------------------------
/**
 * 单据状态
 */
@property(nonatomic,copy) NSString *receiveOrderStatus;

@property(nonatomic,copy) NSString *receiveOrderStatusDesc;
/**
 * 单据类型
 */
@property(nonatomic,copy) NSString *orderOperateType;
@property(nonatomic,copy) NSString *orderOperateTypeDesc;
/**
 * 创建时间
 */
@property(nonatomic,copy) NSString *createTime;

/* 12-20 */
/**
 * 送货联系人
 */
@property(nonatomic,copy) NSString *deliveryContact;

/**
 * 送货电话
 */
@property(nonatomic,copy) NSString *deliveryPhone;

/**
 * 送货车牌
 */
@property(nonatomic,copy) NSString *license;

/**
 * 物流公司
 */
@property(nonatomic,copy) NSString *logisticsCompany;

/**
 * 运单号
 */
@property(nonatomic,copy) NSString *logisticsNo;

/**
 * 物流公司KEY
 */
@property(nonatomic,copy) NSString *logisticsCompanyKey;

/**
 * 自提地址
 */
@property(nonatomic,copy) NSString *selfAddress;

@property (nonatomic,copy) NSString *qualityInspectType;

@end

NS_ASSUME_NONNULL_END
