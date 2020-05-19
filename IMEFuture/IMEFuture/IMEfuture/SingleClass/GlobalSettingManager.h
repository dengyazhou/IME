//
//  GlobalSettingManager.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/2.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VoHeader.h"

@class MemberResBean;

NS_ASSUME_NONNULL_BEGIN

@interface GlobalSettingManager : NSObject

/**
 采购商企业全局配置Array 自定义字段
 */
@property (nonatomic, strong) NSMutableArray <GlobalTemplateBean *> *purchaseGlobalTemplateArray;

/**
 供应商企业全局配置Array
 */
@property (nonatomic, strong) NSMutableArray <GlobalTemplateBean *> *supplierGlobalTemplateArray;

/**
 非标权限数组
 */
@property (nonatomic, strong) NSMutableArray *competenceTypeArray;

/**
  透明工厂权限数组
 */
@property (nonatomic, strong) NSMutableArray *userRoleAuthorities;

/**
 报工是否显示计划工时（0：否，1：是）
 */
@property (nonatomic, assign) NSInteger showPlanHour;

/**
  iQC入库模式
  1：一步入库
  2：两步入库
  3：三步入库
 */
@property (nonatomic, assign) NSInteger iQCPattern;

/**
多工单报工入口（0：否，1：是）
*/
@property (nonatomic, assign) NSInteger showMultiltask;


@property (nonatomic, strong) MemberResBean *member;

/**
  非标的memberId
 */
@property (nonatomic,copy) NSString *memberId;

/**
    非标的manufacturerId
 */
@property (nonatomic,copy) NSString *manufacturerId;

/**
 非标的token
 */
@property (nonatomic, copy) NSString *eFeiBiaoToken;


+ (instancetype)shareGlobalSettingManager;

/**
 采购商企业全局配置Array 自定义字段 赋值
 */
//- (void)requestPurchaseGlobalTemplate;//没有做、2020.4.14

//- (void)requestSupplierGlobalTemplate;//没有做、2020.4.14


// 获取非标的权限列表 并且给权限数组competenceTypeArray 赋值
// @param token 用户的token
- (void)requestfbCompetenceAllWithfbToken:(NSString *)token;



/// 透明工程，获取参数配置接口
/// @param siteCode 工厂编号
- (void)requesttpfGetparameterlistWithSiteCode:(NSString *)siteCode;


@end

NS_ASSUME_NONNULL_END
