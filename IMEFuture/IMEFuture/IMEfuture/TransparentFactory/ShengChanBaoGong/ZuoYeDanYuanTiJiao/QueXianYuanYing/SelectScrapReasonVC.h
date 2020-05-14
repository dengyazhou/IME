//
//  SelectScrapReasonVC.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/8/20.
//  Copyright © 2018年 Netease. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "UploadImageBean.h"
#import "CauseDetailVo.h"

@class ReportWorkWorkUnitScanVo;

@interface SelectScrapReasonVC : UIViewController


@property (nonatomic,copy) NSString *productionControlNum;
@property (nonatomic,copy) NSString *processOperationId;

@property (nonatomic,copy) NSString *stage;
@property (nonatomic,copy) NSString *materialCode;

@property (nonatomic, strong) NSMutableArray <__kindof CauseDetailVo *> *causeDetailVos;//传入
@property (nonatomic, copy) void(^blockArrayCauseDetailVo)(NSMutableArray <CauseDetailVo *>*causeDetailVos);//传出

@property (nonatomic, assign) double quantity;

//TypeUploadImageName：区分是报废图片还是不良图片，报废原因选择还是不良原因选择
//返修就是不良
//defectPictureFiles 报废图片
//repairPictureFiles 不良图片
//scrappedPictureFiles 报废图片
@property (nonatomic,copy) NSString *TypeUploadImageName;

//只有多工单包工的时候需要传，作为图片的fileName
@property (nonatomic,copy) NSString *productionControlNumAndprocessOperationId;






@property (nonatomic,strong) NSMutableArray * arrayCauseCode;
@property (nonatomic,strong) NSMutableArray <UploadImageBean *> * arrayUploadImageBean;

@property (nonatomic,copy) void(^blockArrayString)(NSMutableArray *arrayString);
@property (nonatomic,copy) void(^blockArrayUploadImageBean)(NSMutableArray <UploadImageBean *>*arrayUploadImageBean);


@end
