//
//  MouldGiveOutDetailCell02.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/4.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MouldGiveOutDetailCell02 : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *viewBg;

/**
 序列号
 */
@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UIButton *buttonLabel0;

/**
 型号
 */
@property (weak, nonatomic) IBOutlet UILabel *label1;
/**
 次数
 */
@property (weak, nonatomic) IBOutlet UILabel *label2;
/**
 总数
 */
@property (weak, nonatomic) IBOutlet UILabel *label3;
/**
 状态
 */
@property (weak, nonatomic) IBOutlet UILabel *label4;

@property (weak, nonatomic) IBOutlet UIImageView *imageView0;

@end

NS_ASSUME_NONNULL_END
