//
//  AppInfoBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/15.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfoBean : NSObject

/**
 * 每页的记录数
 * 小于1，则默认查询所有信息
 */
@property (nonatomic,strong) NSNumber * pageSize;//int

/**
 * 当前页号
 */
@property (nonatomic,strong) NSNumber * page;//int

/**
 * 发布类型（O-官网；N-非标；A-官方和非标）
 * 若空则默认查询所有
 */
@property (nonatomic,copy) NSString * publishType;

/**
 * 查询信息
 */
@property (nonatomic,copy) NSString * searchInfo;

/**
 * 信息类型（N-资讯；O-在线展览；I-会展信息;）
 */
@property (nonatomic,copy) NSString * infoType;

@end
