//
//  EnterpriseRefuseInfoBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/8/1.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnterpriseRefuseInfoBean : NSObject

/**
 * 拒绝内容
 */
@property (nonatomic,copy) NSString * content;

/**
 * 操作员
 */
@property (nonatomic,copy) NSString * userName;

/**
 * 对应的审核次数
 */
@property (nonatomic,strong) NSNumber * confirmNum;//Integer
@end
