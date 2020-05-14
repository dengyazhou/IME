//
//  ECOrderCell122.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/1/22.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoHeader.h"

@interface ECOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *view3;

@property (weak, nonatomic) IBOutlet UILabel *orderCode;//流水号：

/**
 * 供应商企业名
 */
@property (weak, nonatomic) IBOutlet UILabel *supplierEnterpriseName;

/**
 * 询盘标题
 */
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *createTime;

/**
 * 期望收货日期
 */
@property (weak, nonatomic) IBOutlet UILabel *deliveryDeadline;

/**
 * 询盘类型
 */
@property (weak, nonatomic) IBOutlet UIImageView *inquiryType;

/**
 * 零件数量
 */
@property (weak, nonatomic) IBOutlet UILabel *count;

/**
 * 总计
 */
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;

/**
 * 采购商状态 tradeOrderPurchaseStatus,供应商状态 tradeOrderSupplierStatus
 */
@property (weak, nonatomic) IBOutlet UILabel *tradeOrderStatus;


@property (weak, nonatomic) IBOutlet UILabel *label06;//订单编号：

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;//32.5和44.5


- (void)initDataWith:(TradeOrder *)tradeOrder andQuanXian:(NSMutableArray *)arrayTypeQuanXian;
@end
