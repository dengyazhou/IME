//
//  MouldGiveOutCell.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/3.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MouldGiveOutCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIView *viewBg;

@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
/**
计划时间
 */
@property (weak, nonatomic) IBOutlet UILabel *label6;
/**
投产时间
 */
@property (weak, nonatomic) IBOutlet UILabel *label7;
/**
 模具数量
 */
@property (weak, nonatomic) IBOutlet UILabel *label8;
/**
 可用数量
 */
@property (weak, nonatomic) IBOutlet UILabel *label9;
/**
 已发数量
 */
@property (weak, nonatomic) IBOutlet UILabel *label10;


@end

NS_ASSUME_NONNULL_END
