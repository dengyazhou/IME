//
//  MultiUserConfirmReportVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/7/24.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MultiUserWorkVo.h"
#import "MultiUserConfirmReportItemVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MultiUserConfirmReportVo : NSObject

/**
 * 报工来源，
 * 1、PDA单工单报工，
 * 2、PDA多工单报工，
 * 3、APP单工单报工，
 * 4、APP多工单报工，
 * 5、PAD单工单报工，
 * 6、PAD多工单报工，
 * 7、PAD多人报工
 */
@property (nonatomic, strong) NSNumber * confirmSourceType;//Integer
/**
 * 多人报工
 */
@property (nonatomic, strong) MultiUserWorkVo * multiUserWorkVo;

/**
 * 多人报工item
 */
@property (nonatomic, strong) NSMutableArray <MultiUserConfirmReportItemVo *> * multiUserConfirmReportItemVos;

/**
 * 用户行为统计
 */
//private UserActionStatistics userActionStatistics;

@end

NS_ASSUME_NONNULL_END
