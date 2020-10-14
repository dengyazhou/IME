//
//  MateriaProcessAssignVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/8.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface MateriaProcessAssignVo : ImeCommonVo

@property (nonatomic, copy) NSString * materialCode;//物料编号

@property (nonatomic, copy) NSString *  processCode;//工艺编码

@property (nonatomic, copy) NSString * processText;//工艺描述

@property (nonatomic, strong) NSNumber * isDefault;//是否默认 int

/**
 * 工艺版本
 */
@property (nonatomic, copy) NSString *  processRev;


@property (nonatomic, strong) NSNumber *selectDyz;//自己添加 integer 默认 为 0; 0:没选，1:选了


- (id)copyWithZone:(struct _NSZone *)zone;

@end

NS_ASSUME_NONNULL_END
