//
//  EmployeeLoginModel.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/6/29.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject


@property (nonatomic,copy) NSString *enterpriseName;
@property (nonatomic,copy) NSString *errorMes;
@property (nonatomic,copy) NSString *headImg;
@property (nonatomic,copy) NSString *manufacturerId;
@property (nonatomic,copy) NSString *memberId;
@property (nonatomic,copy) NSString *neteaseToken;
@property (nonatomic,strong) NSMutableArray *notifyUrls;
@property (nonatomic,assign) NSInteger resultCode;
@property (nonatomic,copy) NSString *ucenterId;
@property (nonatomic,copy) NSString *userType;
@property (nonatomic,copy) NSString *accountName;
@property (nonatomic,copy) NSString *enterpriseId;
@property (nonatomic,copy) NSString *regStatus;//REGISTER(注册信息不完善，请到官网登录完善信息) COMPLETEDATA(账户审核中，请等待) REFUSE(账户审核失败，请到官网查看失败原因) CONFIRM(登录成)
@property (nonatomic,copy) NSString *member;//{}
//@property (nonatomic,copy) NSString *person;
@property (nonatomic,copy) NSString *identityBeans;//({},{})
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *ucenterUser;//{} UserBean 对象
@property (nonatomic,copy) NSString *tpfUser;//{} UserInfoVo 对象


@end
