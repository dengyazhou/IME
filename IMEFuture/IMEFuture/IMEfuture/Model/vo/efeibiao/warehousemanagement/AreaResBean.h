//
//  AreaResBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/16.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AreaResBean : NSObject

/**
 * 主键
 */
@property(nonatomic,copy) NSString * enterpriseExpandId;

/**
 * 是否默认
 */
@property(nonatomic,strong) NSNumber * isDefault;

/**
 * 是否免检
 */
@property(nonatomic,strong) NSNumber * isMianjian;

/**
 * 收货区名
 */
@property(nonatomic,copy) NSString * attributeName;

/**
 * 备注
 */
@property(nonatomic,copy) NSString * attributeRemark;

@end

NS_ASSUME_NONNULL_END
