//
//  DatabaseTool.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/25.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "DatabaseTool.h"

#import "LoginModel.h"

#import "FMDatabase.h"
#import "InquiryOrderItem.h"
#import "Zone.h"


static FMDatabase *__db;
static FMDatabase *__dbBaoJiao123;

@implementation DatabaseTool

+ (void)createDatabase {
    NSString *path = [NSString stringWithFormat:@"%@/Documents/Database.sqlite",NSHomeDirectory()];
    __db = [[FMDatabase alloc] initWithPath:path];
}

+ (void)createLoginReturn {
    [__db open];
    
    NSString *insertSql = @"create table if not exists loginModel(loginModel_id integer primary key autoincrement not null unique,enterpriseName text,errorMes text,headImg text,manufacturerId text,memberId text,neteaseToken text,notifyUrls,resultCode integer,ucenterId text,userType text,accountName text,enterpriseId text,member text,identityBeans text,userId text,ucenterUser text,tpfUser text)";
    [__db executeUpdate:insertSql];
//    [__db close];
}

+ (void)updateLoginReturnWithLogin:(LoginModel *)model {
    [__db open];
    NSString *strCount = @"select count(*) from loginModel";
    FMResultSet *set = [__db executeQuery:strCount];
    [set next];
    int a = [set intForColumn:@"count(*)"];
    [set close];
    if (a == 0) {
        NSString *insertSql = [NSString stringWithFormat:@"insert into loginModel (enterpriseName,errorMes,headImg,manufacturerId,memberId,neteaseToken,resultCode,ucenterId,userType,accountName,enterpriseId,member,identityBeans,userId,ucenterUser,tpfUser)values('%@','%@','%@','%@','%@','%@','%ld','%@','%@','%@','%@','%@','%@','%@','%@','%@')",model.enterpriseName,model.errorMes,model.headImg,model.manufacturerId,model.memberId,model.neteaseToken,model.resultCode,model.ucenterId,model.userType,model.accountName,model.enterpriseId,model.member,model.identityBeans,model.userId,model.ucenterUser,model.tpfUser];
        [__db executeUpdate:insertSql];
    } else {
        NSString *updateSql = [NSString stringWithFormat:@"update loginModel set enterpriseName = '%@',errorMes = '%@',headImg = '%@',manufacturerId = '%@',memberId = '%@',neteaseToken = '%@',resultCode = '%ld',ucenterId = '%@',userType = '%@',accountName = '%@',enterpriseId = '%@',member = '%@',identityBeans = '%@',userId = '%@',ucenterUser = '%@',tpfUser = '%@'",model.enterpriseName,model.errorMes,model.headImg,model.manufacturerId,model.memberId,model.neteaseToken,model.resultCode,model.ucenterId,model.userType,model.accountName,model.enterpriseId,model.member,model.identityBeans,model.userId,model.ucenterUser,model.tpfUser];
        [__db executeUpdate:updateSql];
    }
//    [__db close];
}

+ (void)updateLoginModelWithHeadImg:(NSString *)headImg {
    [__db open];
    NSString *updateSql = [NSString stringWithFormat:@"update loginModel set headImg = '%@'",headImg];
    [__db executeUpdate:updateSql];
}

+ (void)dropLoginModel {
    [__db open];
    NSString *clearSql = @"drop table if exists loginModel";
    [__db executeUpdate:clearSql];
//    [__db close];
    
}

//+ (void)clearLoginReturn {
//    [__db open];
//    NSString *strCount = @"select count(*) from loginModel";
//    FMResultSet *set = [__db executeQuery:strCount];
//    [set next];
//    int a = [set intForColumn:@"count(*)"];
//    [set close];
//    if (a == 0) {
//        NSString *insertSql = [NSString stringWithFormat:@"insert into loginModel (enterpriseName,errorMes,headImg,manufacturerId,memberId,neteaseToken,resultCode,ucenterId,userType,accountName,enterpriseId,member,person)values('%@','%@','%@','%@','%@','%@','%d','%@','%@','%@','%@','%@','%@')",@"",@"",@"",@"",@"",@"",0,@"",@"",@"",@"",@"",@""];
//        [__db executeUpdate:insertSql];
//    } else {
//        NSString *updateSql = [NSString stringWithFormat:@"update loginModel set enterpriseName = '',errorMes = '',headImg = '',manufacturerId = '',memberId = '',neteaseToken = '',resultCode = '0',ucenterId = '',userType = '',accountName = '',enterpriseId = '',member = '',person = ''"];
//        [__db executeUpdate:updateSql];
//    }
//    [__db close];
//}

