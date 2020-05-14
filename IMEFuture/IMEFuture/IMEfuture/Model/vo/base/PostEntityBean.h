//
//  PostEntityBean.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/21.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PagerBean;
@class OrderByBean;

@interface PostEntityBean : NSObject


/**
 * 分页信息
 */
@property (nonatomic,strong) PagerBean *pager;

/**
 * 数据Bean
 */
@property (nonatomic,strong) id entity;//T

/**
 * 额外的json字符串
 */
@property (nonatomic,copy) NSString *jsonStr;

/**
 * 排序信息
 */
@property (nonatomic,strong) NSMutableArray <__kindof OrderByBean *> *order;//放的是OrderByBean

@property (nonatomic,copy) NSString * version;


@end
