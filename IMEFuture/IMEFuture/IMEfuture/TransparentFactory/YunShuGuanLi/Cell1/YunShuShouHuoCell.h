//
//  YunShuShouHuoCell.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/8.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YunShuShouHuoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *ViewWhiteBG;

/**
 物料号
 */
@property (weak, nonatomic) IBOutlet UILabel *label0;

/**
 名称
 */
@property (weak, nonatomic) IBOutlet UILabel *label1;

/**
 单数
 */
@property (weak, nonatomic) IBOutlet UILabel *label2;

/**
 收货数量
 */
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *testFieldSupperView;

@end

NS_ASSUME_NONNULL_END