+ (LoginModel *)getLoginModel {
    [__db open];
    NSString *select = @"select * from loginModel";
    FMResultSet *set = [__db executeQuery:select];
    LoginModel *model = [[LoginModel alloc] init];
    while ([set next]) {
        model.enterpriseName = [set stringForColumn:@"enterpriseName"];
        model.errorMes = [set stringForColumn:@"errorMes"];
        model.headImg = [set stringForColumn:@"headImg"];
        model.manufacturerId = [set stringForColumn:@"manufacturerId"];
        model.memberId = [set stringForColumn:@"memberId"];
        model.neteaseToken =[set stringForColumn:@"neteaseToken"];
        model.resultCode = [set intForColumn:@"resultCode"];
        model.ucenterId = [set stringForColumn:@"ucenterId"];
        model.userType = [set stringForColumn:@"userType"];
        model.accountName = [set stringForColumn:@"accountName"];
        model.enterpriseId = [set stringForColumn:@"enterpriseId"];
        model.member = [set stringForColumn:@"member"];
        model.identityBeans = [set stringForColumn:@"identityBeans"];
        model.userId = [set stringForColumn:@"userId"];
        model.ucenterUser = [set stringForColumn:@"ucenterUser"];
        model.tpfUser = [set stringForColumn:@"tpfUser"];
    }
    return model;
}

+ (void)t_IdentityBeanCreate {
    [__db open];
    NSString *creatT_IdentityBean = @"create table if not exists IdentityBean(IdentityBean_id integer primary key autoincrement not null unique,userId text,type integer)";
    [__db executeUpdate:creatT_IdentityBean];
}

//表中是否有
+ (BOOL)t_IdentityBeanOrHaveWithUserId:(NSString *)userId {
    [__db open];
    NSString *select = [NSString stringWithFormat:@"select * from IdentityBean where userId = '%@'",userId];
    FMResultSet *set = [__db executeQuery:select];
    NSLog(@"---set---%@",set);
    NSInteger a = 0;
    while ([set next]) {
        a++;
    }
    if (a > 0) {
        return YES;
    } else {
        return NO;
    }
}

//type 0:未选择 1:采购商 2:供应商
+ (NSInteger)t_IdentityBeanGettypeWithUserId:(NSString *)userId {
    [__db open];
    NSInteger type = 0;
    NSString *select = [NSString stringWithFormat:@"select * from IdentityBean where userId = '%@'",userId];
    FMResultSet *set = [__db executeQuery:select];
    while ([set next]) {
        type = [set intForColumn:@"type"];
    }
    return type;
}
//插入
+ (void)t_IdentityBeanInsertIntoWithUserId:(NSString *)userId andType:(NSInteger)type {
    [__db open];
    NSString *insertSql = [NSString stringWithFormat:@"insert into IdentityBean (userId,type)values('%@','%ld')",userId,type];
    [__db executeUpdate:insertSql];
    //    [__db close];
}


//更新
+ (void)t_IdentityBeanUpdateWithUserId:(NSString *)userId andType:(NSInteger)type {
    [__db open];
    NSString *updateSql = [NSString stringWithFormat:@"update IdentityBean set userId = '%@',type = '%ld'",userId,type];
    [__db executeUpdate:updateSql];
}


