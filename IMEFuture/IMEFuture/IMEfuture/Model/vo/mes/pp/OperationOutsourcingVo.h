//
//  OperationOutsourcingVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/8/16.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperationOutsourcingDetailVo.h"

@interface OperationOutsourcingVo : NSObject

/**
 * 工厂代码
 */
@property (nonatomic,copy) NSString * siteCode;

/**
 * 委外单编号
 */
@property (nonatomic,copy) NSString * outsourcingCode;

/**
 * 供应商编号
 */
@property (nonatomic,copy) NSString * supplierCode;

/**
 * 供应商名称
 */
@property (nonatomic,copy) NSString * supplierText;

/**
 * 出库时间
 */
@property (nonatomic,copy) NSString * outStorageDate;//Date

/**
 * 入库时间
 */
@property (nonatomic,copy) NSString *inStorageDate;//Date

/**
 * 状态
 */
@property (nonatomic,strong) NSNumber * status;//Integer

/**
 * 交货日期
 */
//@DateTimeFormat(pattern = "yyyy-MM-dd")
@property (nonatomic,copy) NSString * deliveryDate;//Date

/**
 * 总数
 */
@property (nonatomic,strong) NSNumber * totalQuantity;//Double

/**
 *总量
 */
@property (nonatomic,strong) NSNumber * totalWeight;//Double

/**
 *总量
 */
@property (nonatomic,copy) NSString * modifyUser;

/**
 * 委外明细单集合
 */
@property (nonatomic,strong) NSMutableArray <__kindof OperationOutsourcingDetailVo *> * operationOutsourcingDetailVos;//OperationOutsourcingDetailVo

@end
