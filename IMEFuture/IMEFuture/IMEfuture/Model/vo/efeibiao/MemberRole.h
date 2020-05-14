//
//  MemberRole.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/8/12.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@class Member;
@class Role;

@interface MemberRole : BaseEntity

@property (nonatomic,strong) NSNumber * memberRoleId;//Integer

/**
 * 用户
 */
@property (nonatomic,strong) Member * member;

/**
 * 用户ID
 */
@property (nonatomic,copy) NSString * memberId;

/**
 * 角色
 */
@property (nonatomic,strong) Role * role;

/**
 * 角色ID
 */
@property (nonatomic,copy) NSString * roleId;

/**
 * 查询某企业企业用户的权限
 */
@property (nonatomic,copy) NSString * m__manufacturerId;

@end
