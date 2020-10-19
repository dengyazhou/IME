//
//  ModelReturnCauseVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/10/14.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ModelReturnCauseVo : ImeCommonVo

/**
 * 原因编号
 */
@property (nonatomic, copy) NSString * causeCode;
/**
 * 原因描述
 */
@property (nonatomic, copy) NSString * causeText;
/**
 * 锁定标记
 */
@property (nonatomic, strong) NSNumber * lockFlag;//Integer

@end

NS_ASSUME_NONNULL_END
