//
//  SFOrder.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/19.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFOrder : NSObject

/**
 * 寄件方公司名称，如果需要生成电子运单，则为必填(100)
 */
@property (nonatomic,copy) NSString * j_company;

/**
 * 寄件方联系人，如果需要生成电子运单，则为必填(100)
 *
 */
@property (nonatomic,copy) NSString * j_contact;

/**
 * 寄件方联系电话，如果需要生成电子运单，则为必填(20)
 */
@property (nonatomic,copy) NSString * j_tel;

/**
 * 寄件方所在省份 字段填写要求：必须是标准的省名称称谓
 */
@property (nonatomic,copy) NSString * j_province;

/**
 * 寄件方所在城市名称，字段填写要求：必须是标准的城市称谓
 */
@property (nonatomic,copy) NSString * j_city;

/**
 * 寄件人所在县/区，必须是标准的县/区称谓
 */
@property (nonatomic,copy) NSString * j_county;

/**
 * 寄件方详细地址，包括省市区,如果需要生成电子运单，则为必填(200)
 */
@property (nonatomic,copy) NSString * j_address;

/**
 * 到件方公司名称（必填100）
 */
@property (nonatomic,copy) NSString * d_company;

/**
 * 到件方联系人（必填100）
 */
@property (nonatomic,copy) NSString * d_contact;

/**
 * 到件方联系电话（必填20）
 */
@property (nonatomic,copy) NSString * d_tel;

/**
 * 到件方所在省份，必须是标准的省名称称谓
 */
@property (nonatomic,copy) NSString * d_province;

/**
 * 到件方所在城市名称，必须是标准的城市称谓
 */
@property (nonatomic,copy) NSString * d_city;

/**
 * 到件方所在县/区，必须是标准的县/区称谓
 */
@property (nonatomic,copy) NSString * d_county;

/**
 * 到件方详细地址(200)
 * 如果不传输d_province/d_city 字段,此详细地址需包含省市信息，以提高地址识别的成功率
 */
@property (nonatomic,copy) NSString * d_address;

/**
 * 客户订单号(必填64)
 */
@property (nonatomic,copy) NSString * orderid;

@end
