//
//  ReturnInfoBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/15.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsBean;
@class ExhibitionBean;

@interface ReturnInfoBean : NSObject
/**
 * 状态：success/error
 */
@property (nonatomic,copy) NSString * status;

/**
 * 新闻列表
 */
@property (nonatomic,strong) NSMutableArray <__kindof NewsBean *> * newsList;//NewsBean

/**
 * 在线展览
 */
@property (nonatomic,strong) NSMutableArray <__kindof ExhibitionBean*> * onlineList;//ExhibitionBean

/**
 * 会展信息
 */
@property (nonatomic,strong) NSMutableArray <__kindof ExhibitionBean*> * offlineList;//ExhibitionBean

/**
 * 活动列表
 */
@property (nonatomic,strong) NSMutableArray <__kindof NewsBean *> * activityList;//NewsBean

/**
 * 共几页
 */
@property (nonatomic,strong) NSNumber * pageCount;//int

/**
 * 共多少记录
 */
@property (nonatomic,strong) NSNumber * recordCount;//int

@end
