//
//  BaseAddress.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/21.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@interface BaseAddress : BaseEntity

/**
 * 地址
 */
@property (nonatomic,copy) NSString *address;

/**
 * 邮编
 */
@property (nonatomic,copy) NSString *zipcode;

/**
 * 一级地区名称
 */
@property (nonatomic,copy) NSString *zoneId1;

/**
 * 二级地区名称
 */
@property (nonatomic,copy) NSString *zoneId2;

/**
 * 三级地区名称
 */
@property (nonatomic,copy) NSString *zoneId3;

/**
 * 地区信息
 */
@property (nonatomic,copy) NSString *zoneStr;

/**
 * 手机
 */
@property (nonatomic,copy) NSString *phone;

/**
 * 电话区号
 */
@property (nonatomic,copy) NSString *telZip;

/**
 * 电话
 */
@property (nonatomic,copy) NSString *tel;

/**
 * 分机号
 */
@property (nonatomic,copy) NSString *extension;

/**
 * 收货人姓名
 */
@property (nonatomic,copy) NSString *name;


@end
