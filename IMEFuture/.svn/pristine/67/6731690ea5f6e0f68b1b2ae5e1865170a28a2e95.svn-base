//
//  ECInquiryCell122.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/1/22.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoHeader.h"

@interface ECInquiryCell122 : UITableViewCell



@property (weak, nonatomic) IBOutlet UIView *view3;

@property (weak, nonatomic) IBOutlet UILabel *labelStatus;

@property (weak, nonatomic) IBOutlet UIButton *buttonL;
@property (weak, nonatomic) IBOutlet UIButton *buttonR;


/**
 * 询盘标题
 */
@property (weak, nonatomic) IBOutlet UILabel *inquiryOrderCodeAndTitle;

/**
 * 工艺
 * 以.工艺名.分割
 */
@property (weak, nonatomic) IBOutlet UILabel *tags;

/**
 * 第一报价数量
 * 第二报价数量
 * 第三报价数量
 */
@property (weak, nonatomic) IBOutlet UILabel *num123;

/**
 * 截止时间
 */
@property (weak, nonatomic) IBOutlet UILabel *endTm;


/**
 * 报价的供应商数量
 */
@property (weak, nonatomic) IBOutlet UILabel *quotationNum;


@property (weak, nonatomic) IBOutlet UIImageView *imageViewType;

/**
 * 零件数量
 */
@property (weak, nonatomic) IBOutlet UILabel *count;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewIsUrgent;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidth;//32.5和44.5

- (void)initDataWith:(InquiryOrder *)inquiryOrder andQuanXian:(NSMutableArray *)arrayTypeQuanXian;


@end
