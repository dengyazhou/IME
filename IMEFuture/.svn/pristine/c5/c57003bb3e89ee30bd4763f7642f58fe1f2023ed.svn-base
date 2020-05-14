//
//  BaseBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/15.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TagReBean;

@interface BaseBean : NSObject

/**
 * 标题
 */
@property (nonatomic,copy) NSString * title;

/**
 * 简介
 */
@property (nonatomic,copy) NSString * info;

/**
 * 地址
 */
@property (nonatomic,copy) NSString * address;

/**
 * 发布时间
 */
@property (nonatomic,strong) NSDate * pubTm;//Date

/**
 * 开始时间
 */
@property (nonatomic,strong) NSDate * begTm;//Date

/**
 * 结束时间
 */
@property (nonatomic,strong) NSDate * endTm;//Date

/**
 * 图片Url
 */
@property (nonatomic,copy) NSString * urlPath;

/**
 * 标签列表
 */
@property (nonatomic,strong) NSMutableArray <__kindof TagReBean *> *tagRes;//TagReBean

/**
 * 详情URL
 */
@property (nonatomic,copy) NSString * detailUrl;

@end
