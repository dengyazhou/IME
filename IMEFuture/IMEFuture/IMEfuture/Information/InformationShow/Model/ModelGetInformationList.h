//
//  ModelGetInformationList.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/8.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ModelGetInformationList : NSObject

@property (strong,nonatomic) NSMutableArray *newsList;
@property (strong,nonatomic) NSMutableArray *offlineList;
@property (strong,nonatomic) NSMutableArray *onlineList;
@property (assign,nonatomic) NSInteger recordCount;
@property (assign,nonatomic) NSInteger pageCount;
@property (copy,nonatomic) NSString *errorMes;
@property (assign,nonatomic) NSInteger resultCode;

@end




@interface ModelGetInformationListList : NSObject

@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *info;
@property (copy,nonatomic) NSString *address;
@property (copy,nonatomic) NSString *pubTm;
@property (copy,nonatomic) NSString *begTm;
@property (copy,nonatomic) NSString *endTm;
@property (copy,nonatomic) NSString *urlPath;
@property (strong,nonatomic) NSMutableArray *tagRes;
@property (copy,nonatomic) NSString *detailUrl;
@property (copy,nonatomic) NSString *newsId;
@property (copy,nonatomic) NSString *isActivity;
@property (copy,nonatomic) NSString *activityBegTm;
@property (copy,nonatomic) NSString *activityEndTm;

@end



@interface ModelGetInformationListListTagRes : NSObject

@property (copy,nonatomic) NSString *name;

@end
