//
//  TemporaryTaskShutdownVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/18.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"
#import <MJExtension.h>


NS_ASSUME_NONNULL_BEGIN

@interface TemporaryTaskShutdownVo : ImeCommonVo

/**
 * ID
 */
@property (nonatomic, strong) NSNumber * idDYZ;//Long

/**
 * 临时任务ID
 */
@property (nonatomic, strong) NSNumber * temporaryTaskId;//Long

/**
 * 暂停原因
 */
@property (nonatomic, copy) NSString * shutdownCause;

/**
 * 暂停开始
 */
@property (nonatomic, copy) NSString * startDateTime;//Date

/**
 * 暂停结束
 */
@property (nonatomic, copy) NSString * actualEndDateTime;//Date


/**
 * 暂停时长
 */
@property (nonatomic, strong) NSNumber * shutdownTime;//Long

/**
 * 暂停开始人
 */
@property (nonatomic, copy) NSString * startUser;

/**
 * 暂停结束人
 */
@property (nonatomic, copy) NSString * actualEndUser;

@end

NS_ASSUME_NONNULL_END
