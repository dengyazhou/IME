//
//  InspectOrderItemVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/16.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InspectOrderItemVo : NSObject

/**
 * 主键
 */
@property(nonatomic,copy) NSString * inspectOrderItemId;
/**
 * 收货单itemid
 */
@property(nonatomic,copy) NSString * receiveOrderItemId;
/**
 * 收货数量
 */
@property(nonatomic,copy) NSString *  receiveNum;
/**
 * 发货单itemid
 */
@property(nonatomic,copy) NSString *  deliverOrderItemId;

/* 订单相关 */
/**
 * 零件号
 */
@property(nonatomic,copy) NSString * partNumber;
/**
 * 规格
 */
@property(nonatomic,copy) NSString * specifications;
/**
 * 零件名
 */
@property(nonatomic,copy) NSString * partName;
/**
 * 物料号
 */
@property(nonatomic,copy) NSString * materialNumber;
/**
 * 品牌
 */
@property(nonatomic,copy) NSString * brand;
/**
 * 物料描述
 */
@property(nonatomic,copy) NSString * materialDescription;
/**
 * 所属项目
 */
@property(nonatomic,copy) NSString * ownProjectName;

/**
 * 验货正品数量（验货单）
 */
@property(nonatomic,strong) NSNumber *qualityQuantity;
/**
 * 验货次品数量（验货单）
 */
@property(nonatomic,strong) NSNumber *defectiveQuantity;
/**
 * 补发货数量（验货单）
 */
@property(nonatomic,strong) NSNumber *reissueQuantity;
/**
 * 是否免检 0-否；1-是
 */
@property(nonatomic,strong) NSNumber *isMianjian;

/**
 * 收货区免检
 */
@property(nonatomic,strong) NSNumber *isReceiveMianjian;
/**
 * 验货类型 默认-抽检（S）
 * 质检类型 S(“抽检”),F(“全检”),E(“免检”),
 */
@property(nonatomic,copy) NSString * qualityInspectType;
@property(nonatomic,copy) NSString * qualityInspectTypeDesc;
/**
 * 可验货数量（验货单） 从发货单带入-展示用
 */
@property(nonatomic,strong) NSNumber *canInspectNum;

/*--质检报告文件start--*/
/**
 * 质检报告文件别名（上传时的文件名称）
 */
@property(nonatomic,copy) NSString * fileName;

/**
 * 质检报告文件的真名
 */
@property(nonatomic,copy) NSString * fileRealName;

/**
 * 质检报告文件路径（全路径 ModuleFilePath表文件路径+FileExplanation表文件子路径）
 */
@property(nonatomic,copy) NSString *  filePath;

/**
 * OSS存储空间名称
 */
@property(nonatomic,copy) NSString * bucketName;

/**
 * 质检报告是否上传
 */
@property(nonatomic,strong) NSNumber *isUploadQualityReport;
/*--质检报告文件end--*/

/**
 * 次品处理方式1
 */
@property(nonatomic,copy) NSString *  defectiveOperateType1;
@property(nonatomic,copy) NSString *  defectiveOperateType1Desc;
/**
 * 返修数量1
 */
@property(nonatomic,strong) NSNumber *reissueNum1;
/**
 * 供应商是否需要补发1 0-否；1-是
 */
@property(nonatomic,strong) NSNumber *isNeedSend1;
/**
 * 不合格类型1
 */
@property(nonatomic,copy) NSString * unType1;
/**
 * 不合格原因1
 */
@property(nonatomic,copy) NSString *  unReason1;

/**
 * 次品处理方式2
 */
@property(nonatomic,copy) NSString * defectiveOperateType2;
@property(nonatomic,copy) NSString *  defectiveOperateType2Desc;
/**
 * 返修数量2
 */
@property(nonatomic,strong) NSNumber *reissueNum2;
/**
 * 供应商是否需要补发2 0-否；1-是
 */
@property(nonatomic,strong) NSNumber *isNeedSend2;
/**
 * 不合格类型2
 */
@property(nonatomic,copy) NSString *  unType2;
/**
 * 不合格原因2
 */
@property(nonatomic,copy) NSString *  unReason2;

/**
 * 次品处理方式3
 */
@property(nonatomic,copy) NSString * defectiveOperateType3;
@property(nonatomic,copy) NSString * defectiveOperateType3Desc;

/**
 * 返修数量3
 */
@property(nonatomic,strong) NSNumber *reissueNum3;

/**
 * 供应商是否需要补发3 0-否；1-是
 */
@property(nonatomic,strong) NSNumber *isNeedSend3;

/**
 * 不合格类型3
 */
@property(nonatomic,copy) NSString * unType3;
/**
 * 不合格原因3
 */
@property(nonatomic,copy) NSString *  unReason3;

/**
 * 次品处理方式4
 */
@property(nonatomic,copy) NSString * defectiveOperateType4;
@property(nonatomic,copy) NSString * defectiveOperateType4Desc;
/**
 * 返修数量4
 */
@property(nonatomic,strong) NSNumber *reissueNum4;
/**
 * 供应商是否需要补发4 0-否；1-是
 */
@property(nonatomic,strong) NSNumber *isNeedSend4;
/**
 * 不合格类型4
 */
@property(nonatomic,copy) NSString * unType4;
/**
 * 不合格原因4
 */
@property(nonatomic,copy) NSString *  unReason4;

/**
 * 次品处理方式5
 */
@property(nonatomic,copy) NSString * defectiveOperateType5;
@property(nonatomic,copy) NSString * defectiveOperateType5Desc;

/**
 * 返修数量5
 */
@property(nonatomic,strong) NSNumber *reissueNum5;

/**
 * 供应商是否需要补发5 0-否；1-是
 */
@property(nonatomic,strong) NSNumber *  isNeedSend5;
/**
 * 不合格类型5
 */
@property(nonatomic,copy) NSString * unType5;
/**
 * 不合格原因5
 */
@property(nonatomic,copy) NSString *  unReason5;

@property(nonatomic, strong) NSNumber *spotCheckNum;

@property(nonatomic, strong) NSNumber *realInspectQuantity;


@property(nonatomic,strong) NSNumber *defaultQuantity;
@property(nonatomic,strong) NSNumber *realQualityQuantity;
@property(nonatomic,strong) NSNumber *downgradeQuantity;
@end

NS_ASSUME_NONNULL_END