+ (void)t_TpfPWTableCreate {
    [__db open];
    NSString *creatT_TpfPWTable = @"create table if not exists TpfPWTable(TpfPWTable_id integer primary key autoincrement not null unique,siteCode text,personnelCode text,personnelName text,workUnitCode text,workUnitText text)";
    [__db executeUpdate:creatT_TpfPWTable];
}
+ (BOOL)t_TpfPWTableOrHaveWithSiteCode:(NSString *)siteCode {
    [__db open];
    NSString *select = [NSString stringWithFormat:@"select * from TpfPWTable where siteCode = '%@'",siteCode];
    FMResultSet *set = [__db executeQuery:select];
    NSLog(@"---set---%@",set);
    NSInteger a = 0;
    while ([set next]) {
        a++;
    }
    if (a > 0) {
        return YES;
    } else {
        return NO;
    }
}
+ (NSString *)t_TpfPWTableGetPersonnelCodeWithSiteCode:(NSString *)siteCode {
    [__db open];
    NSString * str;
    NSString *select = [NSString stringWithFormat:@"select * from TpfPWTable where siteCode = '%@'",siteCode];
    FMResultSet *set = [__db executeQuery:select];
    while ([set next]) {
        str = [set stringForColumn:@"personnelCode"];
    }
    return str;
}
+ (NSString *)t_TpfPWTableGetPersonnelNameWithSiteCode:(NSString *)siteCode {
    [__db open];
    NSString * str;
    NSString *select = [NSString stringWithFormat:@"select * from TpfPWTable where siteCode = '%@'",siteCode];
    FMResultSet *set = [__db executeQuery:select];
    while ([set next]) {
        str = [set stringForColumn:@"personnelName"];
    }
    return str;
}
+ (NSString *)t_TpfPWTableGetWorkUnitCodeWithSiteCode:(NSString *)siteCode {
    [__db open];
    NSString * str;
    NSString *select = [NSString stringWithFormat:@"select * from TpfPWTable where siteCode = '%@'",siteCode];
    FMResultSet *set = [__db executeQuery:select];
    while ([set next]) {
        str = [set stringForColumn:@"workUnitCode"];
    }
    return str;
}
+ (NSString *)t_TpfPWTableGetWorkUnitTextWithSiteCode:(NSString *)siteCode {
    [__db open];
    NSString * str;
    NSString *select = [NSString stringWithFormat:@"select * from TpfPWTable where siteCode = '%@'",siteCode];
    FMResultSet *set = [__db executeQuery:select];
    while ([set next]) {
        str = [set stringForColumn:@"workUnitText"];
    }
    return str;
}
+ (void)t_TpfPWTableInsertIntoWithSiteCode:(NSString *)siteCode andPersonnelCode:(NSString *)personnelCode andPersonnelName:(NSString *)personnelName andWorkUnitCode:(NSString *)workUnitCode andWorkUnitText:(NSString *)workUnitText {
    [__db open];
    NSString *insertSql = [NSString stringWithFormat:@"insert into TpfPWTable (siteCode,personnelCode,personnelName,workUnitCode,workUnitText)values('%@','%@','%@','%@','%@')",siteCode,personnelCode,personnelName,workUnitCode,workUnitText];
    [__db executeUpdate:insertSql];
    
}
+ (void)t_TpfPWTableUpdateWithSiteCode:(NSString *)siteCode andPersonnelCode:(NSString *)personnelCode andPersonnelName:(NSString *)personnelName {
    [__db open];
    NSString *updateSql = [NSString stringWithFormat:@"update TpfPWTable set personnelCode = '%@',personnelName = '%@' where siteCode = '%@'",personnelCode,personnelName,siteCode];
    [__db executeUpdate:updateSql];
}
+ (void)t_TpfPWTableUpdateWithSiteCode:(NSString *)siteCode andWorkUnitCode:(NSString *)workUnitCode andWorkUnitText:(NSString *)workUnitText {
    [__db open];
    NSString *updateSql = [NSString stringWithFormat:@"update TpfPWTable set workUnitCode = '%@',workUnitText = '%@' where siteCode = '%@'",workUnitCode,workUnitText,siteCode];
    [__db executeUpdate:updateSql];
}


