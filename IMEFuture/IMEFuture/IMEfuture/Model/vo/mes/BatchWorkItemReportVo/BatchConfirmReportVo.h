//
//  BatchConfirmReportVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BatchWorkVo.h"
#import "BatchWorkItemReportVo.h"

@interface BatchConfirmReportVo : NSObject

/**
 * 报工多任务单记录
 */
@property (nonatomic,strong)  BatchWorkVo * batchWorkVo;

/**
 * 报工明细记录
 */
@property (nonatomic,strong) NSMutableArray <__kindof BatchWorkItemReportVo*>*  batchWorkItemReportVos;

/**
 * 用户行为统计
 */
//private UserActionStatistics userActionStatistics;

@end
