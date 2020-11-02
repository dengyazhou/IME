//
//  MouldProductionDetailCell.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/4.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MouldProductionDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewBg;

/**
 模具编号
 */
@property (weak, nonatomic) IBOutlet UILabel *label0;
/**
 物料编号
 */
@property (weak, nonatomic) IBOutlet UILabel *label1;
/**
 物料名称
 */
@property (weak, nonatomic) IBOutlet UILabel *label2;
/**
 报工时间
 */
@property (weak, nonatomic) IBOutlet UILabel *label3;
/**
 报工时长
 */
@property (weak, nonatomic) IBOutlet UILabel *label4;
/**
 生产数量
 */
@property (weak, nonatomic) IBOutlet UILabel *label5;



@end

NS_ASSUME_NONNULL_END
