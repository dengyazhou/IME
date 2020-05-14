//
//  OperationOutsourcingReceivingNoteVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/28.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "ImeCommonVo.h"

#import <MJExtension.h>
#import "OperationOutsourcingReceivingNoteItemVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface OperationOutsourcingReceivingNoteVo : ImeCommonVo

/**
 * id
 */
@property (nonatomic,strong) NSNumber * idDYZ;//Long

/**
 * 委外单编号
 */
@property (nonatomic,copy) NSString * outsourcingCode;

/**
 * 供应商编号
 */
@property (nonatomic,copy) NSString * supplierCode;

/**
 * 供应商描述
 */
@property (nonatomic,copy) NSString * supplierText;

/**
 * 发货时间
 */
@property (nonatomic,copy) NSString * sendDateTime;//Date

/**
 * 收货时间
 */
@property (nonatomic,copy) NSString * receivingDateTime;//Date

/**
 * 交货日期
 */
@property (nonatomic,copy) NSString * deliveryDate;//Date

/**
 * 发货总数量
 */
@property (nonatomic, strong) NSNumber * sendQuantityTotal;//Double

/**
 * 收货总数量
 */
@property (nonatomic, strong) NSNumber * deliveryQuantityTotal;//Double

/**
 * 发货总重量
 */
@property (nonatomic, strong) NSNumber * sendWeightTotal;//Double

/**
 * 收货总重量
 */
@property (nonatomic, strong) NSNumber * deliveryWeightTotal;//Double

/**
 * 工序委外收货单明细
 */
@property (nonatomic, strong) NSMutableArray <__kindof OperationOutsourcingReceivingNoteItemVo *> * operationOutsourcingReceivingNoteItemList;

@end

NS_ASSUME_NONNULL_END
