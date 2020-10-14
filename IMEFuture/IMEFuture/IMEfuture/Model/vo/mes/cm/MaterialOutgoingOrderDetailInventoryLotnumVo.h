//
//  MaterialOutgoingOrderDetailInventoryLotnumVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/12/17.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaterialOutgoingOrderDetailInventoryLotnumVo : NSObject

@property (nonatomic,copy) NSString * siteCode;
/**
 * id
 */
@property (nonatomic,strong) NSNumber * idDYZ;//long
/**
 * 发货明细id
 */
@property (nonatomic,strong) NSNumber * materialOutgoingOrderdetailId;//long
/**
 * 项目编号
 */
@property (nonatomic,copy) NSString *  projectNum;
/**
 * 物料编号
 */
@property (nonatomic,copy) NSString *  materialCode;
/**
 * 物料名称
 */
@property (nonatomic,copy) NSString *  materialText;
/**
 * 批次号
 */
@property (nonatomic,copy) NSString *  lotNum;
/**
 * 仓库明细ID
 */
@property (nonatomic,strong) NSNumber * inventoryItemId;//long
/**
 * 计划数量
 */
@property (nonatomic,strong) NSNumber * planQuantity;
/**
 * 实际发货数
 */
@property (nonatomic,strong) NSNumber * actualQuantity;
/**
 * 合格数量
 */
@property (nonatomic,strong) NSNumber * qualifiedQuantity;
/**
 * 不合格数量
 */
@property (nonatomic,strong) NSNumber * unQualifiedQuantity;
/**
 * 检验数
 */
@property (nonatomic,strong) NSNumber * checkQuantity;
/**
 * 退货数
 */
@property (nonatomic,strong) NSNumber * rejectedQuantity;
/**
 * 单价
 */
@property (nonatomic,strong) NSNumber * price;
/**
 * 仓库
 */
@property (nonatomic,copy) NSString *  warehouseCode;

/** 检验状态  */
@property (nonatomic,strong) NSNumber * status; //private Integer status=0;

 /** 是否有图片  */
@property (nonatomic,strong) NSNumber * imgFlag; //private Integer imgFlag=0;

 /** 操作人  */
@property (nonatomic,copy) NSString *  operatorUser;
 /**
  * 客户名称
  */
@property (nonatomic,copy) NSString * supplierText;

/**
 * 缺陷原因
 */
@property (nonatomic,strong) NSMutableArray <NSString *>* causeCodes;

/**
* 来源 0：tpf 1：图纸云
*/
@property (nonatomic, strong) NSNumber *sourceFlag;

@end

NS_ASSUME_NONNULL_END
