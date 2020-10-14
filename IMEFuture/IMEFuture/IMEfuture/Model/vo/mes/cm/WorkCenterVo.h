//
//  WorkCenterVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/8/7.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkCenterVo : ImeCommonVo

/**
 * 工厂编号
 */
@property (nonatomic, copy) NSString * siteCode;
/**
 * 工作中心编号
 */
@property (nonatomic, copy) NSString * workCenterCode;
/**
 * 工作中心类型编号
 */
@property (nonatomic, copy) NSString * workCenterTypeCode;
/**
 * 工作中心类型描述
 */
@property (nonatomic, copy) NSString * workCenterTypeText;
/**
 * 父级工作中心编号
 */
@property (nonatomic, copy) NSString * parentWorkCenterCode;
/**
 * 工作中心描述
 */
@property (nonatomic, copy) NSString * workCenterText;
/**
 * 锁定状态
 */
@property (nonatomic, strong) NSNumber * lockFlag;//int
/**
 * 创建人
 */
@property (nonatomic, copy) NSString * createUser;
/**
 * 创建时间
 */
@property (nonatomic, copy) NSString *createDateTime;//Date
/**
 * 修改人
 */
@property (nonatomic, copy) NSString * modifyUser;
/**
 * 修改时间
 */
@property (nonatomic, copy) NSString * modifyDateTime;//Date
/**
 * 日历编号
 */
@property (nonatomic, copy) NSString * calendarCode;


@property (nonatomic, strong) NSNumber *selectDyz;//自己添加 integer 默认 为 0; 0:没选，1:选了


// 自定义类实现 mutableCopy
- (id)copyWithZone:(struct _NSZone *)zone;

@end

NS_ASSUME_NONNULL_END
