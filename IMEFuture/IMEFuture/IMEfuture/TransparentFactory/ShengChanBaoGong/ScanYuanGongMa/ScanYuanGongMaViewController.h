//
//  ScanYuanGongMaViewController.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReportWorkWorkUnitScanVo;

@interface ScanYuanGongMaViewController : UIViewController

@property (nonatomic,copy) NSString *productionOrderNum;
@property (nonatomic,strong) ReportWorkWorkUnitScanVo *workUnitScanVo;
@property (nonatomic,copy) NSString * requirementDate;


@end
