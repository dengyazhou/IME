//
//  BatchWorkItemReportVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ProductionOperationVo.h"
#import "AttachmentVo.h"
#import "UploadImageBean.h"
#import "CauseDetailVo.h"

@interface BatchWorkItemReportVo : NSObject


/**
 * 报工明细
 */
@property (nonatomic,strong)  ProductionOperationVo * productionOperationVo;

/**
 * 报废图片集合
 */
@property (nonatomic,strong) NSMutableArray <__kindof AttachmentVo *> * scrappedPictureAttachmentVoList;

/**
 * 返修图片集合
 */
@property (nonatomic,strong) NSMutableArray <__kindof AttachmentVo *> * repairPictureAttachmentVoList;

/**
 * 返修数量
 */
@property (nonatomic,strong) NSNumber * repairQuantity;//Double

/**
 * 返修状态 0 不返修  1 返修
 */
@property (nonatomic,strong) NSNumber * reworkStatus;//int

/**
 * 报工记录类型 0 正常生产 1 返工返修
 */
@property (nonatomic,strong) NSNumber * workRecordType;//Integer


/**
 * 返修缺陷原因
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * repairCauseList;//String[]

/**
 * 报废缺陷原因
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * scrappedCauseList;//String[]


/**
 * 报废图片集合dyz
 */
@property (nonatomic,strong) NSMutableArray <__kindof UploadImageBean *> * scrappedPictureAttachmentVoListDyz;

/**
 * 返修图片集合dyz
 */
@property (nonatomic,strong) NSMutableArray <__kindof UploadImageBean *> * repairPictureAttachmentVoListDyz;

@property (nonatomic, strong) NSMutableArray <__kindof CauseDetailVo *>*repairCauseDetailVos;//不良 //CauseDetailVo

@property (nonatomic, strong) NSMutableArray <__kindof CauseDetailVo *>*scrappedCauseDetailVos;//报废 //CauseDetailVo




@end
