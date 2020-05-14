//
//  MaterialOutgoingOrderCheckVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/12/17.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttachmentVo.h"
#import "MaterialOutgoingOrderDetailInventoryLotnumVo.h"
#import "CauseDetailVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MaterialOutgoingOrderCheckVo : NSObject

@property (nonatomic,copy) NSString * siteCode;
/**
 * 发货单号
 */
@property (nonatomic,copy) NSString *  outgoingOrderNum;
/**
 * 操作人
 */
@property (nonatomic,copy) NSString *  operatorUser;


/**
 * 发货图片
 */
@property (nonatomic,strong) NSMutableArray <AttachmentVo *>* outgoingAttachmentVoList;
/**
 * 发货明细批次
 */
@property (nonatomic,strong) NSMutableArray <MaterialOutgoingOrderDetailInventoryLotnumVo *> * materialOutgoingOrderDetailInventoryLotnumVoList;

/**
 * 报废图片
 */
@property (nonatomic,strong) NSMutableArray <AttachmentVo *>* defectAttachmentVoList;

@property (nonatomic, strong) NSMutableArray <__kindof CauseDetailVo *>*scrappedCauseDetailVos;//报废 //CauseDetailVo

@end

NS_ASSUME_NONNULL_END
