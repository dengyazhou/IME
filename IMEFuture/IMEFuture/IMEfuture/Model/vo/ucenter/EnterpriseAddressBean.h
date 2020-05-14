//
//  EnterpriseAddressBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/8/1.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnterpriseAddressBean : NSObject

/**
 * 企业ID
 */
@property (nonatomic,copy) NSString * enterpriseId;

/**
 * 地址id
 */
@property (nonatomic,copy) NSString *addressId;

/**
 * 是否默认地址
 */
@property (nonatomic,strong) NSNumber *isDefault;//Integer

/**
 * 地址
 */
@property (nonatomic,copy) NSString * address;

/**
 * 邮编
 */
@property (nonatomic,copy) NSString *zipcode;

/**
 * 一级地区名称
 */
@property (nonatomic,copy) NSString * zoneId1;

/**
 * 二级地区名称
 */
@property (nonatomic,copy) NSString * zoneId2;

/**
 * 三级地区名称
 */
@property (nonatomic,copy) NSString * zoneId3;

/**
 * 地区信息
 */
@property (nonatomic,copy) NSString * zoneStr;

/**
 * 手机
 */
@property (nonatomic,copy) NSString * phone;

/**
 * 电话区号
 */
@property (nonatomic,copy) NSString * telZip;

/**
 * 电话
 */
@property (nonatomic,copy) NSString * tel;

/**
 * 分机号
 */
@property (nonatomic,copy) NSString * extension;

/**
 * 收货人姓名
 */
@property (nonatomic,copy) NSString * name;

@end
