//
//  ProcessOperationVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/9.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProcessOperationVo : NSObject

/**
 * 工厂编号
 */
@property (nonatomic, copy) NSString * siteCode;

/**
 * 工艺版本
 */
@property (nonatomic, copy) NSString * processRev;

/**
 * 工艺编号
 */
@property (nonatomic, copy) NSString * processCode;

/**
 * 工序编号
 */
@property (nonatomic, copy) NSString * operationCode;

/**
 * 工序名称
 */
@property (nonatomic, copy) NSString * operationText;

@end
