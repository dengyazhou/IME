//
//  InquiryOrderItemFile.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/21.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@class InquiryOrder;
@class InquiryOrderItem;
@class UploadFile;
//#import "InquiryOrder.h"
//#import "InquiryOrderItem.h"


@interface InquiryOrderItemFile : BaseEntity


/**
 * 主键
 */
@property (nonatomic,copy) NSString *inquiryOrderItemFileId;

/**
 * 询盘单
 */
@property (nonatomic,strong) InquiryOrder *inquiryOrder;

/**
 * 询盘单ID
 */
@property (nonatomic,copy) NSString *inquiryOrderId;

/**
 * 询盘订单项
 */
@property (nonatomic,strong) InquiryOrderItem *inquiryOrderItem;

/**
 * 订单项id
 */
@property (nonatomic,copy) NSString *inquiryOrderItemId;

/**
 * 文件别名（上传时的文件名称）
 */
@property (nonatomic,copy) NSString *fileName;

/**
 * 文件的真名
 */
@property (nonatomic,copy) NSString *fileRealName;

/**
 * 文件路径（全路径 ModuleFilePath表文件路径+FileExplanation表文件子路径）
 */
@property (nonatomic,copy) NSString *filePath;

/**
 * OSS存储空间名称
 */
@property (nonatomic,copy) NSString *fileBucketName;

/**
 * 文件ID
 */
@property (nonatomic,copy) NSString *fileId;

/**
 * 展示类型
 * 0-普通；1-列表图
 */
@property (nonatomic,strong) NSNumber *showType;//Integer

/**
 * 上传的文件信息
 */
@property (nonatomic,strong) UploadFile *file;

/**
 * 查询多个询盘ID
 */
@property (nonatomic,strong) NSMutableArray * sei_inquiryOrderId;//private String[] sei_inquiryOrderId;

/**
 * 查询多个询盘项ID
 */
@property (nonatomic,strong) NSMutableArray * sei_inquiryOrderItemId;//private String[] sei_inquiryOrderItemId;

/**
 * 缩略图临时存储字段
 */
@property (nonatomic,copy) NSString *sec_thumbnailUrl;

/**
 * 实际现在地址
 */
@property (nonatomic,copy) NSString *sec_realUrl;

@end
