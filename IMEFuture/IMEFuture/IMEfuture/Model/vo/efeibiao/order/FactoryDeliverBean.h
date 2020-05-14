//
//  FactoryDeliverBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/4/14.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FactoryDeliverBean : NSObject

/**
 * 订单项ID
 */
@property (nonatomic,copy) NSString * tradeOrderItemId;

/**
 * 操作数量
 */
@property (nonatomic,strong) NSNumber * operateNum;//Integer

/**
 * 物流备注
 */
@property (nonatomic,copy) NSString * remark;

@end
