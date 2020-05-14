//
//  TpfConfirmInfo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/6/11.
//  Copyright © 2019 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TpfConfirmInfo : NSObject

/**
 * 生产管理号--生产作业号
 */
@property (nonatomic,copy) NSString * productionControlNum;
/**
 * 计划数量
 */
@property (nonatomic,copy) NSString * plannedQuantity;
/**
 * 完工数量
 */
@property (nonatomic,copy) NSString * completedQuantity;

@end

NS_ASSUME_NONNULL_END
