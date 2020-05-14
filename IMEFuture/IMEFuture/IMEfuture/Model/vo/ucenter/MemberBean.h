//
//  MemberBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/8/1.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserBean;

@interface MemberBean : NSObject

/**
 * 状态(success: 成功, error: 失败)
 */
@property (nonatomic,copy) NSString * status;

/**
 * 错误信息
 */
@property (nonatomic,copy) NSString *  errorMsg;

/**
 * 成功信息
 */
@property (nonatomic,copy) NSString *  successMsg;

/**
 * 用户信息
 */
@property (nonatomic,strong) UserBean * userBean;

@end
