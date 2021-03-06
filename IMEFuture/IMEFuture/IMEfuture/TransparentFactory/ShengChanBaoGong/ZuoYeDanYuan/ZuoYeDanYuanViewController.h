//
//  ZuoYeDanYuanViewController.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/7.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZuoYeDanYuanViewController : UIViewController

@property (nonatomic,copy) NSString *productionOrderNum;
/**
 * 计划工时
 */
@property (nonatomic,strong) NSNumber * planTime;//Double
/**
 * 剩余工时
 */
@property (nonatomic,strong) NSNumber * surplusTime;//Double
/**
 * 作业单元描述
 */
@property (nonatomic,copy) NSString * workUnitText;
/**
 * 工序描述
 */
@property (nonatomic,copy) NSString * operationText;
@property (nonatomic,copy) NSString * operationTextNext;
/**
 * 生产作业单编号
 */
@property (nonatomic,copy) NSString * productionControlNum;
/**
 * 作业单元编号
 */
@property (nonatomic,copy) NSString * workUnitCode;
/**
 * 工序CODE
 */
@property (nonatomic,copy) NSString * operationCode;
/**
 * 工艺工序ID
 */
@property (nonatomic,copy) NSString * processOperationId;
/**
 * 生产确认点
 */
@property (nonatomic,copy) NSString * confirmFlag;


@property (nonatomic,copy) NSString *confirmUser;
@property (nonatomic,copy) NSString * requirementDate;
@property (nonatomic,copy) NSString *personnelName;
@property (nonatomic,strong) NSNumber * workRecordType;


/**
 * 物料编号
 */
@property (nonatomic,copy) NSString * materialCode;
/**
 * 物料描述
 */
@property (nonatomic,copy) NSString * materialText;



//@"项目编号",@"物料名称",@"物料规格",@"工序计划数/完成数"

/**
 * 项目编号
 */
@property (nonatomic,copy) NSString * projectNum;

/**
 * 物料规格
 */
@property (nonatomic,copy) NSString * materialspec;

/**
 * NUMBER(19,3) 计划数量
 */
@property (nonatomic,strong) NSNumber * plannedQuantity;//double

/**
 * NUMBER(19,3) 完工 数量
 */
@property (nonatomic,strong) NSNumber * completedQuantity;//double


@end
