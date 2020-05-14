//
//  ExhibitionBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/15.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "BaseBean.h"

@interface ExhibitionBean : BaseBean

@property (nonatomic,copy) NSString * exhibitionId;

/**
 * 分类(O-在线展览；I-会展信息)
 */
@property (nonatomic,copy) NSString * exhibitionType;

@end
