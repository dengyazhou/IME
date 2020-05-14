//
//  BaoJiaZiXunCell.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/5.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaoJiaZiXunCell : UITableViewCell

/**
 * 企业名
 */
@property (weak, nonatomic) IBOutlet UILabel *enterpriseName;

@property (weak, nonatomic) IBOutlet UILabel *createTime;

@property (weak, nonatomic) IBOutlet UILabel *labelQ;
@property (weak, nonatomic) IBOutlet UILabel *labelA;

@property (weak, nonatomic) IBOutlet UIButton *buttonHuida;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewA;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewBottomLineLeft;
@end
