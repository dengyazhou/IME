//
//  PcwebNotification.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/8/19.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ParamsBean;

@interface PcwebNotification : NSObject

@property (nonatomic,copy) NSString * userName;

@property (nonatomic,copy) NSString * tradeCode;

@property (nonatomic,strong) NSNumber * orderType;//Integer

@property (nonatomic,copy) NSString * url;

@property (nonatomic,copy) NSString * type;//Type

/**
 * pcweb 通知内容
 */
@property (nonatomic,copy) NSString * content;

/**
 * pcweb 通知额外参数列表
 */
@property (nonatomic,strong) NSMutableArray <__kindof ParamsBean *> * paramsBeans;//ParamsBean

@end
