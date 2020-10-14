//
//  PersonnelTypeVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/8/8.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonnelVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonnelTypeVo : NSObject

/**
 * 工厂编号
 */
@property (nonatomic, copy) NSString * siteCode;
/**
 * 人员类型编号
 */
@property (nonatomic, copy) NSString *  personnelTypeCode;
/**
 * 人员类型名称
 */
@property (nonatomic, copy) NSString *  personnelTypeText;
/**
 * 人员类型对应的人员列表
 */
@property (nonatomic, strong) NSMutableArray <PersonnelVo * >* personnelVoList;//PersonnelVo


- (id)copyWithZone:(struct _NSZone *)zone;

@end

NS_ASSUME_NONNULL_END
