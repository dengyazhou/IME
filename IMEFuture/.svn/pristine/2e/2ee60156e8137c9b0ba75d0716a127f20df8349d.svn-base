//
//  DrawingFastUploadRequestBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/4/17.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DrawingFastUploadFileRequestBean.h"

@interface DrawingFastUploadRequestBean : NSObject

/** 企业ID 必填*/
@property (nonatomic,copy) NSString * enterpriseId;

/** 用户中心userId 必填*/
@property (nonatomic,copy) NSString * userId;

/** 零件号 必填*/
@property (nonatomic,copy) NSString * accCode;

/** 零件名称 必填*/
@property (nonatomic,copy) NSString * accName;

/** 图号 可选*/
@property (nonatomic,copy) NSString * figureNo;

/** 图纸列表 必填*/
@property (nonatomic,strong) NSMutableArray <__kindof DrawingFastUploadFileRequestBean *> * list;//DrawingFastUploadFileRequestBean

/** 系统标志 必填 1非标 2透明工厂*/
@property (nonatomic,copy) NSString * systemFlag;

@end
