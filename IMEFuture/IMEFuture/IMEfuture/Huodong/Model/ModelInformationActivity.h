//
//  ModelInformationActivity.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/8.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelInformationActivity : NSObject
/*
 esultCode -1 异常0成功
 errorMes错误描述
 activityList 活动列表
 pageCount：共几页
 recordCount：共多少记录
 */
@property (strong,nonatomic) NSMutableArray *activityList;
@property (assign,nonatomic) NSInteger recordCount;
@property (assign,nonatomic) NSInteger pageCount;
@property (copy,nonatomic) NSString *errorMes;
@property (assign,nonatomic) NSInteger resultCode;
@end


@interface ModelInformationActivityActivityList : NSObject
/*
 接口：/information/informationActivity
 post body:
 {
 "page": 1,
 "pageSize": 5
 }
 参数：
	page当前页号
	pageSize每页的记录数
 说明：获取活动列表
 */
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *info;
@property (copy,nonatomic) NSString *address;
@property (copy,nonatomic) NSString *pubTm;
@property (copy,nonatomic) NSString *begTm;
@property (copy,nonatomic) NSString *endTm;
@property (copy,nonatomic) NSString *urlPath;
@property (copy,nonatomic) NSString *tagRes;
@property (copy,nonatomic) NSString *detailUrl;
@property (copy,nonatomic) NSString *newsId;
@property (copy,nonatomic) NSString *isActivity;
@property (copy,nonatomic) NSString *activityBegTm;
@property (copy,nonatomic) NSString *activityEndTm;
@end
