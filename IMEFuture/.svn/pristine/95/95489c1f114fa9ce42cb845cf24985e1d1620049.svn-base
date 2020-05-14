//
//  FactoryProductInfo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/9/20.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProductionOrderInfoForShow;


@interface FactoryProductInfo : NSObject

/**
 * 生产进度百分比
 */
@property (nonatomic,strong) NSNumber * processPercent;//Integer

/**
 * 产品完工率百分比
 */
@property (nonatomic,strong) NSNumber * productFinishPercent;//Integer

/**
 * 距交货时间
 */
@property (nonatomic,strong) NSNumber * surplusDay;//Integer

/**
 * 第一次报工时间
 */
@property (nonatomic,copy) NSString * confirmDateTime;

/**
 * 零件生产信息
 */
@property (nonatomic,strong) NSMutableArray <__kindof ProductionOrderInfoForShow *> *productionOrderInfoForShowList;

@end
