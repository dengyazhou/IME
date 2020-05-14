//
//  ConfirmReportVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/2.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ReportWorkProductionOrderConfirmVo;
@class AttachmentVo;

@interface ConfirmReportVo : NSObject

/**
 * 报工明细记录
 */
@property (nonatomic,strong) ReportWorkProductionOrderConfirmVo * productionOrderConfirmVo;

/**
 * 报工图片集合
 */
@property (nonatomic,strong) NSMutableArray <__kindof AttachmentVo *> * confirmPictureAttachmentVoList;//AttachmentVo

/**
 * 报废图片集合
 */
@property (nonatomic,strong) NSMutableArray <__kindof AttachmentVo *> * defectPictureAttachmentVoList;//AttachmentVo

@end
