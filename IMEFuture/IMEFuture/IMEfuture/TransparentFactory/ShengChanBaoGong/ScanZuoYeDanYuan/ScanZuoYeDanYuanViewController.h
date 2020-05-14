//
//  ScanZuoYeDanYuanViewController.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanZuoYeDanYuanViewController : UIViewController
/**
 * 生产作业单编号
 */
@property (nonatomic,copy) NSString *productionControlNum;
/**
 * 生产订单编号
 */
@property (nonatomic,copy) NSString *productionOrderNum;
/**
 * 交期
 */
@property (nonatomic,copy) NSString * requirementDate;

/**
 * 报工记录类型 0 正常生产 1 返工返修
 */
@property (nonatomic,strong) NSNumber * workRecordType;//Integer

@end
