//
//  PagerBean.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/21.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PagerBean : NSObject

/**
 * 每页的记录数
 */
@property (nonatomic,strong) NSNumber * pageSize;//int

/**
 * 共几页
 */
@property (nonatomic,strong) NSNumber *  pageCount;//int

/**
 * 共多少记录
 */
@property (nonatomic,strong) NSNumber *  recordCount;//int

/**
 * 当前页号
 */
@property (nonatomic,strong) NSNumber *  page;//int

/**
 * 获取前几条记录
 */
@property (nonatomic,strong) NSNumber * topRecords;//Integer

@end
