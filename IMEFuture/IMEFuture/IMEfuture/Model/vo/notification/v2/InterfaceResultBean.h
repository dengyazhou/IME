//
//  InterfaceResultBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/9/15.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InterfaceResultBean : NSObject

/**
 * 接口调用状态
 */
@property (nonatomic,copy) NSString * status;

/**
 * 错误码
 */
@property (nonatomic,copy) NSString * errorCode;

/**
 * 错误信息
 */
@property (nonatomic,copy) NSString * errorMsg;

/**
 * 附加字段
 */
@property (nonatomic,copy) NSString * extra;

@end
