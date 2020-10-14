//
//  WorkUnitVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/2.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OperationVo.h"

@interface WorkUnitVo : NSObject

/**
 * 工厂编号
 */
@property (nonatomic,copy) NSString * siteCode;
/**
 * 作业单元编号
 */
@property (nonatomic,copy) NSString * workUnitCode;
/**
 * 作业单元描述
 */
@property (nonatomic,copy) NSString * workUnitText;
/**
 * 作业单能做的工序列表
 */
@property (nonatomic,strong) NSMutableArray <__kindof OperationVo *> *operationVos;

@property (nonatomic, assign) Boolean isSelect;//DYZ 添加，用来标记是否选择了。 默认值 为 NO


@end
