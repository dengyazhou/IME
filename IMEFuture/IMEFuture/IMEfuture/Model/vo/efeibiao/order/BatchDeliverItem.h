//
//  BatchDeliverItem.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/11/22.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@interface BatchDeliverItem : BaseEntity

/**
 * 发货数量
 */
@property (nonatomic,copy) NSString * num;

/**
 * 期望发货日期
 */
@property (nonatomic,copy) NSString * deliverTm;//Date

@end
