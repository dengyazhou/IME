//
//  PreviewBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/1/6.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PreviewBean : NSObject

/**
 * 预览类型 必传 值范围: ALL (所有人都能看)  ENTERPRISE (企业下的员工都能看) USER (单用户能看)
 */
@property (nonatomic,copy) NSString * type;

/**
 * 图纸id  必传
 */
@property (nonatomic,copy) NSString * adId;

/**
 *  超时时间  Long型  毫秒   非必传,  如果不传 默认半小时后链接过期
 */
@property (nonatomic,strong) NSNumber * timeou;//Long

/**
 * 用户id  type为USER 时 必传
 */
@property (nonatomic,copy) NSString * userId;

/**
 * 企业id   type为ENTERPRISE 时 必传
 */
@property (nonatomic,copy) NSString * enterpriseId;

@end
