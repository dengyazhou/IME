//
//  ProductionControlVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/21.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ImeCommonVo.h"
#import "DrawingPreviewVo.h"

@interface ProductionControlVo : ImeCommonVo

/**
 * 工厂编号
 */
@property (nonatomic,copy) NSString * siteCode;

/**
 * 项目编号
 */
@property (nonatomic,copy) NSString *projectNum;

/**
 * 项目名称
 */
@property (nonatomic,copy) NSString *projectName;

/**
 * 生产订单号
 */
@property (nonatomic,copy) NSString *productionOrderNum;

/**
 * 生产作业号
 */
@property (nonatomic,copy) NSString *productionControlNum;

/**
 * 工艺编号
 */
@property (nonatomic,copy) NSString *processCode;

/**
 * 工艺版本
 */
@property (nonatomic,copy) NSString *processRev;

/**
 * 物料编号
 */
@property (nonatomic,copy) NSString *materialCode;

/**
 * 物料描述
 */
@property (nonatomic,copy) NSString *materialText;

@property (nonatomic,copy) NSString *materialspec;

/**
 * 状态
 * 1    未投产
 * 2    投产                                  按钮：开工
 * 3    报工                                  按钮：报工
 * 4    完成                                  按钮：已完工
 * 5    强制关闭
 * 6    工序投产
 * 7    工序委外
 */
@property (nonatomic,strong) NSNumber * status;//Integer

@property (nonatomic,strong) NSMutableArray * statusArry;//Integer

/**
 * 图号
 */
@property (nonatomic,copy) NSString *figureNum;

/**
 * 订单数量
 */
@property (nonatomic,strong) NSNumber * orderQuantity;//Double

/**
 * 进行中数量
 */
@property (nonatomic,strong) NSNumber * doingQuantity;//Double

/**
 * 计划数量
 */
@property (nonatomic,strong) NSNumber * plannedQuantity;//Double

/**
 * 完工数量
 */
@property (nonatomic,strong) NSNumber * completedQuantity;//Double

/**
 * 报废数量
 */
@property (nonatomic,strong) NSNumber * scrappedQuantity;//Double

/**
 * 当前工序编号
 */
@property (nonatomic,copy) NSString *operationCode;

/**
 * 当前工序描述
 */
@property (nonatomic,copy) NSString *operationText;

/**
 * 作业单元描述
 */
@property (nonatomic,copy) NSString *workUnitText;

/**
 * 操作人
 */
@property (nonatomic,copy) NSString *confirmUser;

/**
 * 客户
 */
@property (nonatomic,copy) NSString *customer;

/**
 * 客户名称
 */
@property (nonatomic,copy) NSString *customerText;

/**
 * 客户订单
 */
@property (nonatomic,copy) NSString *customerOrder;

/**
 * 交期
 */
@property (nonatomic,copy) NSString * requirementDate;//Date

/**
 * 剩余天数
 */
@property (nonatomic,strong) NSNumber * surplusDays;//Integer

/**
 * 项目编号、名称、物料编号、名称
 */
@property (nonatomic,copy) NSString *text;

/**
 * 开始日期
 */
@property (nonatomic,copy) NSString * startDate;//Date

/**
 * 结束日期
 */
@property (nonatomic,copy) NSString * endDate;//Date

/**
 * 采购商企业id
 */
@property (nonatomic,copy) NSString *purchaseEnterpriseId;

/**
 * 供应商企业id
 */
@property (nonatomic,copy) NSString *supplierEnterpriseId;

/**
 * 图纸云清单id
 */
@property (nonatomic,copy) NSString *drawingBomAccId;

/**
 * 零件id
 */
@property (nonatomic,copy) NSString *partsId;

/**
 * 零件版本id
 */
@property (nonatomic,copy) NSString *partsVersionId;

/**
 * 零件版本号
 */
@property (nonatomic,copy) NSString *partsVersionNo;

/**
 * 订单类型
 */
@property (nonatomic,copy) NSString *orderSource;

/**
 * 计划开始日期
 */
@property (nonatomic,copy) NSString * plannedStartDate;//Date

/**
 * 计划结束日期
 */
@property (nonatomic,copy) NSString * plannedEndDate;//Date

/**
 * 计划结束时间
 */
@property (nonatomic,copy) NSString * plannedendDateTime;//Date

/**
 * 实际开始日期
 */
@property (nonatomic,copy) NSString * actualStartDate;//Date

/**
 * 实际结束日期
 */
@property (nonatomic,copy) NSString * actualEndDate;//Date

/**
 * 完成率
 */
@property (nonatomic,copy) NSString *completedRate;

/**
 * 合格率
 */
@property (nonatomic,copy) NSString *qualifiedRate;

/**
 * 缺陷原因
 */
@property (nonatomic, strong) NSMutableArray <NSString * > * defectCauseList;

/**
 * 投产时间
 */
@property (nonatomic,copy) NSString * placeOrderDateTime;

/**
 * 图纸云缩略图
 */
@property (nonatomic, strong) NSMutableArray <DrawingPreviewVo * > *  drawingPreviewVoList;//DrawingPreviewVo

/**
 * 工作中心
 */
@property (nonatomic,copy) NSString *workCenterCode;

/**
 * 来源单号
 */
@property (nonatomic,copy) NSString *sourceNo;

/**
 * 是否超期 1 超期 0 不超期
 */
@property (nonatomic,strong) NSNumber * isOverTime;//int

/**
 * 工序类型
 */
@property (nonatomic,copy) NSString *operationTypeEcode;

//==== 看板配置使用 ====
/**
 * 工单数（完工数/计划数）
 */
@property (nonatomic,copy) NSString *completedQuantityAndPlannedQuantity;

/**
 * 当前工序/总工序
 */
@property (nonatomic,copy) NSString *currentOperationAndTotalOperation;

/**
 * 模具型号
 */
@property (nonatomic,copy) NSString *mouldCode;

@property (nonatomic, copy) NSString *parameterCodeAndText;

@property (nonatomic, copy) NSString *plannedstartDateTime;

@property (nonatomic, strong) NSNumber * isSelect;//0:没选；1:选了。。。获取数据是赋值为0，所以默认为没选

@end
