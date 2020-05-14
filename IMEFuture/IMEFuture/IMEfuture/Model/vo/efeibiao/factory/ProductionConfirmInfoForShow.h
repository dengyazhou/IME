//
//  ProductionConfirmInfoForShow.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/9/20.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ProductionConfirmInfo.h"

@class TpfOperationForShow;

@interface ProductionConfirmInfoForShow : ProductionConfirmInfo

/**
 * 生产进度百分比
 */
@property (nonatomic,strong) NSNumber * processPercent;//Integer

/**
 * 产品完工率百分比
 */
@property (nonatomic,strong) NSNumber * productFinishPercent;//Integer

/**
 * 工序统计
 */
@property (nonatomic,strong) NSMutableArray <__kindof TpfOperationForShow *> *tpfOperationForShowList;

@end
