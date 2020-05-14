//
//  MaterialArrivedOrderDetailVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/19.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttachmentVo.h"
#import "CauseDetailVo.h"

@interface MaterialArrivedOrderDetailVo : NSObject

/**
 * id
 */
//private Long id;
/**
 * id
 */
@property (nonatomic,strong) NSNumber * arriveId;//Long
/**
 * 工厂代码
 */
@property (nonatomic,copy) NSString * siteCode;

/**
 * 到货单
 * */
@property (nonatomic,copy) NSString * arrivedOrderNum;

/**
 * 供应商编号
 * */
@property (nonatomic,copy) NSString * supplierCode;

/**
 * 供应商名称
 * */
@property (nonatomic,copy) NSString * supplierText;

/**
 * 项目编号
 * */
@property (nonatomic,copy) NSString * projectNum;

/**
 * 合格品仓库
 */
@property (nonatomic,copy) NSString * qnWarehouseCode;

/**
 * 不合格品仓库
 */
@property (nonatomic,copy) NSString * noWarehouseCode;

/**
 * 生产订单编号
 */
@property (nonatomic,copy) NSString * productionOrderNum;

/**
 * 物料编号
 * */
@property (nonatomic,copy) NSString * materialCode;

/**
 * 物料编号
 * */
@property (nonatomic,copy) NSString * materialText;

/**
 * 计划数量
 * */
@property (nonatomic,strong) NSNumber * planQuantity;//Double

/**
 * 收货数量
 * */
@property (nonatomic,strong) NSNumber * receivedQuantity;//Double

/**
 * 入库数
 */
@property (nonatomic,strong) NSNumber * inStockQuantity;//Double

/**
 * 合格数量
 */
@property (nonatomic,strong) NSNumber * qualifiedQuantity;//Double

/**
 * 业务类型
 */
@property (nonatomic,copy) NSString * moveTypeCode;

/**
 * 检验状态
 *0:创建                          待收货
 *1:已收货                      待检验
 *2:已质检                      待入库
 *3:已入库                      已入库
 * */
@property (nonatomic,strong) NSNumber * status;//Integer

/**
 * 接收人编号
 * */
@property (nonatomic,copy) NSString * receivedUser;

/**
 * 生产订单编号
 * */
@property (nonatomic,copy) NSString * productionOrder;

/**
 * 来源单号
 * */
@property (nonatomic,copy) NSString * sourceNum;

/**
 * 接收人姓名
 * */
@property (nonatomic,copy) NSString * personnelName;

/**
 * 创建人姓名
 * */
@property (nonatomic,copy) NSString * userText;

/**
 * 备注
 * */
@property (nonatomic,copy) NSString * memo;

/**
 * 物料规格
 * */
@property (nonatomic,copy) NSString * materialspec;

/**
 * 物料单位描述 NVARCHAR(60)
 */
@property (nonatomic,copy) NSString * materialUnitText;

/**
 * 业务类型
 */
@property (nonatomic,copy) NSString * moveTypeText;

/**
 * 缺陷原因
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * causeCodes;

/**
 * 让步数量
 */
@property (nonatomic,strong) NSNumber * concessionQuantity;

/**
 * 不合格数量
 */
@property (nonatomic,strong) NSNumber * unQqualifiedQuantity;

/**
 * 图片flag
 */
@property (nonatomic,strong) NSNumber * imgFlag;//Integer


/**
 * 良率
 */
@property (nonatomic,copy) NSString * qualityRate;

/**
 * 良率
 */
@property (nonatomic,copy) NSString * noQualityRate;

/**
 * 缺陷原因
 */
@property (nonatomic,copy) NSString * causeTexts;

/**
 * 解決方案
 */
@property (nonatomic,copy) NSString * solution;

/**
 * 采购单价
 */
@property (nonatomic,strong) NSNumber * purchaseUnitPrice;

//让步原因
@property (nonatomic,copy) NSString * concessionCause;

//报废数量
@property (nonatomic,strong) NSNumber * scrappedQuantity;

//报废原因
@property (nonatomic,copy) NSString * scrappedCause;

@property (nonatomic,strong) NSMutableArray <__kindof AttachmentVo *> *attachmentVos;


@property (nonatomic, strong) NSMutableArray <__kindof CauseDetailVo *>*scrappedCauseDetailVos;//报废 //CauseDetailVo

// 自定义类实现 mutableCopy
- (id)mutableCopyWithZone:(struct _NSZone *)zone;

@end
