//
//  ReturnMsgBean.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/21.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReturnMsgBean : NSObject

/**
 * 成功
 */
@property (nonatomic,copy) NSString *SUCCESS; //public static final String SUCCESS = "SUCCESS";

/**
 * 错误
 */
@property (nonatomic,copy) NSString *ERROR; //public static final String ERROR = "ERROR";

/**
 * 没有权限
 */
@property (nonatomic,copy) NSString *PROHIBIT;//public static final String PROHIBIT = "PROHIBIT";

/**
 * 参数错误
 */
@property (nonatomic,copy) NSString *PARAMERROR; //public static final String PARAMERROR = "参数错误";

/**
 * 系统异常
 */
@property (nonatomic,copy) NSString *EXCEPTION; //public static final String EXCEPTION = "系统异常";

/**
 * 返回码-成功
 */
@property (nonatomic,assign) int CODE_SU; //public static final int CODE_SU = 0;

/**
 * 返回码-异常
 */
@property (nonatomic,assign) int CODE_PA; //public static final int CODE_PA = -1;

/**
 * 返回码-参数错误
 */
@property (nonatomic,assign) int CODE_EX; //public static final int CODE_EX = -2;

/**
 * 返回码-未知错误
 */
@property (nonatomic,assign) int CODE_ER; //public static final int CODE_ER = -3;

/**
 * 返回状态
 */
@property (nonatomic,copy) NSString *status;

/**
 * 返回代码
 */
@property (nonatomic,strong) NSNumber *returnCode;//Integer

/**
 * 返回信息
 */
@property (nonatomic,copy) NSString *returnMsg;

/**
 * 用户ID
 */
@property (nonatomic,copy) NSString *memberId;

@property (nonatomic,copy) NSString *salt;

@end
