//
//  MouldGiveInCell.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/4.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MouldGiveInCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *viewBg;

/**
 产品编号
 */
@property (weak, nonatomic) IBOutlet UILabel *label0;
/**
 产品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *label1;
/**
 工单数量
 */
@property (weak, nonatomic) IBOutlet UILabel *label2;
/**
 完工数量
 */
@property (weak, nonatomic) IBOutlet UILabel *label3;
/**
 模具数量
 */
@property (weak, nonatomic) IBOutlet UILabel *label4;


@end

NS_ASSUME_NONNULL_END
