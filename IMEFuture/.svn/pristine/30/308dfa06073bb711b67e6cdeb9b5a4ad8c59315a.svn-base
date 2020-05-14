//
//  PmPageBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/9/15.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ParamsBean;

@interface PmPageBean : NSObject

/**
 * 创建时间
 */
@property (nonatomic,copy) NSString * createTime;//Date

/**
 * 主键
 */
@property (nonatomic,copy) NSString * pmId;

/**
 * 调用系统
 */
@property (nonatomic,copy) NSString * appName;

/**
 * 接收人普通身份用户id
 */
@property (nonatomic,copy) NSString * receiveBindUserId;

/**
 * 接收人普通身份用户ucenterId
 */
@property (nonatomic,strong) NSNumber * receiveBindUcenterId;//Integer

/**
 * 接收人实际身份用户id
 */
@property (nonatomic,copy) NSString * receiveUserId;

/**
 * 接收人实际身份用户ucenterId
 */
@property (nonatomic,strong) NSNumber *  receiveUcenterId;//Integer

/**
 * 消息统计字段,业务类型
 */
@property (nonatomic,copy) NSString * statisticStr;

/**
 * 内容
 */
@property (nonatomic,copy) NSString * content;

/**
 * 查看url
 */
@property (nonatomic,copy) NSString * detailUrl;

/**
 * 是否需要app源生界面展示
 * 0,1
 */
@property (nonatomic,strong) NSNumber *  needAppDisplay;//Integer

/**
 * app源生界面展示附加字段
 */
@property (nonatomic,strong) NSMutableArray <__kindof ParamsBean *> *extra;//ParamsBean

/**
 * 已读未读(0,1)
 */
@property (nonatomic,strong) NSNumber *  isRead;//Integer

/**
 * 总数(已读+未读)
 */
@property (nonatomic,strong) NSNumber *  totalNum;//Integer

/**
 * 未读数
 */
@property (nonatomic,strong) NSNumber *  unreadNum;//Integer

/**
 * 已读数
 */
@property (nonatomic,strong) NSNumber *  readNum;//Integer

@end
