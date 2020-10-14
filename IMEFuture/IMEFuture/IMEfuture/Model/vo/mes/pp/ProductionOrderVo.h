//
//  ProductionOrderVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/4.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"
#import "MateriaProcessAssignVo.h"
#import "WorkCenterVo.h"
#import "MaterialVo.h"
#import "ProductionControlVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductionOrderVo : ImeCommonVo

/**
 * 工厂编号
 */
@property (nonatomic,copy) NSString * siteCode;

/**
 * 产品订单编号
 */
@property (nonatomic,copy) NSString * productOrderNum;

/**
 * 产品订单批次编号
 */
@property (nonatomic,copy) NSString * productOrderBatchNum;

/**
 * 订单编号
 */
@property (nonatomic,copy) NSString * productionOrderNum;

/**
 * 项目编号
 */
@property (nonatomic,copy) NSString * projectNum;

/**
 * 项目名称
 */
@property (nonatomic,copy) NSString * projectName;

/**
 * 物料编号
 */
@property (nonatomic,copy) NSString * materialCode;

/**
 * 物料名称
 */
@property (nonatomic,copy) NSString * materialText;

/**
 * 物料规格
 */
@property (nonatomic,copy) NSString * materialSpec;

/**
 * 物料单位
 */
@property (nonatomic,copy) NSString * unit;

/**
 * 订单数量
 */
@property (nonatomic, strong) NSNumber * orderQuantity;

/**
 * 计划数量
 */
@property (nonatomic, strong) NSNumber * plannedQuantity;

/**
 * 已下达数量
 */
@property (nonatomic, strong) NSNumber * releasedQuantity;

/**
 * 完工数量
 */
@property (nonatomic, strong) NSNumber * completedQuantity;

/**
 * 完成率
 */
@property (nonatomic, strong) NSNumber * completedRate;

/**
 * 齐套率值
 */
@property (nonatomic, strong) NSNumber * neatRateNumber;

/**
 * 可投产数量
 */
@property (nonatomic, strong) NSNumber * canProduceQuantity;

/**
 * 结束时间
 */
@property (nonatomic,copy) NSString * plannedendDateTime;

/**
 * 交期
 */
@property (nonatomic,copy) NSString * requirementDate;

/**
 * 开始时间
 */
@property (nonatomic,copy) NSString * plannedstartDateTime;

/**
 * 订单来源
 */
@property (nonatomic,copy) NSString * orderSource;

/**
 * 订单类型
 */
@property (nonatomic,copy) NSString * orderTypeCode;

/**
 * SO工单号
 */
@property (nonatomic,copy) NSString * customerOrder;

/**
 * 创建人
 */
@property (nonatomic,copy) NSString * createUser;

/**
 * 创建时间
 */
@property (nonatomic,copy) NSString * createDateTime;

/**
 * 零件id
 */
@property (nonatomic,copy) NSString * partsId;

/**
 * 零件版本id
 */
@property (nonatomic,copy) NSString * partsVersionId;

/**
 * 零件版本号
 */
@property (nonatomic,copy) NSString * partsVersionNo;

/**
 * 工艺编号
 */
@property (nonatomic,copy) NSString * processCode;

/**
 * 工艺版本
 */
@property (nonatomic,copy) NSString * processRev;

/**
 * 合格品仓库
 */
@property (nonatomic,copy) NSString * qnWarehouseCode;

/**
 * 不合格品仓库
 */
@property (nonatomic,copy) NSString * noWarehouseCode;

/**
 * 图纸云清单id
 */
@property (nonatomic,copy) NSString * drawingBomAccId;

/**
 * 销售单价
 */
@property (nonatomic, strong) NSNumber * price;

/**
 * 客户
 */
@property (nonatomic,copy) NSString * customer;

/**
 * 客户名称
 */
@property (nonatomic,copy) NSString * customerName;

/**
 * 图号
 */
@property (nonatomic,copy) NSString * figureNum;

/**
 * 物料描述
 */
@property (nonatomic,copy) NSString * materialDesc;

/**
 * 工作中心编号
 */
@property (nonatomic,copy) NSString * workCenterCode;

/**
 * 来源单号
 */
@property (nonatomic,copy) NSString * sourceNo;

/**
 * 客户单行号
 */
@property (nonatomic,copy) NSString * customerOrderNum;

/**
 * 采购员
 */
@property (nonatomic,copy) NSString * purchaser;

/**
 * 加工费用
 */
@property (nonatomic, strong) NSNumber * manufactureFee;

/**
 * 材料费用
 */
@property (nonatomic, strong) NSNumber * materialFee;

 /**
 * 单价（不含税）
 */
@property (nonatomic, strong) NSNumber * priceExcludingTax;

/**
 * 对账方式
 */
@property (nonatomic,copy) NSString * statementAccountType;

/**
 * 付款方式
 */
@property (nonatomic,copy) NSString * statementAccountPaymentType;

/**
 * 付款周期
 */
@property (nonatomic,copy) NSString * statementAccountPaymentCycle;

/**
 * 发货企业
 */
@property (nonatomic,copy) NSString * deliveryEnterprise;

/**
 * 物料单位描述
 */
@property (nonatomic,copy) NSString * materialUnitText;

/**
 * 变更来源
 */
@property (nonatomic,copy) NSString * sourceType;

/**
 * 核算价
 */
@property (nonatomic, strong) NSNumber * accountFee;

/**
 * 材料核价
 */
@property (nonatomic, strong) NSNumber * materialAccountFee;

/**
 * 加工核价
 */
@property (nonatomic, strong) NSNumber * manufactureAccountFee;

/**
 * 税率
 */
@property (nonatomic, strong) NSNumber * taxRate;

/**
 * 清单备注
 */
@property (nonatomic,copy) NSString * detailRemark;

/**
 * 零件备注
 */
@property (nonatomic,copy) NSString * materialRemark;

/**
 * 订单日期
 */
@property (nonatomic,copy) NSString * orderDate;

/**
 * 工厂
 */
@property (nonatomic,copy) NSString * factoryName;

/**
 * 备注
 */
@property (nonatomic,copy) NSString * remark;

/**
 * 物料类型描述
 */
@property (nonatomic,copy) NSString * materialTypeText;

/**
 * 优先级Code(前端下拉使用，值同优先级)
 */
@property (nonatomic, strong) NSNumber * priorityCode;

/**
 * 优先级
 */
@property (nonatomic, strong) NSNumber * priority;

/**
 * 物料材质
 */
@property (nonatomic,copy) NSString * materialTextrue;

/**
 * 零件类型
 */
@property (nonatomic, strong) NSNumber * partsType;


@property (nonatomic, copy) NSString * supplierText;

/**
 * 物料编号和名称、项目编号和名称
 */
@property (nonatomic, copy) NSString * parameterCodeAndText;

@property (nonatomic, copy) NSString * createUserName;


/**
 * 物料
 */
@property (nonatomic, strong) MaterialVo * material;


/**
 * 工作中心列表
 */
@property (nonatomic, strong) NSMutableArray <WorkCenterVo *>* workCenterList;//WorkCenter

/**
 * 物料工艺列表
 */
@property (nonatomic, strong) NSMutableArray <MateriaProcessAssignVo *> * materiaProcessAssignList;//MateriaProcessAssign


@property (nonatomic, strong) NSMutableArray <ProductionControlVo *> * productionControlVoList;

@property (nonatomic, strong) NSNumber * isSelect;//0:没选；1:选了。。。获取数据是赋值为0，所以默认为没选

@end

NS_ASSUME_NONNULL_END
