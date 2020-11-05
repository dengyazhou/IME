//
//  InspectionBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/11/4.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InspectionBean : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *supplierManufacturerId;
@property (nonatomic, copy) NSString *inspectionType;
@property (nonatomic, copy) NSString *inspectionDate;
@property (nonatomic, copy) NSString *inspectionCommentKey1;//质量
@property (nonatomic, copy) NSString *inspectionCommentKey2;//成本
@property (nonatomic, copy) NSString *inspectionCommentKey3;//支付
@property (nonatomic, copy) NSString *inspectionCommentKey4;//响应
@property (nonatomic, copy) NSString *inspectionCommentKey5;//其他
@property (nonatomic, copy) NSString *inspectionCommentValue1;
@property (nonatomic, copy) NSString *inspectionCommentValue2;
@property (nonatomic, copy) NSString *inspectionCommentValue3;
@property (nonatomic, copy) NSString *inspectionCommentValue4;
@property (nonatomic, copy) NSString *inspectionCommentValue5;

@property (nonatomic, copy) NSString *fileName1;
@property (nonatomic, copy) NSString *fileRealName1;
@property (nonatomic, copy) NSString *filePath1;
@property (nonatomic, copy) NSString *fileName2;
@property (nonatomic, copy) NSString *fileRealName2;
@property (nonatomic, copy) NSString *filePath2;
@property (nonatomic, copy) NSString *fileName3;
@property (nonatomic, copy) NSString *fileRealName3;
@property (nonatomic, copy) NSString *filePath3;
@property (nonatomic, copy) NSString *fileName4;
@property (nonatomic, copy) NSString *fileRealName4;
@property (nonatomic, copy) NSString *filePath4;
@property (nonatomic, copy) NSString *fileName5;
@property (nonatomic, copy) NSString *fileRealName5;
@property (nonatomic, copy) NSString *filePath5;

@property (nonatomic, copy) NSString *inspectionCode;
@property (nonatomic, copy) NSString *memberName;
@property (nonatomic, copy) NSString *supplierEnterpriseName;

@property (nonatomic, copy) NSString *accountingHours;
@property (nonatomic, copy) NSString *createTime;


@end

NS_ASSUME_NONNULL_END
