//
//  DrawingCloudBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/4/2.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawingCloudBean : NSObject

/**
 * 采购清单主键或询盘项主键或订单项主键
 */
@property (nonatomic,strong) NSMutableArray <NSString *> *ids;

/**
 * 1采购清单 2询盘 3订单
 */
@property (nonatomic,strong) NSNumber *type;//int

@end

NS_ASSUME_NONNULL_END
