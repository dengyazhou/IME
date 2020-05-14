//
//  Role.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/8/12.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"
@class MemberRole;

@interface Role : BaseEntity

@property (nonatomic,strong) NSNumber * roleId;//Integer

/**
 * 角色名
 */
@property (nonatomic,copy) NSString * name;

/**
 * 拥有的用户
 */
@property (nonatomic,strong) NSMutableArray <__kindof MemberRole *> * members;//MemberRole

/**
 * 描述
 */
@property (nonatomic,copy) NSString * cmpDesc;

/**
 * 用户中心需要的描述
 */
@property (nonatomic,copy) NSString * ucDesc;

@end
