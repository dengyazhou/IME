//
//  CiPingChuLiModel.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/19.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CiPingChuLiModel : NSObject

/**
 * 次品处理方式
 */
@property (nonatomic,copy) NSString * defectiveOperateType;

/**
 * 返修数量
 */
@property (nonatomic,strong) NSNumber * reissueNum;//Integer

/**
 * 供应商是否需要补发
 * 0-否；1-是
 */
@property (nonatomic,strong) NSNumber * isNeedSend;//Integer

/**
 * 不合格原因
 */
@property (nonatomic,copy) NSString * unReason;

@property (nonatomic,copy) NSString * unType;

@end
