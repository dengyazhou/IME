//
//  OrderByBean.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/21.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderByBean : NSObject

/**
 * 名称
 */
@property (nonatomic,copy) NSString *orderName;

/**
 * 排序
 */
@property (nonatomic,copy) NSString *orderSort;

@end
