//
//  DatabaseTool.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/25.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginModel;
@class InquiryOrderItem;
@class Zone;

@interface DatabaseTool : NSObject

+ (void)createDatabase;

+ (void)createLoginReturn;

+ (void)updateLoginReturnWithLogin:(LoginModel *)model;

+ (void)updateLoginModelWithHeadImg:(NSString *)headImg;
//+ (void)clearLoginReturn;

+ (void)dropLoginModel;//删除LoginModel表

+ (LoginModel *)getLoginModel;

+ (void)t_ZoneCreate;
+ (void)t_ZoneInsertOpen;
+ (void)t_ZoneInsertInto:(Zone *)zone;
+ (void)t_ZoneInsertClose;
+ (void)t_Zonedrop;
+ (BOOL)t_ZoneIsOrHave;
+ (NSMutableArray *)t_ZoneSelectArrayWithMyid:(NSNumber *)myid;
+ (NSString *)t_ZoneSelectZoneWithZone_id:(NSNumber *)zone_id;


+ (void)t_IdentityBeanCreate;
+ (BOOL)t_IdentityBeanOrHaveWithUserId:(NSString *)userId;
+ (NSInteger)t_IdentityBeanGettypeWithUserId:(NSString *)userId;
+ (void)t_IdentityBeanInsertIntoWithUserId:(NSString *)userId andType:(NSInteger)type;
+ (void)t_IdentityBeanUpdateWithUserId:(NSString *)userId andType:(NSInteger)type;

+ (void)t_TpfPWTableCreate;
+ (BOOL)t_TpfPWTableOrHaveWithSiteCode:(NSString *)siteCode;
+ (NSString *)t_TpfPWTableGetPersonnelCodeWithSiteCode:(NSString *)siteCode;
+ (NSString *)t_TpfPWTableGetPersonnelNameWithSiteCode:(NSString *)siteCode;
+ (NSString *)t_TpfPWTableGetWorkUnitCodeWithSiteCode:(NSString *)siteCode;
+ (NSString *)t_TpfPWTableGetWorkUnitTextWithSiteCode:(NSString *)siteCode;
+ (void)t_TpfPWTableInsertIntoWithSiteCode:(NSString *)siteCode andPersonnelCode:(NSString *)personnelCode andPersonnelName:(NSString *)personnelName andWorkUnitCode:(NSString *)workUnitCode andWorkUnitText:(NSString *)workUnitText;
+ (void)t_TpfPWTableUpdateWithSiteCode:(NSString *)siteCode andPersonnelCode:(NSString *)personnelCode andPersonnelName:(NSString *)personnelName;
+ (void)t_TpfPWTableUpdateWithSiteCode:(NSString *)siteCode andWorkUnitCode:(NSString *)workUnitCode andWorkUnitText:(NSString *)workUnitText;





//+ (void)createBaoJia123;
//+ (void)insertIntoBaoJia123;
//+ (void)insertIntoBaoJiaLingJian123with:(NSInteger)num with:(NSMutableArray <__kindof InquiryOrderItem *> *)arrayInquiryOrderItemModel;
//+ (void)deleteBaoJia123;
//+ (void)updateBaoJiaLingJian123:(double)price with:(NSInteger)num with:(NSInteger)indexRow;
//+ (void)updateBaoJia123Cost:(double)cost with:(NSInteger)num;
//+ (void)updateBaoJia123ShipPrice:(double)shipPrice with:(NSInteger)num;
//+ (void)updateBaoJia123SubtotalPrice:(double)subtotalPrice with:(NSInteger)num;
//+ (void)updateBaoJia123TotalPrice:(double)totalPrice with:(NSInteger)num;
//+ (void)updateBaoJia123Remark:(NSString *)remark with:(NSInteger)num;
@end
