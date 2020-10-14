//
//  MaterialVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/1/7.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaterialVo : NSObject

/**
 * 工厂代码
 */
@property (nonatomic,copy) NSString * siteCode;

/**
 * 物料编号
 */
@property (nonatomic,copy) NSString * materialCode;

/**
 * 物料类型编码
 */
@property (nonatomic,copy) NSString * materialTypeCode;

/**
 * 物料类型描述
 */
@property (nonatomic,copy) NSString * materialTypeText;

/**
 * 物料描述
 */
@property (nonatomic,copy) NSString * materialText;

/**
 * 默认工艺编码
 */
@property (nonatomic,copy) NSString * processCode;

/**
 * 默认工艺名称
 */
@property (nonatomic,copy) NSString * processText;

/**
 * 默认工作中心
 */
@property (nonatomic,copy) NSString * workCenterCode;

/**
 * 默认工作中心描述
 */
@property (nonatomic,copy) NSString * workCenterText;

/**
 * BOM编号
 */
@property (nonatomic,copy) NSString * bomCode;

/**
 * BOM描述
 */
@property (nonatomic,copy) NSString * bomText;

/**
 * 自制件标记
 */
@property (nonatomic,strong) NSNumber * makeFlag;//Integer = 0

/**
 * 采购件标记
 */
@property (nonatomic,strong) NSNumber * buyFlag;//Integer = 0

/**
 * 生产批量
 */
@property (nonatomic,strong) NSNumber * makelotsize;//Long

/**
 * 物料规格
 */
@property (nonatomic,copy) NSString * materialspec;

/**
 * 物料提前期(单位：天)
 */
@property (nonatomic,strong) NSNumber * materialLeadTimeNum;//Integer

/**
 * 物料单位编号 NVARCHAR(20)
 */
@property (nonatomic,copy) NSString * materialUnitCode;

/**
 * 物料单位描述 NVARCHAR(60)
 */
@property (nonatomic,copy) NSString * materialUnitText;

/**
 * 图档编号 NVARCHAR(35)
 */
@property (nonatomic,copy) NSString * drawingCode;

/**
 * 图档版本 NVARCHAR(20)
 */
@property (nonatomic,copy) NSString * drawingVersion;

/**
 * 图档标识 NVARCHAR(20)
 */
@property (nonatomic,strong) NSNumber * drawingFlag;//Integer = 0

/**
 * 合格品仓库
 */
@property (nonatomic,copy) NSString * qnWarehouseCode;

/**
 * 不合格品仓库
 */
@property (nonatomic,copy) NSString * noWarehouseCode;

/**
 * 缺陷原因
 */
@property (nonatomic,copy) NSString * defectCauseCode;

/**
 * 物料清单版本
 */
@property (nonatomic,copy) NSString * version;

/**
 * 合格品仓库名称
 */
@property (nonatomic,copy) NSString * qnWarehouseText;

/**
 * 不合格品仓库名称
 */
@property (nonatomic,copy) NSString * noWarehouseText;

/**
 * 企业ID
 */
@property (nonatomic,copy) NSString * enterpriseId;

/**
 * 零件ID
 */
@property (nonatomic,copy) NSString * partsId;

/**
 * 零件版本ID
 */
@property (nonatomic,copy) NSString * partsVersionId;

/**
 * 零件版本号
 */
@property (nonatomic,copy) NSString * partsVersionNo;

/**
 * 鲁村
 */
@property (nonatomic,strong) NSNumber * inventory;//Double

/**
 * 图号
 */
@property (nonatomic,copy) NSString * figureNum;

/**
 * 备注
 */
@property (nonatomic,copy) NSString * remark;

/**
 * 创建人
 */
@property (nonatomic,copy) NSString * createUser;

/**
 * 创建日期
 */
@property (nonatomic,copy) NSString * createDate; // Date

/**
 * 创建时间
 */
@property (nonatomic,copy) NSString * createDateTime; //Date

/**
 * 修改人
 */
@property (nonatomic,copy) NSString * modifyUser;

/**
 * 修改日期
 */
@property (nonatomic,copy) NSString * modifyDate; // Date

/**
 * 修改时间
 */
@property (nonatomic,copy) NSString * modifyDateTime; //Date


@property (nonatomic,copy) NSString * productionControlNum;

@end

NS_ASSUME_NONNULL_END
