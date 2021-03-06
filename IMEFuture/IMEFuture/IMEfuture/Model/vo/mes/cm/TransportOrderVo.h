//
//  TransportOrderVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/9.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"
#import "TransportOrderVo.h"
#import "TransportOrderDetailVo.h"
#import "UploadImageBean.h"
#import <MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransportOrderVo : ImeCommonVo

/**
 * ID
 */
@property (nonatomic,strong) NSNumber *idDYZ;//long

/**
 * 运输单编号
 */
@property (nonatomic,copy) NSString * transportOrderNum;

@property (nonatomic,copy) NSString * userText;

/**
 * 发货单号
 */
@property (nonatomic,copy) NSString * outgoingOrderNum;

/**
 * 运输单状态 0创建 1运输中 2已到达 3已签收
 */
@property (nonatomic,strong) NSNumber * status;//int

/**
 * 运输开始时间
 */
@property (nonatomic,copy) NSString *transportStartDatetime;//Date

/**
 * 送达时间
 */
@property (nonatomic,copy) NSString *arrivedDatetime;//Date

/**
 * 运输时长
 */
@property (nonatomic,strong) NSNumber * transportSpendTime;//Long

/**
 * 开始收货时间
 */
@property (nonatomic,copy) NSString *deliveryDatetime;//Date

/**
 * 收货完成时间
 */
@property (nonatomic,copy) NSString *deliveryCompleteDatetime;//Date

/**
 * 收货时长
 */
@property (nonatomic,strong) NSNumber * deliverySpendTime;//Long

/**
 * 送货人
 */
@property (nonatomic,copy) NSString * transportUser;

/**
 * 收货人
 */
@property (nonatomic,copy) NSString * deliveryUser;

/**
 * 客户编号
 */
@property (nonatomic,copy) NSString * supplierCode;

/**
 * 客户名
 */
@property (nonatomic,copy) NSString * supplierText;

/**
 * 送货地址
 */
@property (nonatomic,copy) NSString * address;

/**
 * 发货单数
 */
@property (nonatomic,strong) NSNumber * outgoingOrderCount;//int

/**
 * 运输单
 */
@property (nonatomic,strong) NSMutableArray <TransportOrderVo *> *transportOrderVoList;

/**
 * 运输单详情
 */
@property (nonatomic,strong) NSMutableArray <TransportOrderDetailVo *> *transportOrderDetailVoList;


/**
 存储图片类 上传是置为 nil，不然会因为数据太他而崩溃
 */
@property (nonnull,strong) UploadImageBean *uploadImageBean;

@end

NS_ASSUME_NONNULL_END
