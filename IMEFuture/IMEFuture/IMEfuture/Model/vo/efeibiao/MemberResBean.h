//
//  MemberResBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/5/18.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
#import "EnterpriseInfoResBean.h"

NS_ASSUME_NONNULL_BEGIN

@interface MemberResBean : NSObject

    /**
    * 用户主键
    */
    @property (nonatomic,copy) NSString *idd;

   /**
    * 用户类型
    */
   @property (nonatomic,copy) NSString * memberType;

   /**
    * 用户类型值
    */
   @property (nonatomic,copy) NSString * memberTypeDesc;

   /**
    * 企业信息
    */
   @property (nonatomic,strong) EnterpriseInfoResBean * enterpriseInfo;

   /**
    * 企业ID
    */
   @property (nonatomic,copy) NSString * enterpriseInfoId;

   /**
    * 用户中心注册用户ID
    */
   @property (nonatomic,copy) NSString * userId;

   /**
    * ucenter单点登录id
    */
   @property (nonatomic,copy) NSString * ucId;

   /**
    * 企业子用户名(当memberType为C时)
    */
   @property (nonatomic,copy) NSString * childAccount;

   /**
    * 头像文件url
    */
   @property (nonatomic,copy) NSString * headImg;

   /**
    * 真实姓名
    */
   @property (nonatomic,copy) NSString * realName;

   /**
    * 用户身份列表
    */
//   private List<String[]> associatedAccounts;

   /**
    * 是否临时用户，默认为0
    */
@property (nonatomic,strong) NSNumber * isTemporary;//Integer

   /**
    * 2017.7.13
    * 非标使用人：1-是；0-否
    */
@property (nonatomic,strong) NSNumber * hasEfeibiao;//Integer

   //------------------2019.2.15邀请相关---bg-------------
   /**
    * 邀请明细ID
    */
   @property (nonatomic,copy) NSString * invitationItemId;

   /**
    * 邀请表头ID
    */
   @property (nonatomic,copy) NSString * invitationId;

   /**
    * 邀请跳转的页面
    */
   @property (nonatomic,copy) NSString * webUrl;
   //------------------2019.2.15邀请相关---end-------------

   /**
    * 用户工号
    */
   @property (nonatomic,copy) NSString * userNo;

   /**
    * 手机号
    */
   @property (nonatomic,copy) NSString * phoneNumber;

   /**
    * 邮箱
    */
   @property (nonatomic,copy) NSString * emailAddress;

   /**
    * 部门
    */
   @property (nonatomic,copy) NSString * epDept;

@end

NS_ASSUME_NONNULL_END
