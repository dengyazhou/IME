//
//  MultiUserConfirmReportItemVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/7/24.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkTimeLogVo.h"
#import "AttachmentVo.h"
#import "CauseDetailVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MultiUserConfirmReportItemVo : NSObject

/**
 * 报工记录
 */
@property (nonatomic, strong) WorkTimeLogVo *workTimeLogVo;

/**
 * 完工数量（提交数量）
 */
@property (nonatomic, strong) NSNumber * completedQuantity;//Double

/**
 * 报废数量
 */
@property (nonatomic, strong) NSNumber *scrappedQuantity;//Double

/**
 * 返修数量
 */
@property (nonatomic, strong) NSNumber *repairQuantity;//Double

/**
 * 返修状态 0 不返修  1 返修
 */
@property (nonatomic, strong) NSNumber *reworkStatus;//int

/**
 * 报工图片集合
 */
@property (nonatomic,strong) NSMutableArray <AttachmentVo *> *confirmPictureAttachmentVoList;

/**
 * 不良数量和原因
 */
@property (nonatomic, strong) NSMutableArray <__kindof CauseDetailVo *> *repairCauseDetailVos;

/**
 * 报废数量和原因
 */
@property (nonatomic, strong) NSMutableArray <__kindof CauseDetailVo *> *scrappedCauseDetailVos;

@end

NS_ASSUME_NONNULL_END