+ (void)t_ZoneCreate {
//    NSString *path = [NSString stringWithFormat:@"%@/Documents/Database.sqlite",NSHomeDirectory()];
//    __db = [[FMDatabase alloc] initWithPath:path];
    [__db open];
    NSString *creatT_Zone = @"create table if not exists Zone(Zone_id integer primary key autoincrement not null unique,Myid integer,country_name text,name text,code text,level text,path text,pid integer,isLeaf integer)";
    [__db executeUpdate:creatT_Zone];
//    [__db close];

}

+ (void)t_ZoneInsertOpen {
    [__db open];
}

+ (void)t_ZoneInsertInto:(Zone *)zone {
    [__db open];
    NSString *insertSql = [NSString stringWithFormat:@"insert into Zone (Myid,country_name,name,code,level,path,pid,isLeaf)values('%ld','%@','%@','%@','%@','%@','%ld','%ld')",[zone.Myid integerValue],zone.country_name,zone.name,zone.code,zone.level,zone.path,[zone.pid integerValue],[zone.isLeaf integerValue]];
    [__db executeUpdate:insertSql];
//    [__db close];
}

+ (void)t_ZoneInsertClose {
    [__db close];
}

+ (void)t_Zonedrop {
    if ([self t_ZoneIsOrHave]) {//先判断Zone表是否存在，存在才会移除
        [__db open];
        NSString *clearSql = @"drop table Zone";
        [__db executeUpdate:clearSql];
//        [__db close];
    }
}

+ (BOOL)t_ZoneIsOrHave {
    [__db open];
    NSString *isOrHaveSql = @"select count(*) as 'count' from sqlite_master where type ='table' and name = 'Zone'";
//    NSString *isOrHaveSql = @"SELECT COUNT(*) FROM sqlite_master where type = 'table' and name = 'Zone'";
    FMResultSet *set = [__db executeQuery:isOrHaveSql];
    while ([set next]) {
        NSInteger count = [set intForColumn:@"count"];
        if (0 == count){
            [set close];
//            [__db close];
            return NO;
        } else {
            [set close];
//            [__db close];
            return YES;
        }
    }
    [set close];
//    [__db close];
    return NO;
}

+ (NSMutableArray *)t_ZoneSelectArrayWithMyid:(NSNumber *)myid {
    [__db open];
    NSString *select = [NSString stringWithFormat:@"select * from Zone where pid = %ld",[myid integerValue]];
    FMResultSet *set = [__db executeQuery:select];
    NSMutableArray *arrayReturn = [NSMutableArray arrayWithCapacity:0];
    while ([set next]) {
        Zone *zone = [[Zone alloc] init];
        zone.Myid = [NSNumber numberWithInteger:[set intForColumn:@"Myid"]];
        zone.country_name = [set stringForColumn:@"country_name"];
        zone.name = [set stringForColumn:@"name"];
        zone.code = [set stringForColumn:@"code"];
        zone.level = [set stringForColumn:@"level"];
        zone.path = [set stringForColumn:@"path"];
        zone.pid = [NSNumber numberWithInteger:[set intForColumn:@"pid"]];
        zone.isLeaf = [NSNumber numberWithInteger:[set intForColumn:@"isLeaf"]];
        [arrayReturn addObject:zone];
    }
    [set close];
//    [__db close];
    return arrayReturn;
}

+ (NSString *)t_ZoneSelectZoneWithZone_id:(NSNumber *)zone_id {
    [__db open];
    NSString *select = [NSString stringWithFormat:@"select * from Zone where Myid = %ld",[zone_id integerValue]];
    FMResultSet *set = [__db executeQuery:select];
    NSString *name;
    while ([set next]) {
        
//        zone.Myid = [NSNumber numberWithInteger:[set intForColumn:@"Myid"]];
//        zone.country_name = [set stringForColumn:@"country_name"];
        name = [set stringForColumn:@"name"];
//        zone.code = [set stringForColumn:@"code"];
//        zone.level = [set stringForColumn:@"level"];
//        zone.path = [set stringForColumn:@"path"];
//        zone.pid = [NSNumber numberWithInteger:[set intForColumn:@"pid"]];
//        zone.isLeaf = [NSNumber numberWithInteger:[set intForColumn:@"isLeaf"]];

    }
    [set close];
    //    [__db close];
    return name;
}


@end
