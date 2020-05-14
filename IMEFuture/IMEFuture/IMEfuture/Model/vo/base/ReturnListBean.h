//
//  ReturnListBean.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/22.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ReturnMsgBean.h"

@class PagerBean;

@interface ReturnListBean : ReturnMsgBean

/**
 * 分页信息
 */
@property (nonatomic,strong) PagerBean *pager;


/**
 * 数据集合
 */
@property (nonatomic,strong) NSMutableArray *list; //private List<E> list;

@end
