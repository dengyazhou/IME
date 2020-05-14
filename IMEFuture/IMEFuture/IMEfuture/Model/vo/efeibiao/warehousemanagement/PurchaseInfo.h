//
//  PurchaseInfo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/16.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PurchaseInfo : NSObject

/**
 * 采购商名
 */
@property(nonatomic,copy) NSString *  purchaseEpName;

/**
 * 收货地区信息
 */
@property(nonatomic,copy) NSString *  zoneStr;

/**
 * 收货地址
 */
@property(nonatomic,copy) NSString *  address;

/**
 * 收货联系手机
 */
@property(nonatomic,copy) NSString *  phone;

/**
 * 收货人姓名
 */
@property(nonatomic,copy) NSString *  name;

@end

NS_ASSUME_NONNULL_END
