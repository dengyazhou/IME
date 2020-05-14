//
//  PageQueryBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/9/15.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageQueryBean : NSObject

/**
 * 查询用户id
 */
@property (nonatomic,copy) NSString *requestUserId;

/**
 * 查询页码
 */
@property (nonatomic,strong) NSNumber * requestPage;//Integer

/**
 * 查询每页数量
 */
@property (nonatomic,strong) NSNumber * requestPageSize;//Integer

/**
 * 查询状态
 */
@property (nonatomic,strong) NSNumber * requestStatus;//Integer 1:全部 2:已读 3:未读

/**
 * 调用系统筛选
 */
@property (nonatomic,copy) NSString * requestAppName;

/**
 * 接口调用状态
 */
@property (nonatomic,copy) NSString *status;

/**
 * 错误码
 */
@property (nonatomic,copy) NSString *errorCode;

/**
 * 错误信息
 */
@property (nonatomic,copy) NSString * errorMsg;

/**
 * 总记录数
 */
@property (nonatomic,strong) NSNumber * responseRecordCount;//Integer

/**
 * 总页数
 */
@property (nonatomic,strong) NSNumber * responsePageCount;//Integer

/**
 * 当前页内数据明细
 */
@property (nonatomic,strong) NSMutableArray * responseData;//private List<?> responseData;

/**
 * 总数(已读+未读)
 */
@property (nonatomic,strong) NSNumber * totalNum;//Integer

/**
 * 未读数
 */
@property (nonatomic,strong) NSNumber * unreadNum;//Integer

/**
 * 已读数
 */
@property (nonatomic,strong) NSNumber * readNum;//Integer

@end
